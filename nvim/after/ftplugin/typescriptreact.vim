" TypeScript React filetype configuration
" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

" TSX specific settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Enable syntax highlighting for TSX
set syntax=typescriptreact

" Set up for modern React development with TypeScript
setlocal commentstring=//\ %s

" Auto-format on save (if formatter is available)
if executable('prettier')
  setlocal formatprg=prettier\ --stdin-filepath\ %
endif

" Key mappings for React TypeScript development
nnoremap <buffer> <leader>rf :call FormatTSX()<CR>
nnoremap <buffer> <leader>rt :call RunTests()<CR>
nnoremap <buffer> <leader>rd :call OpenReactDocs()<CR>
nnoremap <buffer> <leader>rs :call StartDevServer()<CR>
nnoremap <buffer> <leader>rb :call BuildProject()<CR>

" Function to format TSX files
function! FormatTSX()
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

" Function to build project
function! BuildProject()
  if filereadable('package.json')
    if executable('npm')
      execute '!npm run build'
    elseif executable('yarn')
      execute '!yarn build'
    endif
  else
    echo "No package.json found"
  endif
endfunction

" Enable inlay hints for TypeScript
if has('nvim-0.10')
  setlocal inlayhint
endif 