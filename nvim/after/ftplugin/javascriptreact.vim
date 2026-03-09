" JavaScript React filetype configuration
" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

" JSX specific settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Enable syntax highlighting for JSX
set syntax=javascriptreact

" Set up for modern React development
setlocal commentstring=//\ %s

" Auto-format on save (if formatter is available)
if executable('prettier')
  setlocal formatprg=prettier\ --stdin-filepath\ %
endif

" Key mappings for React development
nnoremap <buffer> <leader>rf :call FormatJSX()<CR>
nnoremap <buffer> <leader>rt :call RunTests()<CR>
nnoremap <buffer> <leader>rd :call OpenReactDocs()<CR>
nnoremap <buffer> <leader>rs :call StartDevServer()<CR>

" Function to format JSX files
function! FormatJSX()
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

" Function to open React documentation
function! OpenReactDocs()
  let word = expand('<cword>')
  if word != ''
    execute '!open https://react.dev/reference/react/' . word
  endif
endfunction

" Function to start development server
function! StartDevServer()
  if filereadable('package.json')
    if executable('npm')
      execute '!npm run dev'
    elseif executable('yarn')
      execute '!yarn dev'
    endif
  else
    echo "No package.json found"
  endif
endfunction 