
" vim-plug shenanigans
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()
colorscheme nord " set color theme to nord


set number " activate numbers in gutter
set relativenumber " activate relative numbers in gutter

" Remappings
map <Space> <Leader>

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>


" NERDTree remappings

let NERDTreeMapActivateNode='a'
" No annoying sound on errors
set noerrorbells
set novisualbell
set visualbell t_vb=
set tm=500


" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
