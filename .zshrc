# localo
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"


ZSH_THEME="powerline"
# Powerline theme config
POWERLINE_RIGHT_A="exit-status"
POWERLINE_USER_NAME="%n"
POWERLINE_RIGHT_B="none"
POWERLINE_SHOW_GIT_ON_RIGHT="true"
POWERLINE_HIDE_HOST_NAME="true"
POWERLINE_NO_BLANK_LINE="true"
POWERLINE_DETECT_SSH="true"

POWERLINE_GIT_CLEAN="✔"
POWERLINE_GIT_DIRTY="✘"
POWERLINE_GIT_ADDED="%F{green}✚%F{black}"
POWERLINE_GIT_MODIFIED="%F{blue}✹%F{black}"
POWERLINE_GIT_DELETED="%F{red}✖%F{black}"
POWERLINE_GIT_UNTRACKED="%F{yellow}✭%F{black}"
POWERLINE_GIT_RENAMED="➜"
POWERLINE_GIT_UNMERGED="═"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
export HIST_STAMPS="mm/dd/yyyy"
export HISTSIZE=9999999999
export HISTFILE=~/.zsh_history
export HIST_EXPIRE_DUPS_FIRST=1

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rails ruby tmux redis-cli git-flow git-extras tmuxinator bundler vagrant sudo zsh-syntax-highlighting radare2 docker)

# User configuration

export PATH="/opt/local/bin/:/opt/local/lib/mysql56/bin/:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
#source .powerline/

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

ignore() { echo $1 >> .gitignore }

# Modified from original: http://chneukirchen.org/blog/archive/2012/02/10-new-zsh-tricks-you-may-not-know.html
_OPTLOCALBINVIM=/opt/local/bin/vim
if [[ -a $_OPTLOCALBINVIM ]]; then
  alias vim=$_OPTLOCALBINVIM
  alias vi=$_OPTLOCALBINVIM

  foreground-vi() {
    fg %$_OPTLOCALBINVIM
  }

  zle -N foreground-vi
  bindkey '^Z' foreground-vi
fi


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
# Use MacPorts SSH not OSX's default
if [ -f /opt/local/bin/ssh ] ; then
  alias ssh=/opt/local/bin/ssh
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

# Found: http://chneukirchen.org/blog/archive/2012/02/10-new-zsh-tricks-you-may-not-know.html
zman() {
  PAGER="less -g -s '+/^       "$1"'" man zshall
}

# Watch
function watch() { while true ; do clear ; $@ ; sleep 1 ; done }

# tmux pane completion found:
# http://blog.plenz.com/2012-01/zsh-complete-words-from-tmux-pane.html
_tmux_pane_words() {
  local expl
  local -a w
  if [[ -z "$TMUX_PANE" ]]; then
    _message "not running inside tmux!"
    return 1
  fi
  w=( ${(u)=$(tmux capture-pane \; show-buffer \; delete-buffer)} )
  _wanted values expl 'words from current tmux pane' compadd -a w
}

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^Xt' tmux-pane-words-prefix
bindkey '^X^X' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'

alias mux="~/.rvm/gems/ruby-*/gems/tmuxinator-*/bin/mux"

# Rails

alias -g DBM='DB=mysql'
alias -g DBS='DB=sqlite'
alias -g DBP='DB=postgres'
# TODO: Aliases for Mongo and neo4j here

# Expand git aliasos
alias gt='g tree'
unalias gf
alias gf='git flow'
alias gfi='gf init'
alias gff='gf feature'
alias gfr='gf release'
alias gfh='gf hotfix'
alias gfs='gf support'
alias gfv='gf version'
unalias gca
alias gca='git commit -v -a -S'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

# Found: http://chneukirchen.org/blog/archive/2012/02/10-new-zsh-tricks-you-may-not-know.html
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

export DIRSTACKSIZE=30
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Go Lang
if [ -z "$DEVEL_GO" ] ;then
  export PATH="$PATH:/usr/local/go/bin"
  export GOROOT="/usr/local/go/"
else
  export PATH="$HOME/Development/go/bin:$PATH"
  export GOROOT="$HOME/Development/go"
fi

# Android
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# CyanogenMod
export USE_CCACHE=1

# Setup Keyboard
# for Dvorak?
# From: http://ubuntuforums.org/showthread.php?t=1710325&p=10668853#post10668853
function dvorak_firsttime() {
  echo Run: sudo dpkg-reconfigure keyboard-configuration
}
# Other aliases
alias bc='bc -wlq'
