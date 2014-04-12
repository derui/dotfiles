# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

export PERL_LOCAL_LIB_ROOT="/home/derui/perl5";
export PERL_MB_OPT="--install_base /home/derui/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/derui/perl5";
export PERL5LIB="/home/derui/perl5/lib/perl5/i686-linux:/home/derui/perl5/lib/perl5";
export PATH="/home/derui/perl5/bin:$PATH";
export PATH=~/bin:$PATH;

export PATH=/mnt/home/derui/bin/Sencha/Cmd/3.0.2.288:$PATH

export SENCHA_CMD_3_0_0="/home/derui/bin/Sencha/Cmd/4.0.0.203"

export GOROOT=$HOME/work/go
export GOPATH=$HOME/develop/go-workspace

export PATH=$GOROOT/bin:$GOPATH/bin:/home/derui/bin/Sencha/Cmd/4.0.0.203:$PATH
