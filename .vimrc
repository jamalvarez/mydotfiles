

call plug#begin('~/.vim/plugged')

Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'arcticicestudio/nord-vim'
Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'leafgarland/typescript-vim' "typescript highlighting 
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'sainnhe/edge'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'dyng/ctrlsf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fugitive-blame-ext'

call plug#end()
" Important!!
if has('termguicolors')
  set termguicolors
endif
" The configuration options should be placed before `colorscheme edge`.
let g:edge_style = 'aura'
let g:edge_disable_italic_comment = 1
colorscheme edge

set number " activate numbers in gutter
set relativenumber " activate relative numbers in gutter
set tabstop=2 shiftwidth=2 expandtab " use two spaces instead of longer tabs
set noswapfile
set nowrap
set scrolloff=8
set nohls
" Remappings
map <Space> <Leader>

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>h :wincmd h<CR> 
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
:imap jj <Esc>

inoremap <Leader><Tab> <Tab>
" incsearch mappings
" replace forward and backard search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)

" ctrlsf mappings
"
nmap <leader>fw <Plug>CtrlSFPrompt


" NERDTree remappings

let NERDTreeMapActivateNode='a'

" fzf.vim rempappings
nnoremap <leader>ff :GFiles<CR>
let g:fzf_action = { 
    \ 'enter': 'vsplit'
    \}
"fugitive mappings

nnoremap <leader>s :Git blame<CR>


" No annoying sound on errors
set noerrorbells
set novisualbell
set visualbell t_vb=
set tm=500

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" CoC extensions
let g:coc_global_extensions = ['coc-tsserver']
