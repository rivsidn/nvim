-- 标题快捷键
vim.keymap.set('n', '<leader>1', 'I# ', {buffer = true, desc = '一级标题'})
vim.keymap.set('n', '<leader>2', 'I## ', {buffer = true, desc = '二级标题'})
vim.keymap.set('n', '<leader>3', 'I### ', {buffer = true, desc = '三级标题'})
vim.keymap.set('n', '<leader>4', 'I#### ', {buffer = true, desc = '四级标题'})
vim.keymap.set('n', '<leader>5', 'I##### ', {buffer = true, desc = '五级标题'})
vim.keymap.set('n', '<leader>6', 'I###### ', {buffer = true, desc = '六级标题'})
vim.keymap.set('i', '<leader>1', '# ', {buffer = true, desc = '一级标题'})
vim.keymap.set('i', '<leader>2', '## ', {buffer = true, desc = '二级标题'})
vim.keymap.set('i', '<leader>3', '### ', {buffer = true, desc = '三级标题'})
vim.keymap.set('i', '<leader>4', '#### ', {buffer = true, desc = '四级标题'})
vim.keymap.set('i', '<leader>5', '##### ', {buffer = true, desc = '五级标题'})
vim.keymap.set('i', '<leader>6', '###### ', {buffer = true, desc = '六级标题'})

-- 文本格式化快捷键
vim.keymap.set('i', '<leader>c', '```<CR>```<Esc>kA', {buffer = true, desc = '插入行内代码'})

-- 换行设置
vim.opt_local.textwidth = 80           -- 设置文本宽度为80字符
vim.opt_local.formatoptions:append("mm") -- 添加多字节字符支持

