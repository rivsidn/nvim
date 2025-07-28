-- 换行设置
vim.opt_local.textwidth = 80           -- 设置文本宽度为80字符
vim.opt_local.formatoptions:append("mm") -- 添加多字节字符支持

-- 快捷键映射
vim.keymap.set('i', '<leader>1', '# ', { buffer = true, desc = 'Insert h1 heading' })
vim.keymap.set('i', '<leader>2', '## ', { buffer = true, desc = 'Insert h2 heading' })
vim.keymap.set('i', '<leader>3', '### ', { buffer = true, desc = 'Insert h3 heading' })
vim.keymap.set('i', '<leader>4', '#### ', { buffer = true, desc = 'Insert h4 heading' })
vim.keymap.set('i', '<leader>5', '##### ', { buffer = true, desc = 'Insert h5 heading' })

vim.keymap.set('i', '<leader>c', '```<cr>```<Esc>kA', { buffer = true, desc = 'Insert code block' })


