" No menu bar in the gui
if has("gui_running")
	set guioptions=egmrt
	if has("autocmd")
		augroup vimrc_gui
			au!
			" Automatically resize splits when resizing MacVim window
			autocmd VimResized * wincmd =
		augroup END
	endif
endif

