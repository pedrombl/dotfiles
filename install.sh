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

  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  rcup -d ~/dotfiles -x install.sh -x gitconfig

  echo "source ~/.spin.zsh" >> ~/.zshrc
fi
