#!/bin/bash

if [[ -n "$DOTFILES_DIR" ]]; then
    echo "Environment variable 'DOTFILES_DIR' not set. Please set this variable to use this script."
    exit 1
fi

# Variables
BACKUP_DIR="$HOME/dotfiles_backup"

echo -e "Starting dotfiles setup..."

# Create a backup directory
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "Creating backup directory at $BACKUP_DIR..."
    mkdir -p "$BACKUP_DIR"
fi

# Symlink dotfiles
echo -e "Linking dotfiles..."
cd "$DOTFILES_DIR" || exit 1

for file in .*; do
    # Ignore special files
    if [[ "$file" == "." || "$file" == ".." || "$file" == ".git" || "$file" == ".gitignore" ]]; then
        continue
    fi

    target="$HOME/$file"

    # Back up existing files
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "Backing up $target to $BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi

    # Create symlink
    echo -e "Creating symlink for $file"
    ln -sf "$DOTFILES_DIR/$file" "$target"
done

echo -e "Dotfiles setup complete!"
