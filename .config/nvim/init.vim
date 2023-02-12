"
" Tips:
"
" - :noh to clear highlighting
" - g* to search for current word
" - gq to reformat line into column
" - y[target] to yank, d[target] to cut
" - "[reg] to yank/cut/paste to reg
" - ys[target][char] to add surrounding chars
" - gS, gJ to split and join multiline statements
" - iw targets full word, aw targets full word with space
" - gd to go to definition
" - CTRL-^ to go to previous file
"

call plug#begin()

" language server protocol

"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" snippets

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

"autocmd FileType * nmap gD <plug>(lsp-definition)
"autocmd FileType * nmap gd <plug>(lsp-peek-definition)
"autocmd FileType * nmap gY <plug>(lsp-type-definition)
"autocmd FileType * nmap gy <plug>(lsp-peek-type-definition)
"autocmd FileType * nmap gr <plug>(lsp-references)
"autocmd FileType * nmap gf <plug>(lsp-document-symbol-search)
"autocmd FileType * nmap gF <plug>(lsp-workspace-symbol-search)
"autocmd FileType * nmap gk <plug>(lsp-next-diagnostic)
"
"autocmd FileType * nmap <leader>f <plug>(lsp-document-format)
"autocmd FileType * nmap <leader>k <plug>(lsp-code-action)
"autocmd FileType * nmap <leader>x <plug>(lsp-code-lens)
"autocmd FileType * nmap <leader>n <plug>(lsp-rename)
"
"function! SplitTerm(height, cmd)
"	split
"	exe "resize " . a:height
"	exe "terminal " . a:cmd
"endfunction

" rust

"autocmd FileType rust nmap <leader>t :call SplitTerm(16, "cargo test")<CR>
"autocmd FileType rust nmap <leader>b :call SplitTerm(16, "cargo build")<CR>
"autocmd FileType rust nmap <leader>r :call SplitTerm(16, "cargo run")<CR>
"autocmd FileType rust nmap K <plug>(lsp-hover)

" go

"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"let g:go_highlight_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_function_calls = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_extra_types = 1
"let g:go_highlight_build_constraints = 1
"let g:go_highlight_generate_tags = 1
"let g:go_metalinter_autosave = 1
"let g:go_fmt_command = "goimports"
"let g:go_list_type_commands = {"GoMetaLinterAutoSave": "quickfix"}
"let g:go_def_mapping_enabled = 0
"autocmd FileType go nmap gD <Plug>(go-def)
"autocmd FileType go nmap gd <Plug>(go-def-split)
"autocmd FileType go nmap gY <Plug>(go-def-type)
"autocmd FileType go nmap gy <Plug>(go-def-type-split)
"autocmd FileType go nmap <leader>a <Plug>(go-alternate-edit)
"autocmd FileType go nmap <leader>t <Plug>(go-test)
"autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
"autocmd FileType go nmap <leader>b <Plug>(go-build)
"autocmd FileType go nmap <leader>r <Plug>(go-run)
"autocmd FileType go nmap K <Plug>(go-doc)

" javascript & typescript

"autocmd FileType javascript,typescript nmap <leader>t :call SplitTerm(16, "npm test")<CR>
"autocmd FileType javascript,typescript nmap <leader>b :call SplitTerm(16, "npm run build")<CR>
"autocmd FileType javascript,typescript nmap <leader>r :call SplitTerm(16, "npm start")<CR>
"autocmd FileType javascript,typescript nmap K <plug>(lsp-hover)

" vue

"Plug 'posva/vim-vue'

" more language servers

"if executable('astro-ls')
"	" npm install --global @astrojs/language-server
"	au User lsp_setup call lsp#register_server({'name': 'astro-ls', 'cmd': {server_info->['astro-ls']}, 'allowlist': ['astro']})
"endif

" git

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" extra motions

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim'

" extra completion

"Plug 'github/copilot.vim'

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

let g:git_branch = GitBranch()
let g:git_dirty = GitDirty()
function! StatuslineUpdateLazy()
	let g:git_branch = GitBranch()
	let g:git_dirty = GitDirty()
endfunction

function! StatuslineGit()
	return strlen(g:git_branch) > 0?'  '.g:git_branch.' ':''
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
set statusline+=%#StatuslineGit#%{(g:git_dirty)?'':StatuslineGit()}
set statusline+=%#StatuslineGitDirty#%{(g:git_dirty)?StatuslineGit():''}
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

" browser

autocmd FileType * nmap <space>b :Lexplore 26<CR>

" folding, numbering, cursorline

set foldcolumn=1
set number
set relativenumber
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

" code completion using language server protocol

lua require("lsp")
