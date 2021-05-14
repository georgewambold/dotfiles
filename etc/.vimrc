" execute pathogen#infect()

" setup vundle
set nocompatible " be iMproved, required
filetype off     " required

 " set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ervandew/supertab.git'
Plugin 'junegunn/fzf'
Plugin 'airblade/vim-gitgutter'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-endwise'
Plugin 'thoughtbot/vim-rspec.git'
Plugin 'chaoren/vim-wordmotion.git'
Plugin 'morhetz/gruvbox.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-abolish.git'
Plugin 'janko-m/vim-test'
Plugin 'mileszs/ack.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" map leader
let mapleader = "\<space>"

" Color scheme stuff
set t_Co=256
if (has("termguicolors"))
  set termguicolors
endif

colorscheme gruvbox

" gruvbox stuff
let g:gruvbox_contrast_dark = 'hard'

set expandtab
retab

autocmd BufRead,BufNewFile   *.go set noexpandtab

set autoindent

map <Enter> o<ESC>
map <S-Enter> O<ESC>

" Nerdtree settings
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Syntax Highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Syntax on, use old regexp engine for better performance
syntax on
set regexpengine=1
set lazyredraw
set ttyfast

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\| \+\ze\t/

function! StripWhitespace ()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" Function to create services
function! CreateService()
  let name = input('Type new service name and press <enter>: ')
  let snake_case_name = substitute(name,'::','/','g')
  let snake_case_name = substitute(snake_case_name,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let snake_case_name = substitute(snake_case_name,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let snake_case_name = substitute(snake_case_name,'[.-]','_','g')
  let snake_case_name = tolower(snake_case_name)

  let camel_case_name = name
  let filepath = "app/services/" . snake_case_name . ".rb"
  let test_filepath = "spec/services/" . snake_case_name . "_spec.rb"

  execute "!touch " . filepath
  execute "!touch " . test_filepath

  let service_text = [
        \ 'class ' . camel_case_name,
        \ '',
        \ '  def self.call(params={})',
        \ '    new(params).call',
        \ '  end',
        \ '',
        \ '  def initialize(params)',
        \ '  end',
        \ '',
        \ '  def call',
        \ '  end',
        \ '',
        \ '  private',
        \ 'end',
        \]
  let test_text = [
        \ "require 'rails_helper'",
        \ "",
        \ "describe " . camel_case_name . " do",
        \ "  it 'has a call method' do",
        \ "    expect(" . camel_case_name . ").to respond_to(:call)",
        \ "  end",
        \ "end",
        \]

  silent! call writefile(service_text, glob(filepath), 'b')
  silent! call writefile(test_text, glob(test_filepath), 'b')
endfunction
map <leader>c :call CreateService()<CR>

" NERDTree setting defaults to work around http://github.com/scrooloose/nerdtree/issues/489
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = "RO"

" Easier split naviation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" RSpec.vim mappings
map <leader>f :w!<CR> :TestFile<CR>
map <Leader>s :w!<CR> :TestNearest<CR>
map <Leader>a :w!<CR> :TestSuite<CR>
let g:rspec_runner = "os_x_iterm"
let test#python#pytest#options = '-s'

" IF bin/rspec exists, use it ELSE use bundle exec rspec
if executable("bin/rspec")
  let b:rspec_executable = "!bin/rspec {spec}"
else
  let b:rspec_executable = "!bundle exec rspec {spec}"
end

let g:rspec_command = b:rspec_executable

" run the current file with ruby
map <leader>r :w!<CR>:!ruby %<CR>

" run the current file with python
map <leader>p :!python3 %<CR>

" indent whole file
map <leader>= mmgg=G`m

" add binding.pry on the following line
map <leader>b :call AddDebugger()<CR>

function! AddDebugger ()
  if &filetype == 'python'
    normal Oimport ipdb;ipdb.set_trace(context=15);
  elseif &filetype == 'ruby'
    normal Otry;binding.pry;rescue;debugger;
  endif
endfunction

set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files

" mitigate holding shift for too long
command! Q q " Bind :Q to :q
command! Wq wq

" Custom split hotkeys for FZF
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

" Change default fzf search commamnd to show hidden files and ignore
" gitignored files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" Use ag for ack.vim behind the scenes and in the command
let g:ackprg = "ag --vimgrep --smart-case"
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" ========================================================================================
" Settings below this line are the result of informed decisions, those above
" were probably copy/pasted

" " Show number on cursor line and relative numbers on other lines
" set relativenumber
set number
" autocmd InsertEnter * :set number norelativenumber
" autocmd InsertLeave * :set relativenumber

" Always show the status line at the bottom of the page
" http://vim.wikia.com/wiki/Displaying_status_line_always
set laststatus=2

" Highlights f/?{char} results
set hls

" clear highlights from last search
map <leader>h :nohlsearch<cr>

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
set history=20

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

" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" search settings:
" this ignores case unless you input an uppercase character into the search
" bar
set ignorecase
set smartcase

" split behavior
set splitbelow
set splitright

au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=79 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix |

" You Complete Me Setting
let g:ycm_server_python_interpreter='/usr/local/bin/python3'

" try to add .rb to strings checked by the gf command
set suffixesadd+=.rb

