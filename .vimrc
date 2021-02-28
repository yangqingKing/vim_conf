" Vim Config
" @author yangqing
"
"colorscheme default
colorscheme desert

" 自定义颜色分组
hi User1 term=reverse cterm=bold ctermfg=14 ctermbg=22
hi User2 term=reverse ctermfg=0 ctermbg=23

set shortmess=filnxtToO
set termencoding=utf-8 " 设置终端编码
set fileformat=unix " 默认文件格式
"set fencs=utf-8,gbk
set ignorecase " 搜索时忽略大小写
set encoding=utf-8 " 文件编码
" winvim
if has("win32")
    set fileencodings=utf-8,chinese,latin-1
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    set fileencoding=chinese
    set guioptions=egmLt
else
    set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
endif

""解决consle输出乱码
language messages zh_CN.utf-8
set nobackup " 不生成备份文件
set shell=sh
set noswapfile
set scrolloff=3 " 底部滚动距离
"set clipboard="*
set clipboard=unnamed " 默认使用系统剪贴板
set sts=4 " 自动插入4个空格
set tabstop=4 " tab转换为4个空格
set shiftwidth=4
set expandtab " tab转换为空格
set nocompatible    " 不要使用vi的键盘模式，而是vim自己的
set bs=indent,eol,start     " allow backspacing over everything in insert mode
set ai          " always set autoindenting on
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
set history=50      " keep 50 lines of command line history " than 50 lines of registers
set ruler       " show the cursor position all the time
set nu " 显示行号
"set relativenumber " 显示相对行号
set incsearch " 高亮搜索
"set cscopequickfix=s-,c-,d-,i-,t-,e-
set textwidth=500
" 标签栏样式
set tabline=%!Q_TabLine()
set laststatus=2 " 总是显示状态行
" 状态栏样式
"set statusline=%2*\[\%{Q_Mode()}\]%1*\ %f\ %0*%h%m%r%h%w%y\ \[%{&ff}\|%{&fenc}\]%<%=\[%{strftime(\"%y\.%m\.%d\ %H:%M:%S\",getftime(expand(\"%:p\")))}\]\ line:%l\,%v\ col:%c\ sum:%L\ %p%%
set statusline=%2*\[\%{Q_Mode()}\]%1*\ %f\ %0*%h%m%r%h%w%y\ \[%{&ff}\|%{&fenc}\]%<%=\ line:%l\,%v\ col:%c\ sum:%L\ %p%%\ \[%{strftime(\"%y\.%m\.%d\ %H:%M:%S\",getftime(expand(\"%:p\")))}\]
set showcmd "显示命令
set list " 显示特殊符
"set listchars=tab:>-,trail:>,extends:*,precedes:<,eol:$
set listchars=tab:»→,trail:→,extends:*,precedes:< " 定义特殊符号显示
set pastetoggle=<F1> " 粘贴模式与插入模式切换
set cursorline " 高亮当前行
" 高亮显示空格
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" 初始化插件配置
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" 自定义注释
let s:delimiterMap = {
    \ 'blade': { 'left': '{{--', 'right':'--}}' }
    \}

" 插件变量
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 60
let &guicursor = &guicursor . ",a:blinkon0"
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Display_Prototype=0
"let NERDTreeQuitOnOpen=0
let NERDTreeShowBookmarks=0
let NERDTreeMinimalUI=1
let g:debuggerPort = 9010
let mapleader=' '

let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let s:rainbow_conf = {
\   'guifgs': ['darkorange3', 'royalblue3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightyellow', 'lightblue', 'lightcyan', 'lightmagenta'],
\   'guis': [''],
\   'cterms': [''],
\   'operators': '_,_',
\   'contains_prefix': 'TOP',
\   'parentheses_options': '',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'markdown': {
\           'parentheses_options': 'containedin=markdownCode contained',
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'haskell': {
\           'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
\       },
\       'ocaml': {
\           'parentheses': ['start=/(\ze[^*]/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\[|/ end=/|\]/ fold', 'start=/{/ end=/}/ fold'],
\       },
\       'tex': {
\           'parentheses_options': 'containedin=texDocZone',
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'vim': {
\           'parentheses_options': 'containedin=vimFuncBody,vimExecute',
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold'],
\       },
\       'xml': {
\           'syn_name_prefix': 'xmlRainbow',
\           'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\       },
\       'xhtml': {
\           'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((script|style|area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'perl': {
\           'syn_name_prefix': 'perlBlockFoldRainbow',
\       },
\       'php': {
\           'syn_name_prefix': 'phpBlockRainbow',
\           'contains_prefix': '',
\           'parentheses': ['start=/(/ end=/)/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\[/ end=/\]/ containedin=@htmlPreproc contains=@phpClTop', 'start=/{/ end=/}/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold contains_prefix=TOP'],
\       },
\       'stylus': {
\           'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
\       },
\       'css': 0,
\       'sh': 0,
\   }
\}

let g:sneak#label = 1
"let g:ag_prg="./ --vimgrep"
let g:ag_working_path_mode="r"

let g:NERDTreeMapJumpFirstChild='' " 去掉nerdtree J快捷键
let g:NERDTreeMapJumpLastChild='' " 去掉nerdtree K快捷键

" Vue
au BufNewFile,BufRead *.html,*.js,*.vue setlocal tabstop=2
au BufNewFile,BufRead *.html,*.js,*.vue setlocal softtabstop=2
au BufNewFile,BufRead *.html,*.js,*.vue setlocal shiftwidth=2
au BufNewFile,BufRead *.html,*.js,*.vue setlocal expandtab
au BufNewFile,BufRead *.html,*.js,*.vue setlocal autoindent
au BufNewFile,BufRead *.html,*.js,*.vue setlocal fileformat=unix
" 解决滑动过快高亮失效的情况
" End Vue

"注释的作者
let g:pdv_cfg_Author = "YQ"
au TabLeave * let g:lastTabNr = tabpagenr()
"au InsertEnter * hi StatusLine term=reverse ctermfg=255 ctermbg=5 gui=undercurl guisp=Magenta
"au InsertLeave * hi StatusLine term=reverse ctermfg=253 ctermbg=58 gui=bold,reverse
au InsertLeave * call LeaveStatuslineColor() " 退出插入模式回调
au InsertEnter * call InsertStatuslineColor(v:insertmode) " 进入插入模式回调
"au InsertChange * call InsertStatuslineColor(v:insertmode)

" default the statusline to green when entering Vim

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
  autocmd StdinReadPre * let s:std_in=1
 " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

 " xdebug日志语法识别
 augroup filetypedetect
     au BufNewFile,BufRead *.xt  setf xt
 augroup END
endif
" vim-vue
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

"ack
"<Leader>c进行搜索，同时不自动打开第一个匹配的文件"
"map <Leader>c :Ack!<Space>

"高亮搜索关键词
let g:ackhighlight = 1
"修改快速预览窗口高度为15
let g:ack_qhandler = "botright copen 15"
"在QuickFix窗口使用快捷键以后，自动关闭QuickFix窗口
let g:ack_autoclose = 1
"使用ack的空白搜索，即不添加任何参数时对光标下的单词进行搜索，默认值为1，表示开启，置0以后使用空白搜索将返回错误信息
let g:ack_use_cword_for_empty_search = 1
"部分功能受限，但对于大项目搜索速度较慢时可以尝试开启
"let g:ack_use_dispatch = 1

"关闭c-x,c-o后的预览框功能
set completeopt-=preview
" 识别PHP类变量关键符合，快捷键ctrl-x 然后ctrl-o
if !exists('g:AutoComplPop_Behavior')
    let g:AutoComplPop_Behavior = {}
    let g:AutoComplPop_Behavior['php'] = []
    call add(g:AutoComplPop_Behavior['php'], {
            \   'command'   : "\<C-x>\<C-o>",
            \   'pattern'   : printf('\(->\|::\|\$\)\k\{%d,}$', 0),
            \   'repeat'    : 0,
            \})
endif
let g:phpcomplete_mappings = {
  \ 'jump_to_def': ',g',
  \ 'jump_to_def_tabnew': ',f',
  \ }
" fzf
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
" [Buffers] 如果可能跳到已存在窗口
let g:fzf_buffers_jump = 1

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on
filetype plugin indent on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

"autocmd BufWrite * call write()
au FileType php setlocal dictionary+=~/.vim/plugin/php_funclist.txt
au FileType javascript setlocal dictionary+=~/.vim/plugin/js_funclist.txt
"set dictionary+=~/.vim/plugin/vue_funclist.txt

function! SetTagPath()
    let path = substitute(getcwd(), "/", "_", "g")
    execute 'set tag=/Users/yangqing/.tag_files/'.path
    return path
endfunction

function! InsertStatuslineColor(mode)
    if a:mode == 'i'
        hi User2 term=reverse ctermfg=255 ctermbg=5 gui=undercurl guisp=Magenta
    elseif a:mode == 'r'
        hi statusline guibg=blue
    else
        hi statusline guibg=red
    endif
endfunction

function! LeaveStatuslineColor()
    hi StatusLine term=reverse ctermfg=253 ctermbg=58 gui=bold,reverse
endfunction

function! SudoWrite()
    let current = getpos('.')
    execute '%!sudo tee %'
    edit!
    call setpos('.', current)
endfunction

function! Search_Define()
    let word = expand("<cword>")
    :tabnew
        execute 'vimgrep /function\s\+'.word.'\|class\s\+'.word."/ **/*.php"
endfunction

"function! Search_Keyword()
    "let word = expand("<cword>")
    ":tabnew
    ""execute 'vimgrep /'.word."/ **/*.php"
"endfunction

function! Q_Find_Define()
    let word = expand("<cword>")
    :tabnew
    execute 'cs find g '.word
endfunction

function! Q_Reload_Vimrc_Config()
    source /etc/vimrc
    echo 'reload vimrc finish'
endfunction

function! Q_Mode()
    let mode = mode()
    if mode == 'n'
        return 'NORMAL'
    elseif mode == 'i'
        return 'INSERT'
    elseif mode == 'v'
        return 'VISUAL'
    elseif mode == 'V'
        return 'VISUAL-C'
    elseif mode == '!'
        return 'LINUX'
    else
        return mode
endfunction

function! Q_Help()
    echo ":syntax sync fromstart #刷新语法高亮"
    echo ':%s/%body%/hello/g   #gc替换确认'
    echo ':set filetype=html '
    echo ':set syntax=perl   #语法高亮'
    echo ':set foldmethod=indent   #缩进折叠'
    echo ':set iskeyword=a-z,A-Z,_,48-57  #区分单词'
    echo ':call s:FindInTaglist("<cword>")  #搜索tag'
    echo ':vimgrep /xxx/ **/*.php  #搜索tag'
    echo 'Ctrl + w, n, +/- #调整高度Ctrl + w, n, >/< #调整宽度'
    echo 'grep -rn "PHP_FUNCTION(socket_accept)" ./ext  #搜索php源码'
endfunction

function! Q_Test1()
    #let namespace = system("awk '/^namespace\ (.*)\;/{print $2}' ".bufname("%"));
    let commentline = line (".")+1
    call append(commentline,'var_dump($);exit;')
    exe commentline+1
    exe 'norm! f$'
endfunction

function! Q_PHP_Debug()
    let commentline = line (".")
    call append(commentline,'var_dump($);exit;')
    exe commentline+1
    exe 'norm! f$'
endfunction

function! Q_TabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let filename = bufname(buflist[winnr - 1])
  return strpart(filename,strridx(filename,'/')+1)
endfunction

function! Q_TabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        let tabnr = i + 1 " range() starts at 0
        let winnr = tabpagewinnr(tabnr)
        let buflist = tabpagebuflist(tabnr)
        let bufnr = buflist[winnr - 1]
        let bufname = fnamemodify(bufname(bufnr), ':t')

        let s .= '%' . tabnr . 'T'
        let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
        let s .= '[' . tabnr

        let n = tabpagewinnr(tabnr,'$')
        if n > 1 | let s .= ':' . n | endif

        let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '

        let bufmodified = getbufvar(bufnr, "&mod")
        if bufmodified | let s .= "+ " | endif
    endfor
    let s .= '%#TabLineFill#'
    return s
endfunction

" linux 多终端无缝复制黏贴
" 配合autohotkey，达到与window无缝复制黏贴
" 不解释!!!
function! Q_Copy()
   let var_q =  getreg('"')
   let var_amode = getregtype('"')
   call setreg('q', var_q, var_amode)

   let reg_q = split(var_q, "\n")
   call writefile(reg_q, $HOME.'/.vim_qreg')
   echo "复制成功, 呵呵"
endfunction

function! Q_Paste()
   let var_q =  readfile($HOME.'/.vim_qreg')
   let var_reg = join(var_q, "\n")

   call setreg('q', var_reg)
   echo "执行[ \"qp ]进行粘贴"
   exe 'norm! "qp'
endfunction

" 获取当前文件路径
function! Q_GetCurFilePath()
    let cur_dir=getcwd()
    let cur_file_name=getreg('%')
    let dir_filename=cur_dir.'/'.cur_file_name
    echo dir_filename."         done"
    call setreg('+',dir_filename)
endfunction

" 设置tag文件位置
call SetTagPath()

" MapList
nnoremap q :q<CR>
nnoremap ` :tabfirst<CR>
nnoremap <silent> J :tabp<CR>
nnoremap <silent> K :tabn<CR>
nmap <silent> mm :qa<CR>
"nmap <space> <c-e>j

"silent 静默执行，不显示回显信息
" 标记
nmap <silent> gj :call Highlight_Word()<CR>
" 取消标记
nmap <silent> gJ :call Highlight_Word_Clear()<CR>
" 跳转到下一个匹配
nmap <silent> gn :call search('\<'.expand('<cword>').'\>')<CR>
" 跳转到上一个匹配
nmap <silent> gN :call search('\<'.expand('<cword>').'\>','b')<CR>
" 标记跳转
nmap <silent> go :call NextMatchWord()<CR>
nmap <silent> gO :call PrevMatchWord()<CR>

" 函数搜索
"map <F1> :call Search_Define()<CR>
" 刷新语法高亮
map <F5> :syntax sync fromstart<CR>
nmap <silent>gk :call FindInTaglistHere()<CR>
nmap gK :call FindAllTaglistHere()<CR>
nmap gs :call Search_Keyword()<CR>
" 单词搜索
nmap <F3> :call Search_Keyword()<CR>
nmap <F4> :Ffile<CR>/
" 空格替换tab
" 复制
vmap <silent><C-c> :y q<CR>
"map <C-p> :pu q<CR>
"map <leader>c "qy
" 复制到临时文件
nmap <leader>c "qy<CR>:call Q_Copy()<CR>
"map <leader>p "qp
nmap <leader>p :call Q_Paste()<CR>
nmap <leader>cc  " 加注释
nmap <leader>cu   " 解开注释

"map <leader>c<space>  加上/解开注释, 智能判断
"map <leader>cy   先复制, 再注解(p可以进行黏贴)

" V模式下复制不替换剪贴板
xnoremap p pgvy
noremap cw "_cw
"noremap dw "_dw
"map x "_x
nnoremap x "_x
"nnoremap x "_x
"map c{motion} "_c{motion}
"nnoremap yy "yyy
"noremap p "yp

nnoremap <C-n> :NERDTreeToggle<CR>
"nnoremap <C-t> :TagbarToggle<CR>
nnoremap <C-t> :TlistToggle<CR>
nnoremap <C-p> :Files<CR>
nnoremap gl :Buffers<CR>
nnoremap <silent> <Leader>a :Ag
nnoremap <leader>j :cn<CR>
nnoremap <leader>k :cp<CR>
noremap <leader>g :call Q_PHP_Debug()<CR>a
nnoremap gw :call Search_Keyword()<CR>

" 插入当前时间
nnoremap <leader>d "=strftime("%Y-%m-%d %H:%M:%S")<CR>gp

map <leader>e <Plug>Sneak_s
map <leader>w <Plug>Sneak_S
map <leader>b <Plug>Sneak_S
nnoremap r <Plug>sneak_s
"nmap <c-r> <Plug>Sneak_S
map <leader>r <Plug>Sneak_S
"noremap <C-k> dd<UP>P
"noremap <C-j> ddp
nmap <leader>t :call Q_GetCurFilePath()<CR>
" 函数类注释
nmap <leader>y :call PhpDocSingle()<CR>
nmap <leader>o :NERDTreeFind<CR>
nmap <leader>i :call CommentPhpFile()<CR>
" 去除结尾空格
nmap <leader>l :%s/  *$//g<CR>
nmap <silent><leader>ss :call Q_Reload_Vimrc_Config()<cr>
" nnoremap <Tab> :exec "tabnext ".g:lastTabNr<CR>

"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-l> <Right>
"inoremap <special> <C-h> <Left>
"inoremap  <C-h> <Left>
" easy motion
let g:EasyMotion_leader_key='.'
"let g:EasyMotion_do_mapping = 0
"nmap r <Plug>(easymotion-j)
" let g:EasyMotion_smartcase = 1
"nmap <leader>j <Plug>(easymotion-j)
"nmap <leader>k <Plug>(easymotion-k)

command! Qhelp :call Q_Help()
command! Test :call Q_Test1()
let g:svn_ignore = ['storage/', 'tags$','\.zcache', 'public/1.html', '.env']
let g:common_author = "YQ"

command! Qsvn :call Q_SvnStatus()
command! W :w
command! Qa :qa
command! Qtab %retab!<CR>
command! -nargs=0 Sudow call SudoWrite()


"set iskeyword="a-z,A-Z,_,48-57"   " 区分单词
"
" let Vundle manage Vundle
" required!
" 插件配置
Bundle 'gmarik/vundle'

Bundle 'ack.vim'
Bundle 'AutoComplPop'
Bundle 'matchit.zip'
Bundle "yianwillis/vimcdoc"
"Bundle 'Tagbar'
Bundle 'taglist.vim'
Bundle 'posva/vim-vue'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'file:///Users/hxsd/.vim_plugin/nerdtree'
"Bundle 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
"Bundle 'file:///Users/hxsd/.vim_plugin/ack.vim'
"Bundle 'file:///Users/hxsd/.vim_plugin/vim-easymotion'
"Bundle 'file:///Users/hxsd/.vim_plugin/tagbar'
"Bundle 'file:///Users/hxsd/.vim_plugin/ctrlp.vim'
Bundle 'file:///Users/hxsd/.vim_plugin/asyncrun.vim'
Bundle 'git://github.com/justinmk/vim-sneak.git'
Bundle 'git://github.com/junegunn/fzf.git', { 'dir': '~/.fzf', 'do': './install --all' }
Bundle 'git://github.com/junegunn/fzf.vim.git'
Plugin 'JuliaEditorSupport/julia-vim'
Bundle 'luochen1990/rainbow'
"Bundle 'neoclide/coc.nvim', {'branch': 'release'}

" 备注
hi Comment ctermfg=242 ctermbg=0 guibg=DarkGrey
" diff
hi DiffChange ctermfg=15 ctermbg=242 guibg=DarkGrey
