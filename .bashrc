
export MYVIMRC="~/.vimrc"
source /Users/danielcrompton/.travis/travis.sh
alias tma='tmux attach -d -t'
#alias tmux-new='tmux new -s $(basename $(pwd))'
alias tmux-new='tmux new-session -d -s $(basename $(pwd)) \; split-window -h \; split-window -v \; select-pane -t 0 \; attach'
alias tmux-dev='tmux new-session -d -s $(basename $(pwd)) \; split-window -h \;  splitw -v -p 50 -t 1 ". bin/exports ; bundle exec guard" \; splitw -v -p 50 -t 2 "irc webhat -c \#bofh\ p03k03,\#oplerno\ p03k03" \; select-pane -t 0 \; attach'
export PATH="~/bin/:$PATH"


# Powerline
export PATH="$PATH:/Users/danielcrompton/Development/powerline/scripts"
export POWERLINE_COMMAND="/Users/danielcrompton/Development/powerline/scripts/powerline"
. /Users/danielcrompton/Development/powerline/powerline/bindings/bash/powerline.sh

function lt() { ls -ltrsa "$@" | tail; }
function psgrep() { ps -axf | grep -v grep | grep "$@" -i --color=auto; }
function fname() { find . -iname "*$@*"; }
function remove_lines_from() { grep -F -x -v -f $2 $1; } #removes lines from $1 if they appear in $2
alias pp="ps -axf | less"
alias sum="xargs | tr ' ' '+' | bc" ## Usage: echo 1 2 3 | sum
function mcd() { mkdir $1 && cd $1; }
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
