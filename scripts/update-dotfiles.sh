#!/bin/bash

if [[ -z "$DOTFILES_DIR" ]]; then
    echo "Environment variable 'DOTFILES_DIR' not set. Please set this variable to use this script."
    exit 1
fi

if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "Directory '$DOTFILES_DIR' not found. Please make sure this directory exists."
fi

cd $DOTFILES_DIR && git pull -r main
