syntax enable
set t_Co=256
set background=light
set timeoutlen=50
set laststatus=2
set noshowmode
set nocompatible
set tabstop=2
set expandtab
set number
set nowrap
set viminfo='100,<500,s10,h
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()
filetype plugin on
try
  call glaive#Install()
  Glaive codefmt plugin[mappings]
  Glaive codefmt google_java_executable="google-java-format"
  let g:airline_powerline_fonts = 1
  let g:airline_extensions = ['branch']
  let g:airline_section_x = ''
  let g:airline_section_y = airline#section#create_right(['tagbar', 'filetype'])
catch
endtry
