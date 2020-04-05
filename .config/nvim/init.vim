

" setup plugins


call plug#begin()

" theme
Plug 'altercation/vim-colors-solarized'

" completion
" TODO: REMOVE ALL OUR CUSTOM COMPLETIONS AND USE LANGUAGE SERVER
" TODO: CHOOSE LINTING AND FORMATTING TOOLS
function! DoNvimPluginUpdate(arg)
  UpdateRemotePlugins
endfunction
"Plug 'Shougo/deoplete.nvim', { 'do': function('DoNvimPluginUpdate') }
let g:deoplete#enable_at_startup = 1 " enable at startup
"let g:deoplete#max_abbr_width = 0 " no width limit
"let g:deoplete#max_menu_width = 0 " no width limit
let g:deoplete#enable_smart_case = 1 " enable smart case
"let g:deoplete#file#enable_buffer_path = 1
set completeopt=menuone,noinsert,longest
"inoremap <silent><expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

" git
Plug 'tpope/vim-fugitive'
" [c] Git commit
nnoremap <silent> <Leader>c :<C-u>Gcommit<CR>
" [p] Git pull 
nnoremap <silent> <Leader>p :<C-u>Gpull<CR>
" [u] Git push
nnoremap <silent> <Leader>u :<C-u>Gpush<CR>
" [w] Git write and add
nnoremap <silent> <Leader>w :<C-u>Gwrite<CR>
" [l] Git blame
nnoremap <silent> <Leader>l :<C-u>Gblame<CR>
" [s] Git status
nnoremap <silent> <Leader>s :<C-u>Gstatus<CR>

" c, c++
Plug 'zchee/deoplete-clang', { 'for': [ 'c', 'cpp', 'h' ] }

" html, css
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'css', 'scss', 'vue', 'javascript' ] }
let g:user_emmet_leader_key = '<C-t>'
function! s:setup_emmet_shortcut()
  imap <expr> <C-e> emmet#expandAbbrIntelligent("\<C-e>")
endfunction
autocmd FileType html,css,scss,vue,javascript call s:setup_emmet_shortcut()

" markdown (better)
Plug 'plasticboy/vim-markdown', { 'for': [ 'markdown' ] }
let g:vim_markdown_folding_style_pythonic = 1

" javascript
Plug 'wokalski/autocomplete-flow', { 'for': [ 'javascript' ] }
Plug 'Quramy/vim-js-pretty-template', { 'for': [ 'javascript' ] }
function! s:setup_prettytemplate()
  JsPreTmpl
endfunction
"autocmd FileType javascript call s:setup_prettytemplate()
" Moved to plugin init
Plug 'posva/vim-vue', { 'for': [ 'vue' ] }

" go
function! BuildDeopleteGo(arg)
  :echom "install/update github.com/nsf/gocode"
  :silent !go get -u github.com/nsf/gocode
  :silent !make
endfunction
Plug 'zchee/deoplete-go', { 'for': [ 'go' ], 'do': function('BuildDeopleteGo') }
function! BuildVimGo(arg)
  :echom "install/update github.com/nsf/gocode"
  :silent !go get -u github.com/nsf/gocode
  :echom "install/update github.com/alecthomas/gometalinter"
  :silent !go get -u github.com/alecthomas/gometalinter
  :echom  "install/update golang.org/x/tools/cmd/goimports"
  :silent !go get -u golang.org/x/tools/cmd/goimports
  :echom "install/update golang.org/x/tools/cmd/guru"
  :silent !go get -u golang.org/x/tools/cmd/guru
  :echom "install/update golang.org/x/tools/cmd/gorename"
  :silent !go get -u golang.org/x/tools/cmd/gorename
  :echom "install/update github.com/golang/lint/golint"
  :silent !go get -u github.com/golang/lint/golint
  :echom "install/update github.com/kisielk/errcheck"
  :silent !go get -u github.com/kisielk/errcheck
  :echom "install/update github.com/jstemmer/gotags"
  :silent !go get -u github.com/jstemmer/gotags
  :echom "install/update github.com/klauspost/asmfmt/cmd/asmfmt"
  :silent !go get -u github.com/klauspost/asmfmt/cmd/asmfmt
  :echom "install/update github.com/fatih/motion"
  :silent !go get -u github.com/fatih/motion
  :echom "install/update github.com/zmb3/gogetdoc"
  :silent !go get -u github.com/zmb3/gogetdoc
  :echom "install/update github.com/josharian/impl"
  :silent !go get -u github.com/josharian/impl
endfunction
Plug 'fatih/vim-go', { 'for': [ 'go' ], 'do': function('BuildVimGo') }
let g:go_term_enabled = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_doc_keywordprg_enabled = 1
autocmd FileType go call s:define_go_leader_mappings()
function! s:define_go_leader_mappings()    
  " [r] Run go application
  nnoremap <silent> <Leader>r :<C-u>GoRun<CR>
  " [b] Build go application
  nnoremap <silent> <Leader>b :<C-u>GoBuild<CR>
endfunction

" python
Plug 'python-mode/python-mode', { 'for': [ 'python' ], 'branch': 'develop' }
let g:pymode_rope = 1
"let g:pymode_rope_completion = 1
"let g:pymode_rope_completion_bind = '<C-e>'

" plantuml
Plug 'aklt/plantuml-syntax', { 'for': [ 'plantuml' ] }

call plug#end()


" main configuration


" plugin init

" javascript
autocmd FileType javascript JsPreTmpl

" mapping init

" disable arrow keys in normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map <pageup> <nop>
map <pagedown> <nop>

" disable arrow keys in insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap <pageup> <nop>
imap <pagedown> <nop>

" other init

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

highlight StatusLine ctermfg=14 ctermbg=0 cterm=none
highlight StatusLineNC ctermfg=11 ctermbg=0 cterm=none

" sections
highlight StatuslineModeNormal ctermfg=15 ctermbg=9 cterm=italic
highlight StatuslineModeInsert ctermfg=15 ctermbg=2 cterm=italic
highlight StatuslineModeReplace ctermfg=15 ctermbg=13 cterm=italic
highlight StatuslineModeVisual ctermfg=15 ctermbg=1 cterm=italic
highlight StatuslineModeVisualLine ctermfg=15 ctermbg=1 cterm=bold,italic
highlight StatuslineModeCommand ctermfg=15 ctermbg=4 cterm=italic
highlight StatuslineModeOther ctermfg=15 ctermbg=8 cterm=italic
highlight StatuslineGit ctermfg=14 ctermbg=8 cterm=none
highlight StatuslineGitDirty ctermfg=14 ctermbg=8 cterm=bold
highlight StatuslineFileInfo ctermfg=11 ctermbg=0 cterm=italic
highlight StatuslineFileStats ctermfg=14 ctermbg=8 cterm=none
highlight StatuslineCursor ctermfg=15 ctermbg=9 cterm=none
" assembly
set statusline=
set statusline+=%#StatuslineModeNormal#%{(mode()=='n')?'\ \ NORMAL\ \ ':''}
set statusline+=%#StatuslineModeInsert#%{(mode()=='i')?'\ \ INSERT\ \ ':''}
set statusline+=%#StatuslineModeReplace#%{(mode()=='r')?'\ \ REPLACE\ ':''}
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

" tabline
highlight TabLineFill ctermfg=11 ctermbg=0 cterm=none
highlight TabLine ctermfg=14 ctermbg=0 cterm=none
highlight TabLineSel ctermfg=15 ctermbg=9 cterm=italic

" split
highlight VertSplit ctermfg=0 ctermbg=0 cterm=none

" highlighting
highlight SpellBad cterm=undercurl

" folding
highlight Folded ctermfg=10 ctermbg=none cterm=bold
highlight FoldColumn ctermfg=11 ctermbg=none cterm=none
set foldcolumn=1
" not enabled because folding is usually undesirable
" add modeline foldmethod=syntax to enable
"set foldmethod=syntax

" numbering
set number
highlight LineNr ctermfg=10 ctermbg=none cterm=none

" cursor and line
set cursorline
highlight CursorLine ctermfg=none ctermbg=none cterm=none
highlight CursorLineNR ctermfg=12 ctermbg=none cterm=bold

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
" indentation overrides
"filetype indent on
" TODO: figure out how to properly use the runtime overrides

" skel
augroup Skel
  autocmd BufNewFile *.sh 0r ~/.config/nvim/skel/skel.sh
  autocmd BufNewFile *.md 0r ~/.config/nvim/skel/skel.md
  autocmd BufNewFile *.html 0r ~/.config/nvim/skel/skel.html
  autocmd BufNewFile *.py 0r ~/.config/nvim/skel/skel.py
augroup END

" general
set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:·,diff:-

" hidden characters
let w:listchars = [ "tab:\\\ \\\ ,extends:›,precedes:‹,nbsp:␣,trail:·", "tab:»\\\ ,extends:›,precedes:‹,nbsp:␣,trail:·", "tab:⇥\\\ ,extends:›,precedes:‹,nbsp:␣,trail:·,space:·,eol:↵"]
let w:listchars_mode = -1
highlight Whitespace ctermfg=10 ctermbg=none cterm=none
function! ToggleListChars()
  let w:listchars_mode += 1
  if w:listchars_mode >= len(w:listchars)
    "set nolist
    let w:listchars_mode = -1
    call ToggleListChars()
  else
    set list
    execute "set listchars=".w:listchars[w:listchars_mode]
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

" vim: set expandtab ts=2 sw=2:
