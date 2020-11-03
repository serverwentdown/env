call plug#begin()

" rust

Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

" go

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)

call plug#end()

" theme

set background=dark
if $LIGHT == 'true'
	set background=light
endif
silent! colorscheme solarized

" statusline

function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
function! GitDirty()
	return system("git status --porcelain --ignore-submodules -unormal 2>/dev/null") != ""
endfunction

let w:git_branch = GitBranch()
let w:git_dirty = GitDirty()
function! StatuslineUpdateLazy()
	let w:git_branch = GitBranch()
	let w:git_dirty = GitDirty()
endfunction

function! StatuslineGit()
	return strlen(w:git_branch) > 0?'  '.w:git_branch.' ':''
endfunction

" assembly

set statusline=
set statusline+=%#StatuslineModeNormal#%{(mode()=='n')?'\ \ NORMAL\ \ ':''}
set statusline+=%#StatuslineModeInsert#%{(mode()=='i')?'\ \ INSERT\ \ ':''}
set statusline+=%#StatuslineModeReplace#%{(mode()=='R')?'\ \ REPLACE\ ':''}
set statusline+=%#StatuslineModeVisual#%{(mode()=='v')?'\ \ VISUAL\ \ ':''}
set statusline+=%#StatuslineModeVisualLine#%{(mode()=='V')?'\ \ VISUAL\ \ ':''}
set statusline+=%#StatuslineModeVisual#%{(mode()==\"\\\<C-V>\")?'\ \ V-BLOCK\ ':''}
set statusline+=%#StatuslineModeCommand#%{(mode()=='c')?'\ \ COMMAND\ ':''}
set statusline+=%#StatuslineModeOther#%{(mode()=='s')?'\ \ SELECT\ \ ':''}
set statusline+=%#StatuslineModeOther#%{(mode()=='S')?'\ \ S-LINE\ \ ':''}
set statusline+=%#StatuslineModeOther#%{(mode()==\"\\\<C-S>\")?'\ \ S-BLOCK\ ':''}
set statusline+=%#StatuslineModeOther#%{(mode()=='t')?'\ \ TERMINAL\ ':''}
set statusline+=%#StatuslineGit#%{(w:git_dirty)?'':StatuslineGit()}
set statusline+=%#StatuslineGitDirty#%{(w:git_dirty)?StatuslineGit():''}
set statusline+=%*
set statusline+=\ %f
set statusline+=\ %m
set statusline+=\%r
set statusline+=%=
set statusline+=%#StatuslineFileInfo#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&fileformat}
set statusline+=\ 
set statusline+=%#StatuslineFileStats#
set statusline+=\ %L×%p%%
set statusline+=\ 
set statusline+=%#StatuslineCursor#
set statusline+=\ %l:%c
set statusline+=\ 
augroup StatuslineUpdate
	autocmd BufWritePost,BufEnter,ShellCmdPost * call StatuslineUpdateLazy()
augroup END

" folding, numbering, cursorline

set foldcolumn=1
set number
set cursorline

" indentation

set tabstop=4
set softtabstop=4
set shiftwidth=4

" width

set colorcolumn=80
"set textwidth=80

" enable configuring indentation and width using modeline

set modeline

" skel

augroup Skel
	autocmd BufNewFile *.sh 0r ~/.config/nvim/skel/skel.sh
	autocmd BufNewFile *.md 0r ~/.config/nvim/skel/skel.md
	autocmd BufNewFile *.html 0r ~/.config/nvim/skel/skel.html
	autocmd BufNewFile *.py 0r ~/.config/nvim/skel/skel.py
augroup END

" characters, hidden characters

set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:·,diff:-
set list
let g:listchars = [ "tab:\\\ \\\ ,extends:›,precedes:‹,nbsp:␣,trail:·", "tab:⇥\\\ ,extends:›,precedes:‹,nbsp:␣,trail:·,space:·", "tab:⇥\\\ ,extends:›,precedes:‹,nbsp:␣,trail:·,space:·,eol:↵"]
let g:listchars_mode = -1 " -1 means default is 0
function! ToggleListChars()
	let g:listchars_mode += 1
	if g:listchars_mode >= len(g:listchars)
		let g:listchars_mode = -1
		call ToggleListChars()
	else
		exe "set listchars=".g:listchars[g:listchars_mode]
	endif
endfunction
call ToggleListChars()
command! NonPrintable call ToggleListChars()
command! NP call ToggleListChars()

" file browser

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=25

" spellcheck

set spell spelllang=en_gb
