alias 7z-ultra='7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on'
alias ap=ansible-playbook
alias aves='ansible-vault encrypt_string'
alias bv=bumpversion
alias e='emacsclient -n'
alias g=git
alias h='history --max=10 --reverse'
alias k=keys
alias m=make
alias p=gopass
alias gp=gopass
alias x='xargs -I {}'
alias otp="gopass otp -c (cd $HOME/.local/share/gopass/stores/root && find . -name otp.gpg | sed 's/\.gpg//'  |sed 's/\.\///' | fzf --exact)"
alias gpf="gopass -c (gopass find . | fzf --exact)"
alias open-this-repo="open (git remote -v | awk '{print \$2}' | sort | uniq | fzf --exact)"
