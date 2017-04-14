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
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set shiftwidth=4
set tabstop=4
set expandtab
set number
set autoindent
set selectmode=mouse
set cmdheight=2
set showmatch
set nobackup
set encoding=utf8
set noswapfile
set smarttab
set magic
set incsearch
set ignorecase
set hlsearch
set nowritebackup
set history=50
set ruler
set showcmd
set nolist
set showmatch
set notildeop
set cursorline
colorscheme desert 

inoremap ( <c-r>=OpenPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { <c-r>=OpenPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ <c-r>=OpenPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
" just for xml document, but need not for now.
"inoremap < <c-r>=OpenPair('<')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
function! OpenPair(char)
    let PAIRs = {
                    \ '{' : '}',
                                    \ '[' : ']',
                                                    \ '(' : ')',
                                                                    \ '<' : '>'
                                                                                    \}
                                                                                        if line('$')>2000
                                                                                                let line = getline('.')
                                                                                                 
                                                                                                         let txt = strpart(line, col('.')-1)
                                                                                                             else
                                                                                                                     let lines = getline(1,line('$'))
                                                                                                                             let line=""
                                                                                                                                     for str in lines
                                                                                                                                                 let line = line . str . "\n"
                                                                                                                                                         endfor
                                                                                                                                                          
                                                                                                                                                                  let blines = getline(line('.')-1, line("$"))
                                                                                                                                                                          let txt = strpart(getline("."), col('.')-1)
                                                                                                                                                                                  for str in blines
                                                                                                                                                                                              let txt = txt . str . "\n"
                                                                                                                                                                                                      endfor
                                                                                                                                                                                                          endif
                                                                                                                                                                                                              let oL = len(split(line, a:char, 1))-1
                                                                                                                                                                                                                  let cL = len(split(line, PAIRs[a:char], 1))-1
                                                                                                                                                                                                                   
                                                                                                                                                                                                                       let ol = len(split(txt, a:char, 1))-1
                                                                                                                                                                                                                           let cl = len(split(txt, PAIRs[a:char], 1))-1
                                                                                                                                                                                                                            
                                                                                                                                                                                                                                if oL>=cL || (oL<cL && ol>=cl)
                                                                                                                                                                                                                                        return a:char . PAIRs[a:char] . "\<Left>"
                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                    return a:char
                                                                                                                                                                                                                                                        endif
                                                                                                                                                                                                                                                        endfunction
                                                                                                                                                                                                                                                        function! ClosePair(char)
                                                                                                                                                                                                                                                            if getline('.')[col('.')-1] == a:char
                                                                                                                                                                                                                                                                    return "\<Right>"
                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                return a:char
                                                                                                                                                                                                                                                                                    endif
                                                                                                                                                                                                                                                                                    endf
                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                     inoremap ' <c-r>=CompleteQuote("'")<CR>
                                                                                                                                                                                                                                                                                     inoremap " <c-r>=CompleteQuote('"')<CR>
                                                                                                                                                                                                                                                                                     function! CompleteQuote(quote)
                                                                                                                                                                                                                                                                                         let ql = len(split(getline('.'), a:quote, 1))-1
                                                                                                                                                                                                                                                                                             let slen = len(split(strpart(getline("."), 0, col(".")-1), a:quote, 1))-1
                                                                                                                                                                                                                                                                                                 let elen = len(split(strpart(getline("."), col(".")-1), a:quote, 1))-1
                                                                                                                                                                                                                                                                                                     let isBefreQuote = getline('.')[col('.') - 1] == a:quote
                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                          if '"'==a:quote && "vim"==&ft && 0==match(strpart(getline('.'), 0, col('.')-1), "^[\t ]*$")
                                                                                                                                                                                                                                                                                                                  " for vim comment.
                                                                                                                                                                                                                                                                                                                          return a:quote
                                                                                                                                                                                                                                                                                                                              elseif "'"==a:quote && 0==match(getline('.')[col('.')-2], "[a-zA-Z0-9]")
                                                                                                                                                                                                                                                                                                                                      " for Name's Blog.
                                                                                                                                                                                                                                                                                                                                              return a:quote
                                                                                                                                                                                                                                                                                                                                                  elseif (ql%2)==1
                                                                                                                                                                                                                                                                                                                                                          " a:quote length is odd.
                                                                                                                                                                                                                                                                                                                                                                  return a:quote
                                                                                                                                                                                                                                                                                                                                                                      elseif ((slen%2)==1 && (elen%2)==1 && !isBefreQuote) || ((slen%2)==0 && (elen%2)==0)
                                                                                                                                                                                                                                                                                                                                                                              return a:quote . a:quote . "\<Left>"
                                                                                                                                                                                                                                                                                                                                                                                  elseif isBefreQuote
                                                                                                                                                                                                                                                                                                                                                                                          return "\<Right>"
                                                                                                                                                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                                                                                                                                                      return a:quote . a:quote . "\<Left>"
                                                                                                                                                                                                                                                                                                                                                                                                          endif
                                                                                                                                                                                                                                                                                                                                                                                                          endfunction
set mouse=a
