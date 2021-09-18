" Setup VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'

" Status line
Plug 'itchyny/lightline.vim'

Plug 'kyazdani42/nvim-web-devicons' " lua

" Themes
Plug 'sainnhe/gruvbox-material'
"
" Terraform
Plug 'hashivim/vim-terraform'

" Autoformat
Plug 'editorconfig/editorconfig-vim'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/vimux'

" Base64
Plug 'christianrondeau/vim-base64'

" Code completion
" Keeping neoclide here just in case native LSP doesn't cut it
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'lifepillar/vim-mucomplete'

" Telescope
" This is somehow much slower than fzf, but maybe one day
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Jsonnet is not supported by treesitter yet :|
Plug 'google/vim-jsonnet'


" Tags
Plug 'ludovicchabant/vim-gutentags'

" Fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'

" Git
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'
Plug 'junegunn/gv.vim'

Plug 'pwntester/octo.nvim'

" Stuff
Plug 'tpope/vim-abolish'

call plug#end()

:lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
EOF

inoremap jk <ESC>

" Buffers
nnoremap [b :bnext<cr>
nnoremap ]b :bNext<cr>

" Windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" quickfix shortcuts
nmap ]q :cnext<cr>
nmap ]Q :clast<cr>
nmap [q :cprev<cr>
nmap [Q :cfirst<cr>

" Tree-view for netrw
let g:netrw_liststyle = 3

let mapleader = " "

" vim-fugitive short-cuts like DoomEmacs
nnoremap <Leader>gg :Git<cr>

" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fG <cmd>Telescope grep_string<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" nnoremap <leader>fl <cmd>Telescope git_files<cr>

" lua require('telescope').load_extension('octo')

" Tmux
map <leader>vp :VimuxPromptCommand<cr>
map <leader>vl :VimuxRunLastCommand<cr>

" Fa</cr></leader>cy autocomplete window
set wildoptions=pum
set pumblend=20

" Switching to new buffer without saving current one is ok
set hidden

" Disable vim's auto EOL, since linters are not happy with it
set nofixendofline

" Sadly Fish causes random mega-slowliness to vim-fugitive :(
set shell=/bin/bash
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Coc.nvim
" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=50

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" don't give |ins-completion-menu| messages.
" Avoid showing message extra message when using completion
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
 " inoremap <silent><expr> <TAB>
 "       \ pumvisible() ? "\<C-n>" :
 "       \ <SID>check_back_space() ? "\<TAB>" :
 "       \ coc#refresh()
 " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

 " function! s:check_back_space() abort
 "   let col = col('.') - 1
 "   return !col || getline('.')[col - 1]  =~# '\s'
 " endfunction

" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" command! -nargs=0 Prettier :CocCommand prettier.formatFile

" " " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

filetype plugin indent on
au BufNewFile,BufRead Jenkinsfile setf groovy

" always show signcolumns
set signcolumn=yes

" Gutentags
" https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']

let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')

let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0


let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" " Leader-F to search files with FZF
nnoremap <Leader>FF :Files<Cr>
nnoremap <Leader>ff :GFiles<Cr>
" " Leader-G to search files contents with FZF and RipGrep
nnoremap <Leader>fg :Rg<Cr>

function! SearchWordWithRg()
  execute 'Rg' expand('<cword>')
endfunction

nnoremap <Leader>fG :call SearchWordWithRg()<CR>
" " Buffers
nmap <Leader>fb :Buffers<CR>
nmap <Leader>fh :History<CR>
" " Git commits
nmap <Leader>fc :Commits<CR>
" " Tags
nmap <Leader>ft :BTags<CR>
" nmap <Leader>T :Tags<CR>

" Automagically remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

set laststatus=2
" For pretty colors
set termguicolors

set modelines=0		" CVE-2007-2438

set equalalways   " Automatically resize window after splitting

set backspace=2		" more powerful backspacing

" Undo levels
if version >= 700
    set history=64
    set undodir=~/.vim/undodir/
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

set tabstop=2
set shiftwidth=2
set shiftwidth=2
set expandtab
set smartindent

set scrolloff=5

" Case-insensitive searc
set ignorecase
" ...except when our search input contains Capital letter
set smartcase

" animate
" let g:animate#duration = 150.0

" Default to static completion for SQL
let g:omni_sql_default_compl_type = 'syntax'

" Switch syntax highlighting on, when the terminal has colors
" " Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
  " set background=light
  set background=dark
  let g:gruvbox_material_background = 'medium'
  " let g:gruvbox_transparent_bg = 1
  " let g:gruvbox_contrast_dark = 'soft'

  " colorscheme gruvbox
  colorscheme gruvbox-material
endif

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Use ripgrep instead of ag:
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   "rg --column --no-heading --smart-case --color=always "
"   \ .shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)


luafile ~/.config/nvim/nvim-lspconfig.lua

" Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
