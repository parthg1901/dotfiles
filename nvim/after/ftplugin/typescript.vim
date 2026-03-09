" TypeScript filetype configuration
" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

" TypeScript specific settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Enable syntax highlighting for TypeScript
set syntax=typescript

" Set up for modern TypeScript development
setlocal commentstring=//\ %s

" Auto-format on save (if formatter is available)
if executable('prettier')
  setlocal formatprg=prettier\ --stdin-filepath\ %
endif

" Set up for TSX if file has .tsx extension
if expand('%:e') == 'tsx'
  setlocal filetype=typescriptreact
endif

" Key mappings for TypeScript development
nnoremap <buffer> <leader>rf :call FormatTypeScript()<CR>
nnoremap <buffer> <leader>rt :call RunTests()<CR>
nnoremap <buffer> <leader>rd :call OpenTypeScriptDocs()<CR>
nnoremap <buffer> <leader>rb :call BuildProject()<CR>

" Function to format TypeScript files
function! FormatTypeScript()
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

" Function to open TypeScript documentation
function! OpenTypeScriptDocs()
  let word = expand('<cword>')
  if word != ''
    execute '!open https://www.typescriptlang.org/docs/search?search=' . word
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