" Load plugins that come with vim
runtime macros/matchit.vim

" Pathogen and basic shit
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
syntax enable
filetype plugin indent on

" Basic settings
set nocompatible                   " This is vim not vi
set mouse=a                        " Allow use of mouse
set exrc                           " Allow directory specific shit
set number                         " Show line numbers
set ruler                          " Show current line and column
set nrformats=                     " Treat all numbers as decimal
set history=200                    " Keep moar history
set modeline

" Color scheme settings
color solarized
set background=dark

" Make the status line useful
if has("statusline") && !&cp
	let g:Powerline_symbols = 'fancy'
	set laststatus=2                 " always show the status bar

	" Start the status line
	set statusline=%f\ %m\ %r        " File path, modified, read only
	set statusline+=Line:%l/%L[%p%%] " Line number
	set statusline+=Col:%v           " Column number
	set statusline+=Buf:#%n          " Buffer number
	set statusline+=[%b][0x%B]       " ASCII and Hex values for char at cursor
endif

" Whitespace settings
set nowrap                         " don't wrap lines
set tabstop=2                      " a tab is two spaces
set shiftwidth=2                   " an autoindent (with <<) is two spaces
set softtabstop=2                  " if we have smart tabs, treat like hard tabs
set noexpandtab                    " Use hard tabs
set list                           " Show invisible characters
set backspace=indent,eol,start     " backspace through everything in insert mode

" List chars
set listchars=""                   " Reset the listchars
set listchars=tab:\ \              " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.             " show trailing spaces as dots
set listchars+=extends:>           " The character to show in the last column when wrap is off and the line continues beyond the right of the screen
set listchars+=precedes:<          " The character to show in the last column when wrap is off and the line continues beyond the right of the screen

" Fold settings
set foldmethod=marker
set foldenable

" Tlist settings
let tlist_php_settings = 'php;c:class;f:function;d:constant'
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window = 1
let Tlist_Close_On_Select = 1

" Syntastic settings
let g:syntastic_mode_map = { 'mode': 'active',
			\ 'active_filetypes': [],
			\ 'passive_filetypes': ['cucumber'] }

" Vroom settings
if filereadable("script/features")
	let g:vroom_cucumber_path = "./script/features"
end
if filereadable("script/test")
	let g:vrom_spec_command = "./script/test"
end

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""
"" Wild settings
""

" TODO: Investigate the precise meaning of these settings
" set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Backup and swap files
""

set backupdir=~/.vim/_backup//    " where to put backup files.
set directory=~/.vim/_temp//      " where to put swap files.
set nobackup                      " But fuck it no backups
set noswapfile                    " Also fuck swaps

""
"" Hooks
""

if has("autocmd")
	augroup vimrc_autocmds
		" NERD Tree settings
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if NERD Tree is our only window
	augroup END
	" Jump to last cursor position unless it's invalid or in an event handler
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\   exe "normal g`\"" |
				\ endif

	" Language specific indentation
	autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
end

""
"" Mappings
""
let mapleader=","

nmap <leader>hs :set hlsearch! hlsearch?<CR>
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Edit mode helpers
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Caps is ctrl -- need to make esc something I can actually type
inoremap kj <Esc>

" Forcing myself to not use arrow keys in insert mode and ctrl+[
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

" Taglist Mappings
nnoremap <leader>tl :Tlist<CR>

" NERD Tree mappings
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
