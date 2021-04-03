"
" Tips:
"
" - :noh to clear highlighting
" - gd to go to definition 
" - g* to search for current word
" - gq to reformat line into column
"

call plug#begin()

" rust

Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
let g:rustfmt_autosave = 1
autocmd FileType rust nmap <leader>t :Ctest<CR>
autocmd FileType rust nmap <leader>b :Cbuild<CR>
autocmd FileType rust nmap <leader>r :Crun<CR>
autocmd FileType rust nmap K <Plug>(rust-def)
" runthis: cargo +nightly install --git https://github.com/racer-rust/racer.git racer

" go

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_metalinter_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_list_type_commands = {"GoMetaLinterAutoSave": "quickfix"}
autocmd FileType go nmap <leader>a <Plug>(go-alternate-edit)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
" K -> :GoDoc

" c
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'deoplete-plugins/deoplete-clang'

" vue

Plug 'posva/vim-vue'

call plug#end()

" theme

set background=dark
if $LIGHT == 'true'
	set background=light
endif
let g:solarized_termtrans=1
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

fun LoadSkel(ext, title)
	exe "0r ~/.config/nvim/skel/skel." . a:ext
	exe "$d"
	exe "%s/Title/" . a:title . "/e"
endfunction
augroup Skel
	autocmd BufNewFile *.sh call LoadSkel("sh", expand("%:r"))
	autocmd BufNewFile *.md call LoadSkel("md", expand("%:r"))
	autocmd BufNewFile *.html call LoadSkel("html", expand("%:r"))
	autocmd BufNewFile *.py call LoadSkel("py", expand("%:r"))
	autocmd BufNewFile *.yaml,*.yml call LoadSkel("yaml", expand("%:r"))
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
