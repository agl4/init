#!/usr/bin/env bash
#
# Create a LUKS2-encrypted ext4 disk image file (or attach an existing one)
# and set it up as a loop device via udisks.
#
# Usage: luks-create-disk-image.sh -f FILE [-s SIZE_MB] [-l MAPPER_NAME]
#                                  [-c CIPHER] [-i ITER_TIME_MS]
#
set -euo pipefail
IFS=$'\n\t'
umask 077                     # image file is created 0600
export LC_ALL=C
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

readonly MAX_SIZE_MB=$((1024 * 1024))   # 1 TiB sanity cap
readonly MIN_ITER_TIME=2000             # cryptsetup default; don't go weaker

FILENAME=
LUKSNAME=
SIZE=1024
CIPHER=serpent-xts-plain64
ITER_TIME=5000

created=0     # we created the image file
completed=0   # image creation finished successfully
opened=0      # the dm-crypt mapping is open

die() { printf 'Error: %s\n' "$*" >&2; exit 1; }

usage() {
    cat <<EOF
Usage: ${0##*/} -f FILE [-s SIZE_MB] [-l MAPPER_NAME] [-c CIPHER] [-i ITER_TIME_MS]
  -f FILE         image file to create or attach (required)
  -s SIZE_MB      size in MiB for a new image (default: $SIZE)
  -l NAME         device-mapper name (default: basename of FILE)
  -c CIPHER       aes-xts-plain64 | serpent-xts-plain64
                  (default: $CIPHER)
  -i MS           PBKDF time cost in ms, >= $MIN_ITER_TIME (default: $ITER_TIME)
EOF
}

cleanup() {
    local rc=$?
    trap - EXIT
    if (( opened )); then
        sudo cryptsetup close "$LUKSNAME" || true
    fi
    if (( created && ! completed )); then
        printf 'Removing incomplete image %s\n' "$FILENAME" >&2
        rm -f -- "$FILENAME"
    fi
    exit "$rc"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM HUP

while getopts ':i:s:l:f:c:h' opt; do
    case $opt in
        i) ITER_TIME=$OPTARG ;;
        s) SIZE=$OPTARG ;;
        f) FILENAME=$OPTARG ;;
        l) LUKSNAME=$OPTARG ;;
        c)
            case $OPTARG in
                # twofish dropped: key-dependent S-box tables (cache-timing
                # side channels), slowest, and no security benefit.
                aes-xts-plain64|serpent-xts-plain64)
                    CIPHER=$OPTARG ;;
                *) die "Invalid cipher: $OPTARG" ;;
            esac
            ;;
        h) usage; exit 0 ;;
        :) die "Option -$OPTARG requires an argument" ;;
        \?) usage >&2; die "Unknown option: -$OPTARG" ;;
    esac
done
shift $((OPTIND - 1))
(( $# == 0 )) || die "Unexpected argument(s): $*"

for cmd in cryptsetup mkfs.ext4 udisksctl dd realpath losetup sudo; do
    command -v "$cmd" >/dev/null || die "Required command not found: $cmd"
done

# --- validate input --------------------------------------------------------

[[ -n $FILENAME ]] || { usage >&2; die "Missing option -f FILE"; }

[[ $SIZE =~ ^[1-9][0-9]{0,8}$ ]] && (( SIZE <= MAX_SIZE_MB )) \
    || die "Invalid size '$SIZE' (1..$MAX_SIZE_MB MiB)"

[[ $ITER_TIME =~ ^[1-9][0-9]{0,6}$ ]] && (( ITER_TIME >= MIN_ITER_TIME )) \
    || die "Invalid iter-time '$ITER_TIME' (integer ms >= $MIN_ITER_TIME)"

# Never operate through a symlink (could redirect writes to another file).
[[ ! -L $FILENAME ]] || die "Refusing to use symlink: $FILENAME"

# Absolute path: no leading '-' can ever be parsed as an option downstream.
FILENAME=$(realpath -m -- "$FILENAME")

LUKSNAME=${LUKSNAME:-$(basename -- "$FILENAME")}
[[ $LUKSNAME =~ ^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$ ]] \
    || die "Invalid mapper name '$LUKSNAME' (use -l with [A-Za-z0-9._-], max 64 chars)"

# --- attach existing image -------------------------------------------------

if [[ -e $FILENAME ]]; then
    [[ -f $FILENAME ]] || die "Not a regular file: $FILENAME"
    cryptsetup isLuks --type luks2 "$FILENAME" \
        || die "Not a LUKS2 image: $FILENAME"

    if [[ -n $(losetup -j "$FILENAME") ]]; then
        printf 'Already attached:\n%s\n' "$(losetup -j "$FILENAME")"
    else
        udisksctl loop-setup -f "$FILENAME"
    fi
    printf '%s\n' "$FILENAME"
    exit 0
fi

# --- create new image ------------------------------------------------------

[[ -d $(dirname -- "$FILENAME") ]] || die "Directory does not exist: $(dirname -- "$FILENAME")"
[[ ! -e /dev/mapper/$LUKSNAME ]] || die "Mapper device already exists: /dev/mapper/$LUKSNAME"

# Atomic exclusive create (O_EXCL): fails if the file appeared meanwhile,
# including a planted symlink - closes the check/create race.
( set -o noclobber; : > "$FILENAME" ) 2>/dev/null \
    || die "Cannot create (already exists?): $FILENAME"
created=1

# Fill with random data so used vs. unused space is indistinguishable.
# /dev/urandom is cryptographically equivalent to /dev/random on modern
# kernels; iflag=fullblock prevents short reads producing a truncated image.
dd if=/dev/urandom of="$FILENAME" bs=1M count="$SIZE" \
    iflag=fullblock conv=notrunc,fsync status=progress

# Crypto parameters:
#  - XTS with --key-size 512 = two 256-bit keys (AES-256 / Serpent-256).
#  - 4096-byte encryption sectors: aligned with ext4 blocks, fewer IVs, faster.
#  - argon2id (memory-hard KDF), memory cost pinned to 1 GiB (the LUKS2
#    maximum default) so a distro/default change can't silently weaken it;
#    note the image then needs ~1 GiB free RAM to unlock.
sudo cryptsetup luksFormat \
    --type luks2 \
    --cipher "$CIPHER" \
    --key-size 512 \
    --sector-size 4096 \
    --hash sha512 \
    --pbkdf argon2id \
    --pbkdf-memory 1048576 \
    --pbkdf-parallel 4 \
    --iter-time "$ITER_TIME" \
    --use-random \
    --verify-passphrase \
    --verbose \
    "$FILENAME"

sudo cryptsetup open --type luks2 "$FILENAME" "$LUKSNAME"
opened=1

# Root dir owned by the invoking user, so no chmod 777 is needed later.
sudo mkfs.ext4 -q -m 0 \
    -L "${LUKSNAME:0:16}" \
    -E "root_owner=$(id -u):$(id -g)" \
    "/dev/mapper/$LUKSNAME"

sudo cryptsetup close "$LUKSNAME"
opened=0
completed=1

udisksctl loop-setup -f "$FILENAME"
