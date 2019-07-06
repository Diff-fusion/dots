set tabstop=4
set shiftwidth=4
set relativenumber
set number
set fileencoding=utf-8
filetype plugin on
syntax enable

call plug#begin('~/.local/share/nvim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'ying17zi/vim-live-latex-preview'
Plug 'lervag/vimtex'
Plug 'PietroPate/vim-tex-conceal'
Plug 'vimwiki/vimwiki'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/neoinclude.vim' 
" Plug 'Shougo/deoplete-clangx' 
" Plug 'zchee/deoplete-clang'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'
Plug 'skywind3000/asyncrun.vim'
Plug 'ambv/black'
call plug#end()

" Colors
if filereadable(expand("~/.vimrc_background"))
  	let base16colorspace=256
 source ~/.vimrc_background
endif
"Background
hi Normal ctermbg=NONE

augroup myCmds
au!
au VimLeave * set guicursor=a:ver15-blinkon1
augroup END


""" linenumber
set ruler                                " show position on bottom
set cursorline                           " highlight current line
""" cursor
set scrolloff=10                        " keep the cursor in middle of screen
""" syntax highlighting
"syntax on                                " Enable syntax highlighting
au BufEnter * :syntax sync fromstart     " most accurate syntax highlighting

" hide buffers, not close them
set hidden

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undo
" set noswapfile

" fuzzy find
set path+=**
" lazy file name tab completion
set wildmode=longest,list,full
set wildmenu
set wildignorecase
" ignore files vim doesnt use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

" case insensitive search
set ignorecase
set smartcase
set infercase

" make backspace behave in a sane manner
set backspace=indent,eol,start

" searching
set hlsearch
set incsearch
if has("nvim")
  set inccommand=split
endif


" use indents of 4 spaces
set shiftwidth=4

" an indentation every four columns
set tabstop=4

" enable auto indentation
set autoindent

" disable usless output from black
let g:ale_python_black_options = '-q'

" remove trailing whitespaces and ^M chars
augroup ws
  au!
  autocmd FileType c,cpp,java,php,js,json,css,scss,sass,py,rb,coffee,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
augroup end

" set leader key to comma
let mapleader=","

" new coffee pasta commands
"vnoremap <silent> <leader>y :w !xsel -i -b<CR>
"nnoremap <silent> <leader>y V:w !xsel -i -b<CR>
"nnoremap <silent> <leader>p :silent :r !xsel -o -b<CR>
set clipboard^=unnamedplus

"Nerdtree
map <C-n> :NERDTreeToggle<CR>


"Deoplete autocomplete
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang'

"autocmd CompleteDone * silent! pclose!

" Change clang binary path
call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')

" Change clang options
call deoplete#custom#var('clangx', 'default_c_options', '')
call deoplete#custom#var('clangx', 'default_cpp_options', '')

"let g:deoplete#sources = {}

"call deoplete#custom#option('sources', {'cpp':['clangx', 'include', 'clang', 'file/include'],})

let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
    \ }

let g:LanguageClient_hasSnippetSupport = 0

" Snippets
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction

" augroup SPACEVIM_ASYNCRUN
"     autocmd!
"    " Automatically open the quickfix window
"     autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
" augroup END
"
" asyncrun now has an option for opening quickfix automatically
let g:asyncrun_open = 15

" load project local config
silent! so .vimlocal

" Run Black (Python code formatter) on save
autocmd BufWritePost *.py silent! execute ':Black'


" wiki configuration
let g:vimwiki_list = [{'path': '~/Nextcloud/wiki/text/',
			\ 'path_html': '~/Nextcloud/wiki/html/',
			\ 'template_path': '~/Nextcloud/wiki/templates/',
			\ 'template_default': 'def_template',
			\ 'template_ext': '.html'}]

function! VimwikiLinkHandler(link)
	" Use Vim to open external files with the 'pdf:' scheme.  E.g.:
	let link = a:link
	if link =~# '^local:'
		let link = split(link[6:], '#', 1)
	else
		return 0
	endif
	if get(link, 1, 'default') != 'default'
		let link[1] = split(link[1], '=', 1)[1]
	endif
	if link[0] == ''
		echomsg 'Vimwiki Error: Unable to resolve link!'
		return 0
	elseif link[0] =~# '.pdf$'
		call system('qpdfview --unique ' . link[0] . '#' . get(link, 1) . ' &')
		return 1
	else
		return 0
	endif
endfunction

" Latex Style
let g:tex_flavor='latex'
" For vimtex
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options
			\ = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'
