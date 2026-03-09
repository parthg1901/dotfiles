local fn = vim.fn

local git_status_cache = {}

local on_exit_fetch = function(result)
  if result.code == 0 then
    git_status_cache.fetch_success = true
  end
end

local function handle_numeric_result(cache_key)
  return function(result)
    if result.code == 0 then
      git_status_cache[cache_key] = tonumber(result.stdout:match("(%d+)")) or 0
    end
  end
end

local async_cmd = function(cmd_str, on_exit)
  local cmd = vim.tbl_filter(function(element)
    return element ~= ""
  end, vim.split(cmd_str, " "))

  vim.system(cmd, { text = true }, on_exit)
end

local async_git_status_update = function()
  async_cmd("git fetch origin", on_exit_fetch)
  if not git_status_cache.fetch_success then
    return
  end

  local behind_cmd_str = "git rev-list --count HEAD..@{upstream}"
  async_cmd(behind_cmd_str, handle_numeric_result("behind_count"))

  local ahead_cmd_str = "git rev-list --count @{upstream}..HEAD"
  async_cmd(ahead_cmd_str, handle_numeric_result("ahead_count"))
end

local function get_git_ahead_behind_info()
  async_git_status_update()

  local status = git_status_cache
  if not status then
    return ""
  end

  local msg = ""

  if type(status.ahead_count) == "number" and status.ahead_count > 0 then
    msg = msg .. string.format(" %d ", status.ahead_count)
  end

  if type(status.behind_count) == "number" and status.behind_count > 0 then
    msg = msg .. string.format(" %d ", status.behind_count)
  end

  return msg
end

local function spell()
  if vim.o.spell then
    return "[SPELL]"
  end
  return ""
end

local function ime_state()
  if vim.g.is_mac then
    local layout = fn.libcall(vim.g.XkbSwitchLib, "Xkb_Switch_getXkbLayout", "")
    local res = fn.match(layout, [[\v(Squirrel\.Rime|SCIM.ITABC)]])
    if res ~= -1 then
      return "[CN]"
    end
  end
  return ""
end

local function trailing_space()
  if not vim.o.modifiable then
    return ""
  end

  for i = 1, fn.line("$") do
    local linetext = fn.getline(i)
    local idx = fn.match(linetext, [[\v\s+$]])
    if idx ~= -1 then
      return string.format("[%d]trailing", i)
    end
  end

  return ""
end

local function mixed_indent()
  if not vim.o.modifiable then
    return ""
  end

  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = fn.search(space_pat, "nwc")
  local tab_indent = fn.search(tab_pat, "nwc")
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = fn.search([[\v^(\t+ | +\t)]], "nwc")
    mixed = mixed_same_line > 0
  end
  if not mixed then
    return ""
  end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return "MI:" .. mixed_same_line
  end
  local space_indent_cnt = fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return "MI:" .. tab_indent
  else
    return "MI:" .. space_indent
  end
end

local diff = function()
  local git_status = vim.b.gitsigns_status_dict
  if git_status == nil then
    return
  end

  return { added = git_status.added, modified = git_status.changed, removed = git_status.removed }
end

local virtual_env = function()
  if vim.bo.filetype ~= "python" then
    return ""
  end

  local conda_env = os.getenv("CONDA_DEFAULT_ENV")
  local venv_path = os.getenv("VIRTUAL_ENV")

  if venv_path == nil then
    if conda_env == nil then
      return ""
    else
      return string.format("  %s (conda)", conda_env)
    end
  else
    local venv_name = vim.fn.fnamemodify(venv_path, ":t")
    return string.format("  %s (venv)", venv_name)
  end
end

local get_active_lsp = function()
  local buf_ft = vim.api.nvim_get_option_value("filetype", {})
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if next(clients) == nil then
    return ""
  end

  for _, client in ipairs(clients) do
    ---@diagnostic disable-next-line: undefined-field
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return ""
end

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "dashboard" },
    },
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
    },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:sub(1, 3)
        end,
      },
    },
    lualine_b = {
      {
        "branch",
        icon = "",
        fmt = function(name, _)
          return string.sub(name, 1, 20)
        end,
      },
      {
        get_git_ahead_behind_info,
        color = { fg = "#E0C479" },
      },
      {
        "diff",
        source = diff,
        symbols = { added = " ", modified = " ", removed = " " },
      },
    },
    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = {
          readonly = " ",
          modified = " ",
        },
      },
      {
        virtual_env,
        color = { fg = "#F1CA81" },
      },
      {
        spell,
        color = { fg = "#a7c080" },
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
      },
      {
        trailing_space,
        color = "WarningMsg",
      },
      {
        mixed_indent,
        color = "WarningMsg",
      },
      {
        get_active_lsp,
        icon = " ",
      },
    },
    lualine_y = {
      "filetype",
      {
        ime_state,
        color = { fg = "black", bg = "#f46868" },
      },
    },
    lualine_z = {
      { "location", padding = { left = 1, right = 0 } },
      { "progress", padding = { left = 1, right = 1 } },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", "fugitive", "nvim-tree", "lazy" },
}
