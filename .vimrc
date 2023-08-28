syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set number
set hlsearch
set ruler
set relativenumber
highlight Comment ctermfg=green

" set select color in visual modes
hi Visual term=reverse cterm=reverse guibg=Grey

nnoremap <Leader>r :so $MYVIMRC<CR>

nmap <CR> :a<CR><CR>.<CR>

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set pastetoggle=<F3>
" Use system clipboard by default
set clipboard=unnamed

nnoremap yy "+yy
nnoremap yw "+yw
nnoremap yl "+yl
nnoremap yp "+yp
nnoremap y{ "+y{
nnoremap ye "+ye
nnoremap yb "+yb
nnoremap yH "+yH
nnoremap yM "+yM
nnoremap yL "+yL
vnoremap y "+y

nnoremap : :set wildmode=full<CR>:
inoremap <C-n> <Esc>:set wildmode=longest,list,full<CR>a<C-n>

set cursorline
" highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

" ctrl+n for autocomplete list in INSERT mode
" set wildmode=longest,list,full

" type S to global replace
nnoremap S :%s//g<Left><Left>

" set noerrorbells
set colorcolumn=80

" Search through buffers for words
funct! GallFunction(re)
      cexpr []
        execute 'silent! noautocmd bufdo vimgrepadd /' . a:re . '/j %'
          cw  
      endfunct

      command! -nargs=1 Gall call GallFunction(<q-args>)

silent! source $VIMRUNTIME/defaults.vim

call plug#begin()
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Plug 'tomasiser/vim-code-dark'
Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-syntastic/syntastic'
Plug 'preservim/nerdtree'
Plug 'ap/vim-css-color'
Plug 'tc50cal/vim-terminal'
Plug 'vifm/vifm.vim'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-buftabline'
" Plug 'mkitt/tabline.vim'
" Plug 'ycm-core/YouCompleteMe'

call plug#end()

" Color Scheme
colorscheme onedark

" buftablin
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-P> :bprev<CR>
nnoremap <C-S-Tab> :bprev<CR>
let g:buftabline_numbers = 1
let g:buftabline_indicators = 1
let g:buftabline_separators = 0
" in airline
" let g:airline#extensions#tabline#buffer_nr_show = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 10])
    endif
endfunction


" Nerd Tree
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="-"
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
"
"
" Vifm
map <Leader>vv :Vifm<CR>
map <Leader>vs :VsplitVifm<CR>
map <Leader>xp :SplitVifm<CR>
map <Leader>vd :DiffVifm<CR>
map <Leader>tv :TabVifm<CR>

"
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

" Auto-Pair
"""""""""""""""""""""""""""""""""""""""""""
" Programs to install
"
"""""""""""""""""""""""""""""""""""""""""""
" sudo apt-get install vifm
" sudo apt-get install silversearcher-ag
" sudo apt-get install 

