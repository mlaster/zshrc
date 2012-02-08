# .zshrc is sourced for interactive shells

#
# Remove ~/._zdistserver to enable .z* distribution
#

zdebug in ~/.zshrc

export GIT_CEILING_DIRECTORIES=$HOME
export DISPLAY=localhost:0.0
export CLICOLOR=1
export LSCOLORS='Cxfxcxdxbxegedabagacad'

BAUD=0

# Enable UTF-8 display on the command line
export LC_CTYPE=en_US.UTF-8

# *** set the prompt
PROMPT='%B%(2L.>> .)%n@%m:%~>%b '
RPROMPT='[%?]'

# Automatically report the time of long running commands
REPORTTIME=1
#TMOUT=300

# *** Set up editing environment
VI=/usr/bin/vi
GUI=/Users/mlaster/bin/mate.sh
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
HISTSIZE=1000
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
setopt NO_LIST_BEEP
setopt LIST_PACKED
setopt LONG_LIST_JOBS
setopt MAIL_WARNING
setopt PATH_DIRS
setopt PRINT_EIGHT_BIT
setopt PRINT_EXIT_VALUE
setopt PUSHD_IGNORE_DUPS
setopt TRANSIENT_RPROMPT

export USE_FINK=NO
export USE_MACPORTS=YES

# Add fink paths
if [ "$USE_FINK" = "YES" ]; then
    if [ -f /sw/bin/init.sh ]; then
        . /sw/bin/init.sh
        #if [ $SHLVL -eq 1 ]; then
        #   echo "* Fink enabled *"
        #fi
    fi
else
    if [ -f /sw/bin/init.sh ]; then
        alias finkenable=". /sw/bin/init.sh ; unalias finkenable"
    fi
fi

# Add MacPorts paths
local MACPORTS_BASE=/opt/macports
if [ "$USE_MACPORTS" = "YES" ]; then
    if [ -d $MACPORTS_BASE ]; then
        export PATH=$MACPORTS_BASE/bin:$MACPORTS_BASE/sbin:$PATH
        export MANPATH=$MACPORTS_BASE/share/man:$MANPATH
        if [ $SHLVL -eq 1 ]; then
           echo "* MacPorts enabled *"
        fi
    fi
else
    if [ -d $MACPORTS_BASE ]; then
        alias macportsenable="export PATH=$MACPORTS_BASE/bin:$MACPORTS_BASE/sbin:$PATH ; export MANPATH=$MACPORTS_BASE/share/man:$MANPATH ;  unalias macportsenable"
    fi
fi

alias sha1='/usr/bin/openssl sha1'

title() { echo -n -e "\033]0;$*\007" }

#
# Allow per-directory umask settings
#

typeset -g default_umask
typeset -Ag umask
default_umask=$(umask)

if [ -r ~/.umask_hash ]; then
  . ~/.umask_hash
fi

umask ()
{
  if [[ $# -ne 0 ]]; then
    custom=0
    set -A keys ${(k)umask[@]}

    for key in $keys; do
      if [[ $PWD == ${key}** ]]; then
        custom=1
        break
      fi
    done

    if [[ $custom == 0 ]]; then
      _orig_umask=$1
    fi

    _before_umask=$(builtin umask)
    if [ $_before_umask != $* ] ; then
      echo "umask $_before_umask => $*" >& 2
    fi
  fi
  builtin umask $*
}

chpwd ()
{
    # Don't override behavior for root
    if [[ "`whoami`" == "root" ]]; then
      return
    fi
    set -A keys ${(k)umask[@]}
    um=
    for key in $keys; do
        if [[ $PWD == ${key}** ]]; then
            um=${umask[${key}]}
            break
        fi
    done

    if [[ -z $um ]]; then
        if [[ -z $_orig_umask ]]; then
          um=$default_umask
        else
          um=$_orig_umask
        fi
    fi

    umask $um
}
