call plug#begin('~/vimfiles/plugged')

" language server protocol

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" rust

Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
autocmd FileType rust nmap <leader>t :Ctest<CR>
autocmd FileType rust nmap <leader>b :Cbuild<CR>
autocmd FileType rust nmap <leader>r :Crun<CR>
autocmd FileType rust nmap K <Plug>(rust-def)

" gutter: git

Plug 'airblade/vim-gitgutter'

call plug#end()

" theme

colorscheme solarized

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

" enable configuring indentation and width using modeline

set modeline

" spellcheck

set spell spelllang=en_gb
