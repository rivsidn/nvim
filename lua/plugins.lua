-- 插件配置
return {
  -- Tagbar 插件，用于显示代码大纲
  {
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
  },

  -- NERDTree 文件浏览器
  {
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
}
