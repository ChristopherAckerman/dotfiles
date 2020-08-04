alias sshs="ssh ackermch@supply.mit.edu"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias skim="open -a skim"

set editing-mode vi
set keymap vi-command

export EDITOR='nvim'
export TERMINAL='alacritty'
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

PATH="$PATH:/usr/local/stata15/"
PATH="$PATH:/home/chris/.local/bin/"
export PATH
