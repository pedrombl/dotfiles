if [ $SPIN ]; then
  if ! command -v rcm &> /dev/null; then
    sudo apt-get install -y rcm
  fi

  if ! command -v rg &> /dev/null; then
    sudo apt-get install -y ripgrep
  fi

  if ! command -v tig &> /dev/null; then
    sudo apt-get install -y tig
  fi

  rcup -f -d dotfiles -x install.sh -x gitconfig -f zshrc
fi
