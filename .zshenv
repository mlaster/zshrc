# .zshenv is sourced for all invocations of zsh.  Be sure not put anything
# in here only necessary for interactive shells, as it will slow down scripts

ZDEBUG=0

umask 0022

export LC_CTYPE="en_US.UTF-8"

# *** script debug script ***
zdebug()
{
	if (($ZDEBUG)); then
	{
		if [[ -o interactive ]]; then
			echo "ZDEBUG: $*"
		fi
	}
	fi
}

zdebug in ~/.zshenv

if [ $_BOUNCE_FROM_TCSH ]; then
	zdebug "zsh bounced from (t)csh"
	#export _BOUNCE_FROM_TCSH=
	export SHELL=/bin/zsh
	SHLVL=1
fi

# *** setup my search path if necessary
if [ ! $_ZPATH_SETUP ]; then
	zdebug "Initial PATH: $PATH"
	export PATH=~/bin:~/Projects/git/devtools:/usr/local/bin:/usr/local/sbin:$PATH
	zdebug "PATH set to $PATH"
	export _ZPATH_SETUP=1
fi

# *** Setup environment variables
export CVS_RSH=/usr/bin/ssh
export RSYNC_RSH=/usr/bin/ssh
export RUBYLIB=$HOME/lib/ruby
export GREP_OPTIONS='--color'

if [ -d /usr/local/lib/ruby/gems -o -d /usr/lib/ruby/gems ]; then
    export RUBYOPT=-rubygems
fi

export UDID_TELLURIDE='8245f90ffcb3f0031fe872d4b15badb4433953a8'
