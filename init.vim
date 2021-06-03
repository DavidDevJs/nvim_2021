call plug#begin('~/.vim/plugged')
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
" auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Themes
Plug 'mhartington/oceanic-next'
Plug 'arzg/vim-colors-xcode'
"Syntaxy Css
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
call plug#end()
"}}}

let mapleader = ","

colorscheme OceanicNext

"Basic Settings
syntax enable
syntax on
filetype plugin on
filetype indent plugin on
set omnifunc=syntaxcomplete#Complete
set number
set termguicolors " Enables 24-bit RGB color
set list
set expandtab
set shiftwidth=2
set softtabstop=2
set relativenumber
set path+=** " search directories upwards and downwards
set wildmenu
set incsearch
set smartcase " automatically switch to case-sensitive when using uppercase
set ignorecase
set noswapfile
set cursorline
set lazyredraw " screen will not redraw while executing macros
set formatoptions+=j " always uses spaces instead of tab characters
set clipboard+=unnamedplus


" mappings to move line

nnoremap <silent> <C-i> :m .+1<CR>==
nnoremap <silent> <C-o> :m .-2<CR>==
inoremap <silent> <C-i> <Esc>:m .+1<CR>==gi
inoremap <silent> <C-o> <Esc>:m .-2<CR>==gi
vnoremap <silent> <C-i> :m '>+1<CR>gv=gv
vnoremap <silent> <C-o> :m '<-2<CR>gv=gv

"Change Mode
inoremap jk <Esc>

"Save and exit
noremap <C-s> :w<CR>
noremap <C-q> :q<CR>
noremap <C-x> :wq<CR>

"Between window
noremap <C-w>h <C-w>H
noremap <C-w>j <C-w>J
noremap <C-w>k <C-w>K
noremap <C-w>l <C-w>L
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"Resize window
nnoremap <space><space> :set nohlsearch!<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up>    :resize +2<CR>

" NERDTree Mappings & Settings{{{
nnoremap <c-space> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^node_modules$']
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && g:NERDTree.IsOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

augroup NerdTreeSettings
  autocmd! 
  autocmd VimEnter * NERDTree "opens NerdTree when vim stars
  autocmd VimEnter * wincmd p "sets to Prev Window
  "autocmd BufEnter * call SyncTree()
  autocmd FileType nerdtree setlocal relativenumber
augroup END

" Highlight currently open buffer in NERDTree

let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "m",
    \ "Staged"    : "s",
    \ "Untracked" : "u",
    \ "Renamed"   : "r",
    \ "Unmerged"  : "u",
    \ "Deleted"   : "d",
    \ "Dirty"     : "m",
    \ "Clean"     : "c",
    \ 'Ignored'   : 'i',
    \ "Unknown"   : "?"
    \ }
"}}}
"
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-emmet', 'coc-prettier']
" coc plugins
" if hidden is not set, TextEdit might fail.
set hidden

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_match_window = 'results:50' " overcome limit imposed by max height

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=750

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

"" Trigger configuration. Do not use <tab> if you use
"" https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger='<c-space>'

"" shortcut to go to next position
"let g:UltiSnipsJumpForwardTrigger='<c-j>'

"" shortcut to go to previous position
"let g:UltiSnipsJumpBackwardTrigger='<c-k>'


let g:ctrlp_regexp = 1
" Buffers go back to prev
" Use the nearest .git directory as the cwd
let g:ctrlp_working_path_mode = 'r'


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>1 :sp<CR>
" Remap for format selected region
xmap <leader>f  :Format<CR>
nmap <leader>f  :Format<CR>
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)


" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"}}}
"
" Set File Types{{{
augroup SetFileType
  autocmd!
  autocmd BufNewFile,BufRead *.tsx,*.jsx,*.js set filetype=typescript.tsx
  " tsconfig.json is actually jsonc, help TypeScript set the correct filetype
  autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
augroup END
"}}}
