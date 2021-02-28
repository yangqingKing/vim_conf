"2014.7.9 PHP保存时自动检查
function! CheckPHP()
    " execute "%s/\s\+$//"
    " execute "%retab!"
    if &filetype == 'php'
        "let result = system('php -l -d error_reporting=E_ALL -d display_errors=1 '.expand('%'))
        let result = system('/Users/yangqing/app/php/src/bin/php -n -l -d error_reporting=E_ALL -d display_errors=1 '.expand('%'))
        if (stridx(result, 'No syntax errors detected') == -1)
            echohl WarningMsg
            echo result
            echohl None
        endif
    endif
endfunction

function! CommentPhpFile()
    if !exists('g:common_author')
        let g:common_author = "vimer"
    endif
    call append(0, "<?php")
    call append(1, "/**")
    call append(2, " * Created by VIM.")
    call append(3, " * Author:". g:common_author)
    call append(4, " * Date:" . strftime("%Y/%m/%d\ %H:%M:%S"))
    call append(5, " */")
endfunction

"创建php文件时自动添加注释
function! NewFileStruct()
    if &filetype == 'php'
        call CommentPhpFile()
    endif
endfunction

"读取php文件时自动添加注释
function! ReadFileStruct()
    if(&filetype == 'php')
        " blade模板
        if(stridx(expand('%'), '.blade.php') > 0)
            set filetype=html
        else
            if line('$') <= 1
                if empty(getline(1))
                    call CommentPhpFile()
                endif
            endif
        endif
    "else
        "set sts=4 " 自动插入4个空格
        "set tabstop=4 " tab转换为4个空格
        "set shiftwidth=4 " tab转换为4个空格
    endif
endfunction

autocmd BufWritePost * call CheckPHP()
autocmd BufNewFile * call NewFileStruct()
autocmd BufReadPost * call ReadFileStruct()
" map gep :call CheckPHP()<CR>
