call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'peitalin/vim-jsx-typescript' " typescript and tsx syntax
Plug 'leafgarland/typescript-vim' "typescript highlighting
Plug 'machakann/vim-highlightedyank' " highlight text when yanking
Plug 'vim-airline/vim-airline' "pretty bottom bar
Plug 'vim-airline/vim-airline-themes'
Plug 'haya14busa/incsearch.vim' " word finder inside file
Plug 'tpope/vim-fugitive' " git info
Plug 'tommcdo/vim-fugitive-blame-ext' " git blame line by line on a new buffer
Plug 'nvim-lua/plenary.nvim' " file finder dependency
Plug 'nvim-telescope/telescope.nvim' " file finder
Plug 'neovim/nvim-lspconfig' "language server
Plug 'dense-analysis/ale' "prettier and linting
Plug 'mhartington/oceanic-next' " alright theme
Plug 'ful1e5/onedark.nvim'
Plug 'jiangmiao/auto-pairs' "autocompletion of brackets

Plug 'phaazon/hop.nvim' " FUCKING MAGIC I'M TELLING YOU

" LSP autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
"END of LSP autocomplete

Plug 'airblade/vim-gitgutter'


Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

Plug 'mhinz/vim-grepper'

call plug#end()
" Important!!
if has('termguicolors')
  set termguicolors
endif

syntax on
set cursorline
colorscheme onedark
let g:airline_theme='oceanicnext'

" VimScript for onedark
let g:onedark_comment_style = "NONE"
let g:onedark_keyword_style = "NONE"
let g:onedark_function_style = "NONE"
let g:onedark_variable_style = "NONE"

set number " activate numbers in gutter
set relativenumber " activate relative numbers in gutter
set tabstop=2 shiftwidth=2 expandtab " use two spaces instead of longer tabs
set noswapfile
"set nowrap
set scrolloff=8
set nohls
set wildignore=*/node_modules/*
" Remappings
map <Space> <Leader>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <C-l> :tabn<CR>
nnoremap <C-h> :tabp<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
" Fucking Magic I tell you
nnoremap <leader>gg :HopWord<CR>
:imap jj <Esc>

" do a grep for current word under cursor in all folders of the current
" diretory
:nnoremap gr :vimgrep <cword> *<CR>

" mapping to add tsc error otput to quickfixlist
nnoremap <leader>qf :cexpr system('tsc')<CR>

nnoremap <leader>qfe :cexpr system('npm run eslint')<CR>

" incsearch mappings
" replace forward and backard search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)

" not sure if I like sending mouse commands
set mouse=nv

" netrw configurations
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_list_hide = 'node_modules'
let g:netrw_winsize = 25

" netrw mappings
nnoremap <leader>t :Vexplore<CR>

"telescope mappings Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>s :Git blame<CR>

" mapping to go to definition of a symbol
nnoremap <leader>gd <cmd>lua vim.lsp.buf.definition()<cr>
" mapping to go to references that call a symbol
nnoremap <leader>gr <cmd>lua vim.lsp.buf.references()<cr>

"mappings to allow for moving lines and blocks up and down

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" No annoying sound on errors
set noerrorbells
set novisualbell
set visualbell t_vb=
set tm=500


let g:ale_fixers = {
\   '*': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}


" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

let g:ale_fix_on_save = 1
lua << EOF
-- typescript checking
 require'lspconfig'.tsserver.setup{}

 -- fucking magic
 require'hop'.setup()
 -- telescope arguments, eg: ignoring files inside .gitignore
 require'telescope'.setup{defaults={vimgrep_arguments={'--ignore-file', '.gitignore'}}}

EOF


lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF


lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions

end
EOF


" Autocomplete LSP settings
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig').tsserver.setup {
    capabilities = capabilities
  }
EOF
