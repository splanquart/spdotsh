SCRIPTPATH=`pwd -P`
GREEN='\033[0;32m'
NORMAL='\033[0m'

# install font in terminal
cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf
printf "${GREEN}"
echo "Now you can set up your font in your terminal emulator by:"
echo "Preferences > Profiles > text and set Non-ASCII Font to DroidSansMono" 
printf "${NORMAL}"

# Upload Plug : a simple plugins manager for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# backup ~/.vimrc
mv ~/.vimrc ~/.vimrc.back

# install my vimrc
ln -s ${SCRIPTPATH}/init.vim ~/.vimrc

# run command :PlugInstall inside vim for update plugins list
vim +PlugInstall +qall

