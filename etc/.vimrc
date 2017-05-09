set expandtab
retab

autocmd BufRead,BufNewFile   *.go set noexpandtab

set autoindent

noremap <A-Left> gT
noremap <A-Right> gt


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

execute pathogen#infect()

" NERDTree setting defaults to work around http://github.com/scrooloose/nerdtree/issues/489
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = "RO"

" Settings below this line are the result of informed decisions, those above
" were probably copy/pasted

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
