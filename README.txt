
git clone https://github.com/Motyak/bash-utils.git ~/.local/share/bash-utils

# to install bash prompt, what and goin..
# .., add the following to ~/.bashrc :
```
source ~/.local/share/bash-utils/prompt.sh
alias what='source ~/.local/share/bash-utils/what.sh'
alias goin='source ~/.local/share/bash-utils/goin.sh'
```

# to install xor :
ln -fs "$(realpath ~/.local/share/bash-utils/xor.pl)" ~/.local/bin/xor
