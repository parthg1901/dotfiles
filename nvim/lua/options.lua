-- Neovim options (migrated from viml_conf/options.vim)

local opt = vim.opt
local g = vim.g
local fn = vim.fn

-- Change fillchars for folding, vertical split, end of buffer, and message separator
-- Note: foldopen/foldclose use nerdfont icons - set via vim.cmd for proper encoding
vim.o.fillchars = "fold: ,foldsep: ,vert:│,eob: ,msgsep:‾,diff:╱"
-- Set fold icons separately (these are nerdfont glyphs)
pcall(function()
  vim.opt.fillchars:append({ foldopen = "", foldclose = "" })
end)

-- Split window below/right when creating horizontal/vertical windows
opt.splitbelow = true
opt.splitright = true

-- Avoid the flickering when splitting window horizontal
opt.splitkeep = "screen"

-- Time in milliseconds to wait for a mapped sequence to complete
opt.timeoutlen = 500

-- For CursorHold events
opt.updatetime = 500

-- Clipboard settings, always use clipboard for all delete, yank, change, put
if fn.empty(fn["provider#clipboard#Executable"]()) == 0 then
  opt.clipboard:append("unnamedplus")
end

-- Disable creating swapfiles
opt.swapfile = false

-- Ignore certain files and folders when globing
opt.wildignore:append({
  "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe",
  "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/**",
  "*.jpg", "*.png", "*.jpeg", "*.bmp", "*.gif", "*.tiff", "*.svg", "*.ico",
  "*.pyc", "*.pkl",
  "*.DS_Store",
  "*.aux", "*.bbl", "*.blg", "*.brf", "*.fls", "*.fdb_latexmk", "*.synctex.gz", "*.xdv",
})

-- Ignore file and dir name cases in cmd-completion
opt.wildignorecase = true

-- Set up backup directory
local backupdir = fn.stdpath("data") .. "/backup//"
g.backupdir = backupdir
opt.backupdir = backupdir

-- Skip backup for patterns in option wildignore
opt.backupskip = vim.o.wildignore
opt.backup = true
opt.backupcopy = "yes"

-- General tab settings
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Set matching pairs of characters and highlight matching brackets
vim.cmd([[set matchpairs+=<:>,「:」,『:』,【:】,":",':',《:》]])

-- Show line number and relative line number
opt.number = true
opt.relativenumber = true

-- Ignore case in general, but become case-sensitive when uppercase is present
opt.ignorecase = true
opt.smartcase = true

-- File and script encoding settings
opt.fileencoding = "utf-8"
opt.fileencodings = { "ucs-bom", "utf-8", "cp936", "gb18030", "big5", "euc-jp", "euc-kr", "latin1" }

-- Break line at predefined characters
opt.linebreak = true

-- Character to show before the lines that have been soft-wrapped
opt.showbreak = "↪"

-- List all matches and complete till longest common string
opt.wildmode = "list:longest"

-- Minimum lines to keep above and below cursor when scrolling
opt.scrolloff = 3

-- Use mouse to select and resize windows, etc.
opt.mouse = "n"
opt.mousemodel = "popup"
opt.mousescroll = "ver:1,hor:0"

-- Disable showing current mode on command line since statusline plugins can show it
opt.showmode = false

-- Fileformats to use for new files
opt.fileformats = { "unix", "dos" }

-- Ask for confirmation when handling unsaved or read-only files
opt.confirm = true

-- Do not use visual and errorbells
opt.visualbell = true
opt.errorbells = false

-- The number of command and search history to keep
opt.history = 500

-- Use list mode and customized listchars
opt.list = true
opt.listchars = {
  tab = "▸ ",
  extends = "❯",
  precedes = "❮",
  nbsp = "␣",
}

-- Auto-write the file based on some condition
opt.autowrite = true

-- Show hostname, full path of file and last-mod time on the window title
opt.title = true
opt.titlestring = "%{v:lua.require('utils').get_titlestr()}"

-- Persistent undo even after you close a file and re-open it
opt.undofile = true

-- Do not show "match xx of xx" and other messages during auto-completion
opt.shortmess:append("c")

-- Do not show search match count on bottom right
opt.shortmess:append("S")

-- Disable showing intro message (:intro)
opt.shortmess:append("I")

opt.messagesopt = "hit-enter,history:500"

-- Completion behaviour
opt.completeopt:append("menuone")
opt.completeopt:remove("preview")

-- Maximum number of items to show in popup menu
opt.pumheight = 10

-- Pseudo transparency for completion menu
opt.pumblend = 5

-- Pseudo transparency for floating window
opt.winblend = 0
opt.winborder = "none"

-- Insert mode key word completion setting
opt.complete:append("kspell")
opt.complete:remove({ "w", "b", "u", "t" })

-- Spell languages
opt.spelllang = { "en", "cjk" }

-- Show 9 spell suggestions at most
opt.spellsuggest:append("9")

-- Align indent to next multiple value of shiftwidth
opt.shiftround = true

-- Virtual edit is useful for visual block edit
opt.virtualedit = "block"

-- Correctly break multi-byte characters such as CJK
opt.formatoptions:append("mM")

-- Tilde (~) is an operator, thus must be followed by motions like `e` or `w`
opt.tildeop = true

-- Text after this column number is not highlighted
opt.synmaxcol = 250
opt.startofline = false

-- External program to use for grep command
if fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Enable true color support
opt.termguicolors = true

-- Set up cursor color and shape in various mode
opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20"

-- Sign column
opt.signcolumn = "yes:1"

-- Remove certain character from file name pattern matching
opt.isfname:remove({ "=", "," })

-- Diff options
opt.diffopt = {
  "vertical",
  "filler",
  "closeoff",
  "context:3",
  "internal",
  "indent-heuristic",
  "algorithm:histogram",
  "linematch:60",
}

-- Do not wrap lines
opt.wrap = false
opt.ruler = false

opt.showcmdloc = "statusline"
