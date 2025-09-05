-- C 语言文件特定配置

-- 配置 tags 跳转行为
vim.opt_local.tags = "./tags;,tags"  -- 向上查找 tags 文件

-- 按 vim 的优先级重新排序 taglist
local function reorder_tags_by_vim_priority(taglist)
  local reordered = {}
  local vim_to_taglist_map = {}
  
  -- 第一轮：添加函数定义 (kind='f')
  for i, tag in ipairs(taglist) do
    if tag.kind == 'f' then
      table.insert(reordered, tag)
      vim_to_taglist_map[#reordered] = i  -- 记录映射关系
    end
  end
  
  -- 第二轮：添加非声明类型（如宏定义'd'、typedef 't'等）
  for i, tag in ipairs(taglist) do
    if tag.kind ~= 'f' and tag.kind ~= 'p' and tag.kind ~= 'x' then
      table.insert(reordered, tag)
      vim_to_taglist_map[#reordered] = i
    end
  end
  
  -- 第三轮：添加声明类型
  for i, tag in ipairs(taglist) do
    if tag.kind == 'p' or tag.kind == 'x' then
      table.insert(reordered, tag)
      vim_to_taglist_map[#reordered] = i
    end
  end
  
  return reordered, vim_to_taglist_map
end

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
  
  -- 重新排序以匹配 vim 的优先级
  local reordered_tags, vim_to_taglist_map = reorder_tags_by_vim_priority(taglist)
  
  -- 检查第一个是否是函数定义
  if #reordered_tags > 0 and reordered_tags[1].kind == 'f' then
    -- 使用vim的数字tag命令跳转到第1个（函数定义）
    vim.cmd('1tag ' .. word)
  elseif #reordered_tags > 0 then
    -- 第一个不是函数定义，但有其他非声明的定义，跳转到第1个
    vim.cmd('1tag ' .. word)
  else
    -- 都是声明，显示选择列表让用户选择
    vim.cmd('tselect ' .. word)
  end
end, { buffer = true, desc = 'C文件：智能跳转到定义' })

-- 添加 g] 的说明
vim.keymap.set('n', 'g]', 'g]', { buffer = true, desc = 'C文件：显示所有tag匹配' })
