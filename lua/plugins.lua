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

-- Markdown 语法高亮和功能增强
local vim_markdown = {
  'preservim/vim-markdown',
  ft = 'markdown',
  config = function()
    -- 禁用折叠功能
    vim.g.vim_markdown_folding_disabled = 1
  end
}

-- Markdown 预览插件
local markdown_preview = {
  'iamcco/markdown-preview.nvim',
  build = 'cd app && npm install',
  ft = 'markdown',
  keys = {
    { '<F5>', '<cmd>MarkdownPreviewToggle<cr>', desc = '切换Markdown预览' }
  },
  config = function()
    -- 设置浏览器
    vim.g.mkdp_browser = ''
    -- 预览页面标题
    vim.g.mkdp_page_title = '${name}'
    -- 只在markdown文件中启用
    vim.g.mkdp_filetypes = {'markdown'}
  end
}

-- 表格模式插件
local table_mode = {
  'dhruvasagar/vim-table-mode',
  ft = 'markdown',
  config = function()
    -- 设置表格分隔符
    vim.g.table_mode_corner = '|'
    -- 启用表格模式快捷键
    vim.g.table_mode_map_prefix = '<Leader>t'
  end
}

-- 自动tags和cscope管理
local gutentags = {
  'ludovicchabant/vim-gutentags',
  config = function()
    -- 设置tags缓存目录
    vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/gutentags")

    -- 项目根目录标记
    vim.g.gutentags_project_root = {'.root', '.svn', '.git', '.hg', '.project'}

    -- 启用模块（仅tags，Neovim不支持cscope）
    vim.g.gutentags_modules = {'ctags'}

    -- tags文件名
    vim.g.gutentags_ctags_tagfile = 'tags'

    -- 排除不需要生成tags的文件和目录
    vim.g.gutentags_ctags_exclude = {
      '*.git', '*.svg', '*.hg',
      '*/tests/*',
      'build',
      'dist',
      'sites/*/files/*',
      'bin',
      'node_modules',
      'bower_components',
      'cache',
      'compiled',
      'docs',
      'example',
      'bundle',
      'vendor',
      '*.md',
      '*-lock.json',
      '*.lock',
      '*bundle*.js',
      '*build*.js',
      '.*rc*',
      '*.json',
      '*.min.*',
      '*.map',
      '*.bak',
      '*.zip',
      '*.pyc',
      '*.class',
      '*.o',
      '*.o.*',
      '*.a',
      '*.s',
      '*.ko',
      '*.so',
      '*.so.dbg',
      '*.mod.c',
      '*.i',
      '*.lst',
      '*.symtypes',
      '*.order',
      '*.elf',
      '*.bin',
      '*.gcno',
      '*.ll',
      '*.dwo',
      '*.su',
      'modules.builtin',
      'Module.symvers',
      '*.sln',
      '*.tmp',
      '*.cache',
      '*.pdb',
      'tags*',
      'TAGS',
      'cscope.*',
      'ncscope.*',
      'GPATH',
      'GRTAGS',
      'GSYMS',
      'GTAGS',
      'ID',
      '*.orig',
      '*.css',
      '*.less',
      '*.scss',
      '*.exe', '*.dll',
      '*.swp', '*.swo',
      '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      '*.lzma', '*.lz4', '*.lzo', '*.bz2',
      '*.patch',
      '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      '*.kdev4',
    }

    -- 在状态栏文件名后添加gutentags状态
    local current_statusline = vim.o.statusline
    if current_statusline == "" then
      -- 如果没有自定义状态栏，使用默认格式并在文件名后添加[ctags]状态
      vim.opt.statusline = "%<%f%{gutentags#statusline() != '' ? '[ctags]' : ''} %h%m%r%=%-14.(%l,%c%V%) %P"
    else
      -- 如果已有自定义状态栏，智能插入[ctags]到文件名后
      local modified_statusline = current_statusline
      -- 查找文件名模式并在其后插入gutentags状态
      if string.find(current_statusline, "%%f") then
        modified_statusline = string.gsub(current_statusline, "(%%<?f)", "%1%%{gutentags#statusline() != '' ? '[ctags]' : ''}")
      elseif string.find(current_statusline, "%%t") then
        modified_statusline = string.gsub(current_statusline, "(%%t)", "%1%%{gutentags#statusline() != '' ? '[ctags]' : ''}")
      else
        -- 如果找不到文件名模式，追加到末尾
        modified_statusline = current_statusline .. "%{gutentags#statusline() != '' ? ' [ctags]' : ''}"
      end
      vim.opt.statusline = modified_statusline
    end
  end
}

return {
  tagbar,
  nerdtree,
  auto_pairs,
  drawit,
  vim_markdown,
  markdown_preview,
  table_mode,
  gutentags
}
