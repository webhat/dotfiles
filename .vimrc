
" Shortcuts
let mapleader = ","
let mapleader = "\<space>"
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <Leader>s :source $MYVIMRC<CR>
nmap <leader>b :tabedit ~/.bash_profile<CR>:sp ~/.bashrc<CR>
nmap <leader>z :tabedit ~/.zshrc<CR>

set shell=/bin/sh


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
filetype plugin on

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
vmap <leader>t :call I18nTranslateString()<CR>
vmap <leader>dt :call I18nDisplayTranslation()<CR>
" nmap <leader>T :Rake<CR>
" RSpec.vim mappings
nmap <Leader><Space> :Rake<CR>
nmap <Leader>T :call RunCurrentSpecFile()<CR>
nmap <Leader>S :call RunNearestSpec()<CR>
nmap <Leader>L :call RunLastSpec()<CR>
nmap <Leader>A :call RunAllSpecs()<CR>

noremap <Left> <nop>
inoremap <Left> <nop>
noremap <Right> <nop>
inoremap <Right> <nop>
noremap <Up> <nop>
inoremap <Up> <nop>
noremap <Down> <nop>
inoremap <Down> <nop>

let g:rspec_command = "Dispatch rspec {spec}"

autocmd BufNewFile,BufRead :set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" http://vim.wikia.com/wiki/Modeline_magic
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

set modeline
set modelines=5

:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

:set expandtab

" vim: set ts=2 sw=2 tw=78 et :
