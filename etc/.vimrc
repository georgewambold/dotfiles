execute pathogen#infect()

" Color scheme stuff
set t_Co=256
if (has("termguicolors"))
 set termguicolors
endif

colorscheme gruvbox
" gruvbox stuff
let g:gruvbox_contrast_dark = 'hard'
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

set expandtab
retab

autocmd BufRead,BufNewFile   *.go set noexpandtab

set autoindent

noremap <A-Left> gT
noremap <A-Right> gt

map <Enter> o<ESC>
map <S-Enter> O<ESC>

" Nerdtree settings
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Syntax Highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
syntax enable

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\| \+\ze\t/

function! StripWhitespace ()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" NERDTree setting defaults to work around http://github.com/scrooloose/nerdtree/issues/489
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = "RO"

" Settings below this line are the result of informed decisions, those above
" were probably copy/pasted

" Show number lines
set number

" Always show the status line at the bottom of the page
" http://vim.wikia.com/wiki/Displaying_status_line_always
set laststatus=2

" Highlights f/?{char} results
set hls

" Highlights f/?{char} matches as you type
set incsearch

" Treat all numbers as decimals (as opposed to octal, etc.)
set nrformats=

" Setting tabs to equal 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Set yank/put to use system clipboard (requires higher ViM than os x default)
set clipboard=unnamed

" Map jj to <esc> in insert mode
imap jj <esc>

" Make VIM's ex command history longer than the default 20
set history=300

" Set a $ as a delimiter to whats being changed by the change command
set cpoptions+=$

" Allows virtual editing eg. moving my cursor to spaces that aren't
" characters, etc.
set virtualedit=all

" changes the cursor shape/color
" in the terminal depending on the mode
" see http://code.google.com/p/iterm2/issues/detail?id=710&q=cursor
if &term =~ "xterm\\|rxvt"
  " use a | cursor in insert mode
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"

  " use a rectangle cursor otherwise
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -e -n "\x1b[\x34 q"
endif

set nofoldenable    " disable folding

autocmd BufWritePre * %s/\s\+$//e

" FZF to ctrl-p
map <C-p> :FZF<CR>
