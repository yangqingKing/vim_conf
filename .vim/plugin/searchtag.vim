"参考:
"http://andrewradev.com/2011/06/08/vim-and-ctags/
"http://www.vim.org/scripts/script.php?script_id=3771
"差异点：同时搜索函数、类、常量等，匹配优化，生成tags命令

command! -nargs=1 F call s:FindInTaglist(<f-args>, '')
command! -nargs=? Fmake call s:TaglistMake(<f-args>)
command! -nargs=? Ffile call s:SearchAllFileNames(<f-args>)

function! NextMatchWord()
    let match_list = getmatches()
    if (empty(match_list))
        echohl WarningMsg | echo '没有匹配内容 ' | echohl None
        return
    endif
    let pos = [999999,999999]
    let pos_str = ''
    let tmp_pos = [0,0]
    for item in match_list
        let tmp_line = searchpos(item['pattern'], 'n')
        if(tmp_line[0] < pos[0] && tmp_line[0]!=0 && tmp_line[1] !=0)
            let pos=tmp_line
            let pos_str = item['pattern']
        elseif(tmp_pos[0] == pos[0] && tmp_pos[1] < pos[1] && tmp_line[0]!=0 && tmp_line[1] !=0)
            let pos=tmp_line
            let pos_str = item['pattern']
        endif
    endfor
    if(pos_str != '')
        call search(pos_str)
    else
        echohl WarningMsg | echo '没有找到内容 ' | echohl None
        return
    endif
endfunction

function! PrevMatchWord()
    let match_list = getmatches()
    if (empty(match_list))
        echohl WarningMsg | echo '没有匹配内容 ' | echohl None
        return
    endif
    let pos = [-1,-1]
    let pos_str = ''
    let tmp_pos = [-1,-1]
    for item in match_list
        let tmp_line = searchpos(item['pattern'], 'bn')
        if(tmp_line[0] > pos[0] && tmp_line[0]!=0 && tmp_line[1] !=0)
            let pos=tmp_line
            let pos_str = item['pattern']
        elseif(tmp_pos[0] == pos[0] && tmp_pos[1] > pos[1] && tmp_line[0]!=0 && tmp_line[1] !=0)
            let pos=tmp_line
            let pos_str = item['pattern']
        endif
    endfor
    if(pos_str != '')
        call search(pos_str,'b')
    else
        echohl WarningMsg | echo '没有找到内容 ' | echohl None
        return
    endif
endfunction

let g:colorIndex = 0
function! Highlight_Word()
    let w = expand("<cword>")
    " let color = ['ErrorMsg', 'DiffChange', 'CursorLine', 'WildMenu', 'DiffAdd', 'SpellLocal']
    let color = ['ErrorMsg', 'DiffChange', 'CursorLine', 'WildMenu', 'DiffAdd', 'SpellLocal', 'DiffText', 'SignColumn', 'PMenuThumb']
    call matchadd(color[g:colorIndex % len(color)], '\<'.w.'\>')
    let g:colorIndex = g:colorIndex + 1
endfunction

function! Highlight_Word_Clear()
    call clearmatches()
endfunction

function! FindInTaglistHere()
    let cword = expand('<cword>')
    let lineword = expand('<cWORD>')
    let filterStr = 'this->.*->'.cword
    if(lineword =~ filterStr)
        let fileKeyword = substitute(lineword, '\$this->\(.*\)->'.cword.'.*','\1','')
        call s:FindInTaglist(cword, fileKeyword)
    else
        call s:FindInTaglist(cword, '')
    endif
endfunction

function! FindAllTaglistHere()
    call s:FindInTaglist(expand('<cword>'), '')
endfunction

function! s:TaglistMake(...)
    let cmd = 'ctags -R'
    if (a:0 == 1)
        let cmd = cmd.' --languages='.a:1
    endif
    echo '开始生成索引库......'
    call system(cmd)
    echohl WarningMsg | echo '生成完成 '.cmd | echohl None
endfunction

function! s:FindInTaglist(name, fileKeyword)
    let tags = taglist('^'.a:name.'$')
    let tags = filter(tags, 'v:val["kind"] != "v"')
    if(a:fileKeyword != '')
        let tags = filter(tags, 'v:val["filename"] =~ ".*'.a:fileKeyword.'.*"')
    endif

    if (empty(tags))
        echohl WarningMsg | echo '没有找到相关的定义' | echohl None
        return
    endif
    if (len(tags) == 1)
        if(tags[0].filename != buffer_name('%'))
            execute 'tabnew '.tags[0].filename
        endif
        let cmd = escape(strpart(tags[0].cmd, 2, strlen(tags[0].cmd) - 4), '*[],')
        execute '/'.cmd
        return
    endif

    "打开quickfix
    let quickfix = []
    for i in tags
        let pattern = escape(strpart(i.cmd, 2, strlen(i.cmd) - 4), '*')
        call add(quickfix, {'pattern' : pattern, 'filename' : i.filename, 'text' : i.kind})
    endfor

    call setqflist(quickfix)
    tabnew
    "tabdo cclose
    copen
    execute 'resize '.(len(quickfix) < 5 ? 5 : 10)
    cfirst
endfunction

function! ShowSearchFile()
    let fileName = getline('.')
   " execute 'edit '.fileName
    execute ':nohls\n'
endfunction

function! s:SearchAllFileNames(...)
        if buffer_name('%') != ''
                tabnew
        endif

        let cmd = 'find ./ -type f |grep -v ".//.svn/"'
        if a:0 == 1
                let cmd = cmd.' | grep '.a:1
        endif

        setlocal modifiable
        execute 'delete '.line('$')
        execute '0 read !'.cmd
        goto 1
        setlocal nobuflisted
        setlocal buftype=nofile
        setlocal nomodifiable
        setlocal cursorline
        setlocal statusline=\ [%L]\ Files
        map <buffer> <CR> :execute 'edit '.getline('.')<CR>
        map <buffer> o :execute 'edit '.getline('.')<CR>
        map <buffer> t :execute 'tabnew '.getline('.')<CR>
endfunction

function! LeaveStatuslineColor()
    hi StatusLine term=reverse ctermfg=253 ctermbg=58 gui=bold,reverse
    hi User1 term=reverse cterm=bold ctermfg=14 ctermbg=22
    hi User2 term=reverse ctermfg=0 ctermbg=23
endfunction

function! Open_Keyword_File(type, str)
    let var_item = split(a:str, ":")
    let filename = var_item[0]
    let line = var_item[1]
    echo var_item
    if a:type == 1
        execute 'tabnew '.filename
    elseif a:type == 2
        execute 'edit '.filename
    else
    endif
    execute ':'.line
endfunction
" 搜索关键词
function! Search_Keyword()
    let word = expand("<cword>")
    execute 'Ag '.word
endfunction
" 搜索关键词,废弃
function! Search_Keyword_Old()
    let word = expand("<cword>")
    if buffer_name('%') != ''
        tabnew
    endif

    let ftype = &filetype
    echo ftype
    let cmd = 'ag --'.ftype.' "'.word.'" ./'
    if a:0 == 1
        let cmd = cmd.' | grep '.a:1
    endif
    echo cmd

    setlocal modifiable
    execute 'delete '.line('$')
    execute '0 read !'.cmd
    goto 1
    setlocal nobuflisted
    setlocal buftype=nofile
    setlocal nomodifiable
    setlocal cursorline
    setlocal statusline=\ [%L]\ Files
    map <buffer> <CR> :call Open_Keyword_File(2, getline('.'))<CR>
    map <buffer> o :call Open_Keyword_File(2, getline('.'))<CR>
    map <buffer> t :call Open_Keyword_File(1, getline('.'))<CR>
    "map <buffer> <CR> :execute 'edit '.getline('.')<CR>
    "map <buffer> o :execute 'edit '.getline('.')<CR>
    "map <buffer> t :execute 'tabnew '.getline('.')<CR>
endfunction

