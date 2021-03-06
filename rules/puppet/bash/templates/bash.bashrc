# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
                elif [ -x /usr/share/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

if [ "$(id -u)" = 0 ] || (groups | fgrep -qw puavoadmins); then
  if [ "$(id -u)" = 0 ]; then
    # Red prompt for root.
    PS1="\[\e[1;31m\][<%= scope.lookupvar('config::organisation') %>] \u@\h:\w\$\[\e[0m\] "
  else
    # Magenta prompt for puavoadmins.
    PS1="\[\e[1;35m\][<%= scope.lookupvar('config::organisation') %>] \u@\h:\w\$\[\e[0m\] "
  fi

  # automatic logout if shell is idle for 30 minutes
  TMOUT=1800
fi

# turn on fancy bash history timestamps
HISTTIMEFORMAT='%d.%m.%Y - %T '
HISTFILESIZE=10000
HISTSIZE=5000
export HISTTIMEFORMAT HISTFILESIZE HISTSIZE
