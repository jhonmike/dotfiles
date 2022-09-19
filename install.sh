# Install Plugged to Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy .vimrc
ln -s ~/Projects/dotfiles/.vimrc ~/.vimrc

# Copy .zshrc
ln -s ~/Projects/dotfiles/.zshrc ~/.zshrc

