" Set colorcolumn to the current textwidth or fallback to the specified column.
function! ColorColumnAtTextWidth(column)
  if &textwidth > 0
    execute ':set cc=' . &textwidth
  else
    execute ':set cc=' . a:column
  endif
endfunction

" Set colorcolumn to the current textwidth or fallback to 80
autocmd BufWinEnter * call ColorColumnAtTextWidth(80)

" Quit help easily
function! QuitWithQ()
  if &buftype == 'help'
    nnoremap <buffer> <silent> q :q<cr>
  endif
endfunction
autocmd FileType help exe QuitWithQ()

" Paste javascript in as coffee (run `npm install -g js2coffee` first)
function! PasteAsCoffee()
  :read !pbpaste | js2coffee
endfunction
:command! PasteAsCoffee :call PasteAsCoffee()
