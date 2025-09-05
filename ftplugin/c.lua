-- C 语言文件特定配置

-- 配置 tags 跳转行为
vim.opt_local.tags = "./tags;,tags"  -- 向上查找 tags 文件

-- 自定义 Ctrl+] 行为：优先跳转到函数定义而不是声明
vim.keymap.set('n', '<C-]>', function()
  local word = vim.fn.expand('<cword>')
  local taglist = vim.fn.taglist('^' .. vim.fn.escape(word, '.*$^~[]') .. '$')
  
  if #taglist <= 1 then
    -- 0个或1个匹配，使用默认跳转
    vim.cmd('tag ' .. word)
  else
    -- 多个匹配时，查找函数定义的索引
    local func_index = nil
    
    for i, tag in ipairs(taglist) do
      -- 找到第一个函数定义 (kind = 'f')
      if tag.kind == 'f' and not func_index then
        func_index = i
        break
      end
    end
    
    if func_index then
      -- 如果找到函数定义，使用数字跳转到特定的tag（保持tag栈）
      vim.cmd(func_index .. 'tag ' .. word)
    else
      -- 没找到函数定义，显示选择列表
      vim.cmd('tselect ' .. word)
    end
  end
end, { buffer = true, desc = 'C文件：智能跳转到定义' })

-- 添加 g] 的说明
vim.keymap.set('n', 'g]', 'g]', { buffer = true, desc = 'C文件：显示所有tag匹配' })