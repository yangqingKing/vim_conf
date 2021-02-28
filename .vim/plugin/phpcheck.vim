"2014.7.9 PHP����ʱ�Զ����
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

"����php�ļ�ʱ�Զ����ע��
function! NewFileStruct()
    if &filetype == 'php'
        call CommentPhpFile()
    endif
endfunction

"��ȡphp�ļ�ʱ�Զ����ע��
function! ReadFileStruct()
    if(&filetype == 'php')
        " bladeģ��
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
        "set sts=4 " �Զ�����4���ո�
        "set tabstop=4 " tabת��Ϊ4���ո�
        "set shiftwidth=4 " tabת��Ϊ4���ո�
    endif
endfunction

autocmd BufWritePost * call CheckPHP()
autocmd BufNewFile * call NewFileStruct()
autocmd BufReadPost * call ReadFileStruct()
" map gep :call CheckPHP()<CR>
