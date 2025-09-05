-- C 语言文件特定配置

-- 配置 tags 跳转行为
vim.opt_local.tags = "./tags;,tags"  -- 向上查找 tags 文件

-- 自定义 Ctrl+] 行为：优先跳转到函数定义而不是声明
vim.keymap.set('n', '<C-]>', function()
  local word = vim.fn.expand('<cword>')
  local taglist = vim.fn.taglist('^' .. vim.fn.escape(word, '.*$^~[]') .. '$')
  
  if #taglist == 0 then
    -- 没有匹配的tag
    vim.api.nvim_echo({{'E426: tag not found: ' .. word, 'ErrorMsg'}}, true, {})
    return
  elseif #taglist == 1 then
    -- 只有一个匹配，直接跳转
    vim.cmd('tag ' .. word)
    return
  end
  
  -- 多个匹配时，查找函数定义
  local func_index = nil
  local non_proto_index = nil
  
  for i, tag in ipairs(taglist) do
    -- 优先查找函数定义 (kind = 'f')
    if tag.kind == 'f' then
      func_index = i
      break
    elseif not non_proto_index and tag.kind ~= 'p' and tag.kind ~= 'x' then
      -- 记录第一个非声明的tag（如宏定义'd'、typedef 't'等）
      non_proto_index = i
    end
  end
  
  -- 优先使用函数定义，其次使用非声明定义
  local target_index = func_index or non_proto_index
  
  if target_index then
    -- 跳转到指定的tag条目
    vim.cmd(target_index .. 'tag ' .. word)
  else
    -- 都是声明，显示选择列表让用户选择
    vim.cmd('tselect ' .. word)
  end
end, { buffer = true, desc = 'C文件：智能跳转到定义' })

-- 添加 g] 的说明
vim.keymap.set('n', 'g]', 'g]', { buffer = true, desc = 'C文件：显示所有tag匹配' })
