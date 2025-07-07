vim.opt.number = true              -- 显示行号
vim.opt.ignorecase = true          -- 忽略大小写
vim.opt.smartcase = true           -- 智能大小写匹配
vim.opt.hlsearch = true            -- 高亮搜索
vim.opt.incsearch = true           -- 增量搜索
vim.opt.wrapscan = false           -- 不循环搜索
vim.opt.smartindent = true         -- 智能缩进
vim.opt.splitbelow = true          -- 水平分割窗口在下方


-- 键位映射
vim.keymap.set('i', 'jk', '<ESC>', {desc = '退出插入模式'})

