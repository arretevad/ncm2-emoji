if get(s:, 'loaded', 0)
    finish
endif
let s:loaded = 1

"let g:ncm2_bufword#proc = yarp#py3({
    "\ 'module': 'ncm2_emoj',
    "\ 'on_load': { -> ncm2#set_ready(g:ncm2_emoji#emoji_source)}
    "\ })

let g:ncm2_emoji#token = ''
let g:ncm2_emoji#proc = yarp#py3('ncm2_emoji')
let g:ncm2_emoji#proc.on_load = 'ncm2_emoji#on_load'

func! ncm2_emoji#init()
    call ncm2#register_source(g:ncm2_emoji#emoji_source)
endfunc

"func! ncm2_emoji#on_load()
    "let g:ncm2_emoji#emoji_source_source.ready  = 1
"endfunc

func! ncm2_emoji#on_warmup(ctx)
    call g:ncm2_emoji#proc.jobstart()
endfunc


let g:ncm2_emoji#emoji_source = extend(
      \ get(g:, 'ncm2_emoji#emoji_source', {}), {
            \ 'name': 'emoji',
            \ 'scope': ['gitcommit', 'markdown', 'magit'],
            \ 'priority': 8,
            \ 'mark': 'emoji',
            \ 'on_complete': 'ncm2_emoji#on_complete_emoji',
            \ 'word_pattern': ':[\w+-]*:?',
            \ 'complete_length': 2,
            \ }, 'keep')


func! ncm2_emoji#on_complete_emoji(ctx)
    call ncm2#complete(a:ctx, a:ctx.startccol, g:ncm2_emoji#emoji_table#matches)
endfunc


