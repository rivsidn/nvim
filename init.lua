vim.opt.number = true              -- 显示行号
vim.opt.cursorline = true          -- 显示当前行下划线
vim.opt.ignorecase = true          -- 忽略大小写
vim.opt.smartcase = true           -- 智能大小写匹配
vim.opt.hlsearch = true            -- 高亮搜索
vim.opt.incsearch = true           -- 增量搜索
vim.opt.wrapscan = false           -- 不循环搜索
vim.opt.smartindent = true         -- 智能缩进
vim.opt.splitbelow = true          -- 水平分割窗口在下方

vim.o.mouse = ""

-- 可用时默认使用系统剪贴板，省去每次手动输入 "+ 寄存器
local has_clipboard_provider =
  (vim.env.WAYLAND_DISPLAY and vim.fn.executable("wl-copy") == 1)
  or (vim.env.DISPLAY and (vim.fn.executable("xclip") == 1 or vim.fn.executable("xsel") == 1))
  or vim.fn.executable("pbcopy") == 1
  or vim.fn.executable("clip.exe") == 1
  or vim.fn.executable("win32yank.exe") == 1

if has_clipboard_provider then
  vim.opt.clipboard:append("unnamedplus")
end

-- 修改nvim配色
-- 如果此处报错，删除掉apt 安装的neovim
-- 执行snap install nvim 命令安装
vim.cmd.colorscheme('vim')
vim.o.termguicolors = false

-- 安装 lazy.nvim 插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载插件
require("lazy").setup("plugins")

-- 键位映射
vim.keymap.set('i', 'jk', '<ESC>', {desc = '退出插入模式'})
vim.keymap.set('t', 'jk', '<C-\\><C-n>', {desc = '退出terminal模式'})

-- 禁用 Ctrl+@ (Ctrl+Space 被终端转换为 Ctrl+@)
vim.keymap.set('i', '<C-@>', '<Nop>', {desc = '禁用Ctrl+@重复插入'})

-- 自动进入terminal 模式
-- vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
--   callback = function()
--     if vim.bo.buftype == "terminal" then
--       vim.cmd("startinsert")
--     end
--   end,
-- })
