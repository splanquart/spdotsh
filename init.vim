syntax on
filetype plugin indent on
call plug#begin('~/.vim/plugged')
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
call plug#end()

set tabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces


"Open NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>

set encoding&		" terminal charset: follows current locale
set termencoding=
set fileencodings=	" charset auto-sensing: disabled
set fileencoding&	" auto-sensed charset of current buffer

set ruler
set wildmenu
set bg=dark
set bg=light
set syntax=auto
set nu
set ai
set hls
set so=2
set incsearch
set aw
set scrolloff=2
set showtabline=2
set laststatus=2

let mapleader = ";"

map <F2> : <Up><CR>
imap <F3> <Esc> .i
map <F4> :wa <CR>:mksession!<CR>:xa<CR>
map <F5> :s/\(^ *\)/\1#/ <CR>:let @/ = ""<CR>
map <F6> :s/\(^ *\)#/\1/ <CR>:let @/ = ""<CR>
map ù :pu_<CR>
map <tab> >>
map <S-tab> <<
vmap <tab> >gv
vmap <S-tab> <gv
noremap <C-Left> gT
noremap <C-Right> gt
noremap [1;5D gT
noremap [1;5C gt
noremap  :tabnew 
nnoremap <silent> <C-l> :nohl<CR><C-l>
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr>:nohl<cr><c-o>

let g:xml_syntax_folding=1
map <leader>sf :setlocal spell spelllang=fr<CR>
map <leader>se :setlocal spell spelllang=en_US<CR>

ab GPL_LICENSE #################################################################################<enter># copyright 2008 Gabriel Pettier <gabriel.pettier@gmail.com><enter>#<enter># This file is part of PROJECT<enter>#<enter># PROJECT is free software: you can redistribute it and/or modify<enter># it under the terms of the GNU General Public License as published by<enter># the Free Software Foundation, either version 3 of the License, or<enter># (at your option) any later version.<enter>#<enter># PROJECT is distributed in the hope that it will be useful,<enter># but WITHOUT ANY WARRANTY; without even the implied warranty of<enter># MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the<enter># GNU General Public License for more details.<enter>#<enter># You should have received a copy of the GNU General Public License<enter># along with PROJECT.  If not, see <http://www.gnu.org/licenses/>.<enter>##############################################################################<enter>

nnoremap <silent> <F8> :TlistToggle<CR>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

autocmd BufNewFile *.py 0r ~/.vim/skeleton.py
autocmd BufNewFile *.c 0r ~/.vim/skeleton.c
autocmd BufNewFile *.tex 0r ~/.vim/skeleton.tex

"hide passwords when editing
"hi Password ctermfg=black ctermbg=black cterm=NONE guifg=black guibg=black 
"match Password /pass.*\s*=\s*\k\{-}\zs[^ ]*\ze.\{-}/

