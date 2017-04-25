set nu
set tabstop=2
set shiftwidth=2
set expandtab
retab

set backspace=2

autocmd BufRead,BufNewFile   *.go set noexpandtab

set autoindent

noremap <A-Left> gT
noremap <A-Right> gt


" Nerdtree settings
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

syntax on

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

set laststatus=2
