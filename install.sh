SCRIPTPATH=`pwd -P`

# Upload Plug : a simple plugins manager for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# backup ~/.vimrc
mv ~/.vimrc ~/.vimrc.back

# install my vimrc
ln -s ${SCRIPTPATH}/init.vim ~/.vimrc

# run command :PlugInstall inside vim for update plugins list
vim +PlugInstall +qall

