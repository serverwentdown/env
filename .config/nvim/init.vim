" setup plugins

call plug#begin()

" TODO: switch to language server

" rust
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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

call plug#end()

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
highlight StatuslineCursor ctermfg=15 ctermbg=6 cterm=none
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
highlight SpellBad cterm=undercurl ctermbg=0
highlight SpellCap cterm=undercurl ctermbg=0
highlight SpellLocal cterm=undercurl ctermbg=0
highlight SpellRare cterm=undercurl ctermbg=0

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

" selection
highlight Visual ctermfg=none ctermbg=0 cterm=none

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
" indentation overrides
"filetype indent on
" TODO: figure out how to properly use the runtime overrides

" width
highlight ColorColumn ctermfg=none ctermbg=0 cterm=none
"set textwidth=80
set colorcolumn=80

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
let g:listchars = [ "tab:\\\ \\\ ,extends:›,precedes:‹,nbsp:␣,trail:·", "tab:⇥\\\ ,extends:›,precedes:‹,nbsp:␣,trail:·,space:·", "tab:⇥\\\ ,extends:›,precedes:‹,nbsp:␣,trail:·,space:·,eol:↵"]
let g:listchars_mode = 0 " 0 means default is 1
highlight Whitespace ctermfg=11 ctermbg=none cterm=none
function! ToggleListChars()
  let g:listchars_mode += 1
  if g:listchars_mode >= len(g:listchars)
    "set nolist
    let g:listchars_mode = -1
    call ToggleListChars()
  else
    set list
    if g:listchars_mode == 1
      highlight Whitespace ctermfg=237 ctermbg=none cterm=none
    else
      highlight Whitespace ctermfg=11 ctermbg=none cterm=none
    endif
    execute "set listchars=".g:listchars[g:listchars_mode]
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

" modeline
set modeline

" vim: set expandtab ts=2 sw=2:
