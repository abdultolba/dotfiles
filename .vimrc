" this .vimrc was inspired by Idris Hanafi (github.com/IdrisHanafi/dotfiles)

syntax on
set hlsearch
" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
set incsearch
set cursorline
filetype indent plugin on
set mouse=a
set number
set relativenumber
set tabstop=4
set expandtab
set ic
set backspace=indent,eol,start
"set noet
set pastetoggle=<F2>
set textwidth=80
set colorcolumn=80

autocmd BufRead,BufNewFile *.html setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.css setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.js setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.ts setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.zai setlocal ts=2 sw=2 expandtab

au BufRead,BufNewFile *.ts set syntax=javascript
au BufReadPost *.hbs set syntax=html

set laststatus=2

" easy buffer navigations
nnoremap <leader>b :buffers<cr>:b<space>
nnoremap <leader>vb :buffers<cr>:vert sb<space>
nnoremap <leader>sb :buffers<cr>:sb<space>
nnoremap <leader><tab> :b#<cr>
map <leader>] :bn<cr>
map <leader>[ :bp<cr>

" easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" copy into mac clipboard
vnoremap <leader>c :w !pbcopy<CR><CR> 

inoremap jk <Esc>
inoremap kj <Esc>
" insert mode esc and save
imap `` <C-c>:w<CR>
" normal mode esc and save
nnoremap `` <C-c>:w<CR> 
" visual mode esc and save
vnoremap `` <C-c>:w<CR>

" resize vertical splits
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" J and K on a visual block moves things up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Force replace, example /word_to_replace \r
nnoremap <Leader>r :%s///g<Left><Left>
" Replace with confirm, example /word_to_replace \rc
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" Open FZF and search
nmap <Leader>ff :Files<cr>
nmap <Leader>gf :GFiles<cr>
" Find a word in the directory
nmap <Leader>rg :Rg<Space>
" List commits
nmap <Leader>c :Commits<cr>

" Add colors to HEX in text
nmap <Leader>co :ColorHighlight<cr>

" Open NERDTree with toggle
nmap = :NERDTreeToggle<cr>
" autocmd vimenter * NERDTree

" Place vim-plugs plugins below using the Plug 'function name'
" Run :source %
" Then Run :PlugInstall
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Automatically install missing plugins on startup
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall | q
endif

Plug 'morhetz/gruvbox'
Plug 'chrisbra/colorizer'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

" add preview window to the Rg command
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Add preview to the :Files command
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)

Plug 'jiangmiao/auto-pairs'
" post install (yarn install | npm install)
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
"Plug 'vim-scripts/AutoComplPop'
" File Directory
Plug 'scrooloose/nerdtree'

" Track the engine. Autocomplete
Plug 'SirVer/ultisnips'

" autocomplete stuffs
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" React Plugin
Plug 'tellijo/vim-react-native-snippets'

" nginx styling
Plug 'chr4/nginx.vim'

call plug#end()

" Colorscheme
colorscheme gruvbox
set background=dark
let g:solarized_termtrans=1

" GoTo code navigation.
nmap <buffer> <Leader>gd <Plug>(coc-definition)
" nmap <buffer> <Leader>gr <Plug>(coc-references)
" For  some odd reason the above doesn't 
" work in regular vim but the below one does
nnoremap <silent><leader>gr :call CocAction('jumpReferences')<cr>

" ignore certain files in ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ESLint configs
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }

let g:ale_fix_on_save = 1
