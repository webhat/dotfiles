
" Shortcuts
let mapleader = ","
let mapleader = "\<space>"
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>s :source $MYVIMRC<CR>
nmap <leader>b :tabedit ~/.bash_profile<CR>:sp ~/.bashrc<CR>
nmap <leader>z :tabedit ~/.zshrc<CR>

nmap <leader>u :setlocal spell spelllang=en

set shell=/bin/sh


" Text Replacements
imap ;cr /* Copyright (c) 2013 Daniël W. Crompton <daniel@specialbrands.net>,<CR>    Special Brands <info@specialbrands.net><CR>*/<CR>
imap ;co /* Copyright (c) 2013 Daniël W. Crompton <crompton@oplerno.com>,<CR>     Oplerno LLC <info@oplerno.com><CR>*/<CR>


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
let g:syntastic_go_checkers = ['golangci-lint', "go", "golint", "govet" ]
" , "gotype"]
let g:syntastic_javascript_checkers = ['eslint']

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn


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
au FileType rb nmap <Leader><Space> :Rake<CR>
au FileType rb nmap <Leader>T :call RunCurrentSpecFile()<CR>
au FileType rb nmap <Leader>S :call RunNearestSpec()<CR>
au FileType rb nmap <Leader>L :call RunLastSpec()<CR>
au FileType rb nmap <Leader>A :call RunAllSpecs()<CR>

au FileType go nmap <leader>R <Plug>(go-run)
au FileType go nmap <leader>B <Plug>(go-build)
au FileType go nmap <leader><Space> :GoTest -short -timeout=20s<CR>
"au FileType go nmap <leader><Space> :Dispatch go test -short -timeout=20s<CR>
"au FileType go nmap <leader><Space> <Plug>(go-test -short)
au FileType go nmap <leader>C <Plug>(go-coverage)

au FileType go nmap <leader>T :!gotests -exported -i -w %:r.go<CR>:vsp  %:r_test.go<CR>
au FileType rl nmap <leader>T :!ragel -Z -G2 -o %:r.go %:r.rl<CR>
au BufReadPost *.rl set syntax=go

noremap <Left> <nop>
inoremap <Left> <nop>
noremap <Right> <nop>
inoremap <Right> <nop>
noremap <Up> <nop>
inoremap <Up> <nop>
noremap <Down> <nop>
inoremap <Down> <nop>

let g:rspec_command = "Dispatch rspec {spec}"

augroup all_buffers
  autocmd!
  autocmd BufNewFile,BufRead :set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
augroup END

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

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Copy & paste to system clipboard with <Leader>p and <Leader>y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

:set expandtab

" Hex Editor
nnoremap <Leader>X VG:!xxd -r<CR>

function! HexEditor()
  let s:hexedit = 0
  let s:hexedit_command = "xxd"
  silent !clear
  if s:hexedit
    execute "!" . s:hexedit_command . " " . bufname("%")
    let s:hexedit = 0
  else
    execute "!" . s:hexedit_command . " -r " . bufname("%")
    let s:hexedit = 0
  end
endfunction


" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

set shell=/bin/sh

" vim: set ts=2 sw=2 tw=78 et :
