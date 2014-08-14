" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" manual config
filetype plugin on
set tabstop=4
"size of an indent
set shiftwidth=4
"a combination of spaces and tabs are used to simulate tab stops at a width
"other than the (hard)tabstop
set softtabstop=4
" make tab insert indents instead of tabs at the beginning of a line
set smarttab
" always uses spaces instead of tab characters
set expandtab

" ==============================================================================================================
" ==============================================================================================================
"													========
" 	Purpose:		Vim configuration file .. 						========
" 	Author:			Brajesh Kumar [(Originally by Ajay Somani) Lot of code taken from other people and help pages ]	========
" 	Email:			kbrajesh176@gmail.com							========
" 	Last Updated:   Thu Aug 14 12:37:16 IST 2014   						========
" 	File:			$HOME/.vimrc								========
" 	Version:		2.0 Beta 1								========
" 	Operating System:	Particularly designed for GNU/Linux					========
"													========
" ==============================================================================================================
" ==============================================================================================================


"""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings -
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Defining how many undo's can be done in vim at a time
set undolevels=5000

" Don't expand tab to spaces
set noexpandtab

" Allow the user of arrow keys for cursor navigation
set esckeys

" Set the file format to unix
set fileformat=unix

" Give smoother output, assuming we have a fast network connection
set ttyfast

" Make vim less vi compatible so that the default is set to better options
set nocompatible

" Set the shell to bash
set shell=/bin/bash

" This helps in copying source code from outside URL
set pastetoggle=<F9>

set tags=./tags,tags;$HOME

" Switch on the syntax for every file type automatically
syntax enable

" Set the expansion key as <tab>, just like bash command completion.
set wildchar=<tab>

" This function will automatically give execute permissions to the file 
" while saving it ( if its a script I.E. first line starts with a '#!' )
function AddExecPerm()
	let line = getline(1)
	if strpart(line, 0, 2) == "#!"
		call system("chmod +x ". expand("%"))
	endif
endfunction
autocmd BufWritePost * :call AddExecPerm()

" After using the underlined function, the tab is much more smart
" TAB will be used to complete while typing words, else it will insert usual
" tab.
function! TabOrComplete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
endfunction
inoremap <Tab> <C-R>=TabOrComplete()<CR>

" Changing sessionoptions will change the effect of the mksession command. Now
" we can customize what all information we want to store associated with a
" current session.
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

""""""""""""""""""""""""""""""""""""""""""""""""
" Search settings -
""""""""""""""""""""""""""""""""""""""""""""""""

"  Use extended regular expressions in search patterns -
set magic

" search the word at the same time its typed ( no <Enter> required )
set incsearch

" ignore case while matching for the search criteria
set ignorecase

" if the search pattern contains upper case letters, then make the search
" case sensitive
set smartcase

" Search will continue from the top when hitting bottom
set wrapscan

" this function is a better way of toggling highlight search .. 
" by pressing Ctrl-H the highlighting of search results will be toggled .
function ToggleHLSearch()
	if &hls
		set nohls
	else
		set hls
	endif
endfunction
command! ToggleHighLightSearch call ToggleHLSearch()
nmap <c-h> :ToggleHighLightSearch<cr>


""""""""""""""""""""""""""""""""""""""""""""""""
" Vim User Interface
""""""""""""""""""""""""""""""""""""""""""""""""

" Set the number of screen lines for the command line as 2
set cmdheight=2

" Show the current curser position
set ruler

" Allows backspacing over indentation, end of line and start of line
set backspace=indent,eol,start

" We won't go to the start of line with page-up or page-down keys.
set nostartofline

" No sound or visual errors -
" Vim plays sound or blinks screen if some errors happen
set noerrorbells 
set novisualbell
set t_vb=

" synmaxcol denotes the maximum column to look for syntax items,
" by setting this, we can avoid very slow redrawing when there are very long
" lines
set synmaxcol=200

" Setting up the colors settings of the popup menu, while editing the files in
" terminal. Pmenu represents the items in the menu, and PmenuSel represents
" the selected item.
highlight Pmenu 	ctermfg=Brown 		ctermbg=LightGray
highlight PmenuSel 	ctermfg=LightGreen   	ctermbg=DarkGray

" Display settings ->
" lastline	When included, as much as possible of the last line
"		in a window will be displayed.  When not included, a
"		last line that doesn't fit is replaced with "@" lines.
" uhex		Show unprintable characters hexadecimal as <xx>
"		instead of using ^C and ~C.
set display+=lastline
set display+=uhex

" Highlight *ALL* the changes
set report=0

" Always show the status line, Even when editing only 1 file.
set laststatus=2

" Setting a better command completion menu in vim
set wildmenu
set wildmode=list:longest,full

" Hide the mouse pointer as characters are typed
set mousehide

" Always display uncompleted command.
set showcmd

" Keep track of 10000 last commands
set history=10000

" Show the current mode of editing
set showmode

" When using split, the new window will be placed below the original one.
set splitbelow

" When using vsplit, the new window will be placed right to the original one.
set splitright

" Listings pause when the whole screen is filled and then the more prompt
" comes.
set more


" Vim should give greetings whenever you open a file or close it 
autocmd VimEnter * echo "All the best :)"


""""""""""""""""""""""""""
" Keyboard Shortcuts
""""""""""""""""""""""""""

"ctrl-n for new blank file in split mode .. 
nmap <c-n> :new<cr> 	

"ctrl-f for finding the current word in the file ..  
map  <c-f> mp*
imap <c-f> <Esc>mp*<Insert>

" use <F6> to cycle through split windows .. and <shift>+<F6> to cycle backwards .. ( wherever possible .. )  
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" This is setting keyboard shortcuts for tabbed editing, quite cool trick.
nmap <C-Right> :tabnext<cr>
nmap <C-Left>  :tabprevious<cr>
map  <C-w>     :tabclose<cr>

" Now I can sort the selected data by pressing ctrl+E
map <C-E> !sort<cr>

"Short cut 
" To save, ctrl-s
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
imap <c-s> <Esc><c-s>
"""""""""""""""""""""""""
" Abbreviations
"""""""""""""""""""""""""

" the Date command of linux can be imported in a file also .. 
" using this command whenever you type date in a file and press enter or space
" this date will change in the with the correct time in the standard format ...
iab _date_ 	<c-r>=strftime("%a %b %d %T %Z %Y")<cr>
iab odate 	<c-r>=strftime("%d:%m:%y")<cr>
iab otime 	<c-r>=strftime("%H:%M:%S")<cr>
iab ydt		<c-r>=strftime("%y%m%d %T")<cr>

" personel abbreviations 
iab brajesh Brajesh
iab kumar Kumar
iab _name_	Brajesh Kumar
iab _email_ 	kbrajesh176@gmail.com

" typing mistakes 
iab teh the
iab adn and


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spelling and Grammer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This function will be used to toggle spell check from on to off.
" We need to switch on the spell checking first
set spell spelllang=
function ToggleSpellCheck()
	if &spelllang == "en"
		set spelllang=
	else
		set spelllang=en
	endif
endfunction
command! ToggleSpellChecking call ToggleSpellCheck()
nmap <c-a> :ToggleSpellChecking<cr>


"""""""""""""""""""""""""""""""""
" Viminfo Settings
"""""""""""""""""""""""""""""""""
if has("viminfo")
	if filewritable(expand("$HOME/.vim/viminfo")) == 1 || 
				\ filewritable(expand("$HOME/.vim/")) == 2
		set viminfo=!,%,'5000,\"10000,:10000,/10000,n~/.vim/viminfo
	else
		set viminfo=
	endif
endif


""""""""""""""""""""""""""""""""""""""
" File Type Specific settings
"""""""""""""""""""""""""""""""""""""

" Vim to recognize the fileytpe and put appropriate plugins and settings
filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable folding.
set nofen
set fdl=0
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" color plugins fot file types
au BufReadPost *.twig colorscheme koehler 
au BufReadPost *.css colorscheme slate 
au BufReadPost *.js colorscheme elflord 
au BufReadPost *.py colorscheme molokai
au BufReadPost *.html colorscheme monokai
au BufReadPost *.java colorscheme monokai
au BufReadPost *.php colorscheme two2tango
