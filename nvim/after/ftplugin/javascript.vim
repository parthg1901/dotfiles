" JavaScript filetype configuration
" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

" JavaScript/TypeScript specific settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Enable syntax highlighting for modern JavaScript
set syntax=javascript

" Set up for modern JavaScript development
setlocal commentstring=//\ %s

" Auto-format on save (if formatter is available)
if executable('prettier')
  setlocal formatprg=prettier\ --stdin-filepath\ %
endif

" Set up for JSX/TSX if file has .jsx or .tsx extension
if expand('%:e') =~ 'jsx\|tsx'
  setlocal filetype=javascriptreact
endif

" Key mappings for JavaScript development
nnoremap <buffer> <leader>rf :call FormatJavaScript()<CR>
nnoremap <buffer> <leader>rt :call RunTests()<CR>
nnoremap <buffer> <leader>rd :call OpenDocs()<CR>

" Function to format JavaScript/TypeScript files
function! FormatJavaScript()
  if executable('prettier')
    silent! %!prettier --stdin-filepath %
    echo "Formatted with Prettier"
  elseif executable('eslint')
    silent! %!eslint --fix --stdin --stdin-filename %
    echo "Formatted with ESLint"
  else
    echo "No formatter available"
  endif
endfunction

" Function to run tests
function! RunTests()
  if filereadable('package.json')
    if executable('npm')
      execute '!npm test'
    elseif executable('yarn')
      execute '!yarn test'
    endif
  else
    echo "No package.json found"
  endif
endfunction

" Function to open documentation
function! OpenDocs()
  let word = expand('<cword>')
  if word != ''
    execute '!open https://developer.mozilla.org/en-US/search?q=' . word
  endif
endfunction
