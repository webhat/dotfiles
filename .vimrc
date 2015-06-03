
" Shortcuts
let mapleader = ","
let mapleader = "\<space>"
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <Leader>s :source $MYVIMRC<CR>
nmap <leader>b :tabedit ~/.bash_profile<CR>:sp ~/.bashrc<CR>
nmap <leader>z :tabedit ~/.zshrc<CR>


" Text Replacements
imap ;cr /* Copyright (c) 2013 Daniël W. Crompton <daniel@specialbrands.net>,<CR> *     Special Brands <info@specialbrands.net><CR>*/<CR>
imap ;co /* Copyright (c) 2013 Daniël W. Crompton <crompton@oplerno.com>,<CR> *     Oplerno LLC <info@oplerno.com><CR>*/<CR>


" Visual
:syn on
:set ts=2
:set sw=2
:set cindent

set rtp+=$GOROOT/misc/vim

syntax match fixMe "\vFIXME:.*$"
highlight link fixMe Error

:filetype plugin on
:set omnifunc=syntaxcomplete#Complete

:set hlsearch

set nocompatible 
if has("autocmd") 
	filetype indent plugin on 
endif 

" Plugins
:runtime ~/.vim/autoload/vimex.vim
:runtime ~/.vim/autoload/scratch.vim

call pathogen#infect() 
call pathogen#helptags()

let g:airline#extensions#tabline#enabled = 1

:nnoremap <leader>rap  :RAddParameter<cr>
:nnoremap <leader>rcpc :RConvertPostConditional<cr>
:nnoremap <leader>rel  :RExtractLet<cr>
:vnoremap <leader>rec  :RExtractConstant<cr>
:vnoremap <leader>relv :RExtractLocalVariable<cr>
:nnoremap <leader>rit  :RInlineTemp<cr>
:vnoremap <leader>rrlv :RRenameLocalVariable<cr>
:vnoremap <leader>rriv :RRenameInstanceVariable<cr>
:vnoremap <leader>rem  :RExtractMethod<cr>

autocmd BufNewFile,BufRead :set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

:set expandtab
