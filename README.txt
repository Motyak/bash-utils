
git clone https://github.com/Motyak/bash-utils.git ~/.local/share/bash-utils

# to install bash prompt, what and goin :
source ~/.local/share/bash-utils/prompt.sh
alias what='source ~/.local/share/bash-utils/what.sh'
alias goin='source ~/.local/share/bash-utils/goin.sh'
# (add the above lines into your ~/.bashrc to persist the change)

# to install xor :
ln -fs "$(realpath ~/.local/share/bash-utils/xor.pl)" ~/.local/bin/xor
