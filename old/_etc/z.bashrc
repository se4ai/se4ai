#!/usr/bin/env bash
Shel=${Shel:=$(git rev-parse --show-toplevel)/docs/_etc}

pathadd() {
      if  [[ ":$PATH:" != *":$1:"* ]]; then
          export PATH="${PATH:+"$PATH:"}$1"
      fi
}
pathadd /usr/local/bin

uname="$(uname -s)"
#for i in sbcl clisp tmux htop; do
#  case "${uname}" in
#      Linux*)     
#        which $i > /dev/null || sudo apt get $i;;
#      Darwin*)    
#        which $i > /dev/null || brew install $i;;
#      *) echo "UNKNOWN:${uname}"; exit 1;;
#  esac
#done
#
_c0="\033[00m"     # white
_c1="\033[01;32m"  # green
_c2="\033[01;34m"  # blue
_c3="\033[31m"     # red
_c5="\033[35m"     # purple
_c6="\033[33m"     # yellow
_c7="\033[36m"     # turquoise
_c8="\033[96m"     # magenta

here() { cd $1; basename "$PWD"; }

PROMPT_COMMAND='echo -ne "${_c2}se4ai ${_c0}${_c0}:${_c6}$(git branch 2>/dev/null | grep '^*' | colrm 1 2) \033]0; $(here ..)/$(here .)\007";PS1="${_c1}$_c2$(here ..)/$_c3$(here .) ${_c6}\!>${_c0}\e[m "'

blank() {
cat<<EOF
;; vim: ts=2 sw=2 sts=2  et :
;--------- --------- --------- --------- --------- ---------

EOF
}

gfig() {
  git config --global credential.helper cache
  git config credential.helper 'cache --timeout=3600'
}

imports() {
  rm -rf imports.py
  for i in $(ls *.py | grep -v demo.py); do
    echo "from $i import *" >> imports.py
  done
}

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias get='git pull'
alias grep='grep --color=auto'
alias put='git commit -am saving; git push; git status'
alias vi="vim -u $Shel/z.vimrc "
alias py="$(which python3) -B  "
alias tmux="$(which tmux) -f $Shel/z.tmuxrc "
case "${uname}" in
      Linux*)     
        alias ls='ls --color=auto';;
      Darwin*)    
        alias ls='ls -G' ;;
      *) ;;
esac

alias reload=". $Shel/z.bashrc"
echo -e "\e[96mse4ai v2.0 (c) 2019 <timm@ieee.org> "
