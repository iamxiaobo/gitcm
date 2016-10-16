#!/bin/bash

gitcm_dir="$HOME/.gitcm"

source_gitcm() {
  touch $HOME/.bashrc
  gitcm_dir="$HOME/.gitcm"
  source_str="export GITCM_DIR=\"$gitcm_dir\"\n[ -s \"\$GITCM_DIR/gitcm.sh\" ] && source \"\$GITCM_DIR/gitcm.sh\""

  if [ -z "$(grep $source_str $HOME/.bashrc)" ]; then
    echo $source_str >> $HOME/.bashrc 2>/dev/null
  fi

  source $HOME/.bashrc
}

if [ "$(command -v gitcm)" == "gitcm" ]; then
  echo "gitcm have install in your computer"
  exit 0
fi

if [ -f "${gitcm_dir}/gitcm.sh" ]; then
  source_gitcm  
else
  git clone https://github.com/suniaoo/gitcm.git $HOME/.gitcm
  source_gitcm  
fi



