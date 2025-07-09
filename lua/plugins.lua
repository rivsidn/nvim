-- 插件配置

-- Tagbar 插件，用于显示代码大纲
local tagbar = {
  'preservim/tagbar',
  keys = {
    { '<F2>', '<cmd>TagbarToggle<cr>', desc = '切换标签栏' },
    { '<F4>', '<cmd>TagbarForceUpdate<cr>', desc = '强制更新标签栏' }
  },
  config = function()
    -- Tagbar 配置
    vim.g.tagbar_width = 30
    vim.g.tagbar_autofocus = 1
    vim.g.tagbar_sort = 0
    -- 在左侧显示
    vim.g.tagbar_position = 'topleft vertical'
  end
}

-- NERDTree 文件浏览器
local nerdtree = {
  'preservim/nerdtree',
  keys = {
    { '<F9>', '<cmd>NERDTreeToggle<cr>', desc = '切换文件浏览器' }
  },
  config = function()
    -- NERDTree 配置
    vim.g.NERDTreeWinPos = 'right'
    vim.g.NERDTreeShowBookmarks = 1
  end
}

-- 自动配对括号
local auto_pairs = {
  'jiangmiao/auto-pairs',
  config = function()
    -- Alt+n 跳过右括号/引号
    vim.g.AutoPairsShortcutJump = '<M-n>'
  end
}

-- 文本绘图工具
local drawit = {
  'vim-scripts/DrawIt'
}

return {
  tagbar,
  nerdtree,
  auto_pairs,
  drawit
}
