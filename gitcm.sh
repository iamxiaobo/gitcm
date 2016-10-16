#!/bin/bash

gitcm_read_input() {
  while read content
  do
    if [ -n "$content" ]; then
      break
    fi
  done

  echo $content
}

gitcm_ls() {
  local dirpath="$(gitcm_find_gitcmrc .gitcmrc)"

  if [ -e "$dirpath/.gitcmrc" ]; then
    echo "$(cat $dirpath/.gitcmrc)"
  else
    echo ".gitcmrc not found, want to init one? Please input gitcm init"
  fi
}

gitcm_use() {
  local dirpath="$(gitcm_find_gitcmrc .gitcmrc)"  

  if [ -e "$dirpath/.gitcmrc" ]; then
    eval "$(cat $dirpath/.gitcmrc)"

    if [ -n "$name" ] && [ "$(git config user.name)" != "$name" ]; then
      git config user.name $name 2>/dev/null
    fi

    if [ -n "$email" ] && [ "$(git config user.email)" != "$email" ]; then
      git config user.email $email 2>/dev/null
    fi
  fi
}

gitcm_init_gitcmrc() {
  echo "Enter your user.name in .gitcmrc"
  name="$(gitcm_read_input name)"
  echo "Enter your user.email in .gitcmrc"
  email="$(gitcm_read_input email)"

  echo "name=${name}\nemail=${email}" > .gitcmrc

  if [ "$?" == 0 ]; then
    echo "init done"
  else
    echo "something wrong happened"
  fi
}

gitcm_find_gitcmrc() {
  local pathdir
  pathdir="${PWD}"
  while [ "${pathdir}" != "" ] && [ ! -f "${pathdir}/${1-}" ]; do
    pathdir=${pathdir%/*}
  done

  echo "${pathdir}"
}

gitcm_use_gitcmrc() {
}

gitcm() {
  if [ $# -lt 1 ]; then
    gitcm --help
    return
  fi

  local COMMAND="${1-}"
  shift

  case $COMMAND in
    "help" | "--help" )
      echo "Git Config Manager"
      echo  
      echo "Usage:"
      echo "  gitcm --help
      Show this message"
      echo "  gitcm --version
      Print out the current version of gitcm"
      echo "  gitcm init
      Init .gitcmrc in current directory by interactive shell"
      echo "  gitcm use
      Active the content of .gitcmrc in current Git repository, if .gitcmrc not found in current direcyory, will lookup .gitcmrc from parent directory to root until the .gitcmrc is found. Nothing would happened if search failed."
      echo "  gitcm ls
      Print out the current .gitcmrc contnet"
      ;;

    "init" )
      gitcm_init_gitcmrc
      ;;

    "use" )
      gitcm_use
      ;;

    "ls" )
      gitcm_ls
      ;;  
    * )
      gitcm --help
    ;;
  esac
}

load-gitcm() {
  gitcm use
}
