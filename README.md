# Dotfiles

How to install

    $ git clone https://github.com/orose/dotfiles.git ~/git/dotfiles
    $ cd && ln -s git/dotfiles/vimrc .vimrc
    $ cd && ln -s git/dotfiles/vim .vim
    $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    $ vim +PluginInstall +qall

Install Prettier (requires git and yarn)
$ cd ~/git/dotfiles/vim/bundle/vim-prettier && yarn install

You should now be up and running!
