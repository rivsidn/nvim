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

-- 创建光标下文件的函数（专门为Markdown文件优化）
local function create_markdown_file_under_cursor()
  -- 获取光标下的文件名 (使用 <cfile> 扩展)
  local filename = vim.fn.expand('<cfile>')
  
  if filename == '' then
    vim.notify('没有找到文件名', vim.log.levels.WARN)
    return
  end
  
  -- 获取文件的完整路径（相对于当前文件所在目录）
  local current_dir = vim.fn.expand('%:p:h')
  local filepath = current_dir .. '/' .. filename
  
  -- 创建文件所在的目录
  local dir = vim.fn.fnamemodify(filepath, ':h')
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
    vim.notify('创建目录: ' .. dir, vim.log.levels.INFO)
  end
  
  -- 检查文件是否已存在
  if vim.fn.filereadable(filepath) == 1 then
    vim.notify('文件已存在，直接打开: ' .. filepath, vim.log.levels.INFO)
  else
    vim.notify('创建新文件: ' .. filepath, vim.log.levels.INFO)
  end
  
  -- 打开文件（如果不存在会自动创建）
  vim.cmd('edit ' .. vim.fn.fnameescape(filepath))
end

-- 设置快捷键 <leader>e 创建并打开光标下的文件（仅在Markdown文件中）
vim.keymap.set('n', '<leader>e', create_markdown_file_under_cursor, { buffer = true, desc = '创建并打开光标下的文件' })


