# .zshrc is sourced for interactive shells

zdebug in ~/.zshrc

autoload -U compinit && compinit

source ~/.zsh/git-prompt/zshrc.sh

export GIT_CEILING_DIRECTORIES=$HOME
export DISPLAY=localhost:0.0
export CLICOLOR=1
export LSCOLORS='Cxfxcxdxbxegedabagacad'

BAUD=0

# *** set the prompt

precmd () {print -Pn "\e]2; %~/ \a"}
preexec () {print -Pn "\e]2; %~/ \a"}


PROMPT='%B%(2L.>> .)%n@%m:%30<...<%~%<<>%b$(git_super_status) '
RPROMPT='[%?]'

# Automatically report the time of long running commands
REPORTTIME=1
#TMOUT=300

# *** Set up editing environment
VI=/usr/bin/vi
GUI=/Users/mlaster/bin/subl
if [ "$TERM_PROGRAM" = "Apple_Terminal" -a -x $GUI ]; then
  export EDITOR=$VI
  export CVSEDITOR=$GUI
  export SVN_EDITOR=$GUI
else
  export EDITOR=$VI
fi

# *** configure watchlist
watch=(all)

# *** configure history
HISTSIZE=2000
SAVEHIST=1000
HISTFILE=~/.history

# *** configure zsh key bindings
bindkey "^R" history-incremental-search-backward

# *** configure zsh options
setopt APPEND_HISTORY
setopt AUTO_CD
setopt AUTO_CONTINUE
setopt AUTO_LIST
setopt AUTO_PUSHD
setopt AUTO_RESUME
setopt NO_BG_NICE
setopt COMPLETE_IN_WORD
setopt CORRECT
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt NO_LIST_BEEP
setopt LIST_PACKED
setopt LONG_LIST_JOBS
setopt MAIL_WARNING
setopt PATH_DIRS
setopt PRINT_EIGHT_BIT
setopt PRINT_EXIT_VALUE
setopt PUSHD_IGNORE_DUPS
setopt SHARE_HISTORY
setopt TRANSIENT_RPROMPT

alias sha1='/usr/bin/openssl sha1'

title() { echo -n -e "\033]0;$*\007" }
