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
    vim.g.tagbar_autofocus = 0
    vim.g.tagbar_sort = 0
    -- 在左侧显示
    vim.g.tagbar_position = 'topleft vertical'
  end
}

-- NvimTree 文件浏览器
local nvimtree = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- 文件图标
  },
  keys = {
    { '<F9>', '<cmd>NvimTreeToggle<cr>', desc = '切换文件浏览器' }
  },
  config = function()
    -- 必须先禁用netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-tree').setup({
      view = {
        side = 'right',
        width = 30,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = false,        -- 禁用git图标
            file = false,       -- 禁用文件图标
            folder = false,     -- 禁用文件夹图标
            folder_arrow = true, -- 保留文件夹箭头
          },
          glyphs = {
            folder = {
              arrow_closed = "+",  -- 使用+号表示可展开
              arrow_open = "-",    -- 使用-号表示可收起
            },
          },
        },
        indent_markers = {
          enable = false,       -- 禁用缩进标记
        },
      },
    })
  end
}

-- 自动配对括号
local auto_pairs = {
  'jiangmiao/auto-pairs',
  config = function()
    -- Alt+n 跳过右括号/引号
    vim.g.AutoPairsShortcutJump = '<M-n>'

    -- 修复跳转功能，支持反引号等所有配对符号
    vim.cmd([[
      function! AutoPairsJump()
        " 获取当前行和位置信息
        let current_line = getline('.')
        let col = col('.') - 1
        let char_under = current_line[col]
        let char_next = current_line[col + 1]

        " 动态获取所有配对符号
        let pairs = get(b:, 'AutoPairs', g:AutoPairs)

        " 如果光标下是闭合符号，直接跳过
        for [open, close] in items(pairs)
          if char_under == close && close != ''
            normal! l
            return
          endif
        endfor

        " 如果光标后面是闭合符号，跳过
        for [open, close] in items(pairs)
          if char_next == close && close != ''
            normal! l
            return
          endif
        endfor

        " 否则搜索下一个闭合符号
        let close_chars = []
        for [open, close] in items(pairs)
          if close != '' && close != open
            let escaped = escape(close, '[]\\^$.*~')
            call add(close_chars, escaped)
          endif
        endfor

        if len(close_chars) > 0
          let pattern = '[' . join(close_chars, '') . ']'
          call search(pattern, 'W')
        endif
      endfunction
    ]])
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

-- Cscope集成
local cscope_maps = {
  'dhananjaylatkar/cscope_maps.nvim',
  dependencies = {
    "folke/trouble.nvim", -- 可选，用于显示搜索结果
    "nvim-telescope/telescope.nvim", -- 可选，用于更好的搜索体验
  },
  config = function()
    require("cscope_maps").setup({
      disable_maps = false,
      skip_input_prompt = false,
      cscope = {
        db_file = "./cscope.out",
        exec = "gtags-cscope",
        picker = "quickfix", -- 可选: "quickfix", "telescope", "trouble"
        skip_input_prompt = false,
        db_build_cmd = { scripts = "cscope -Rbkq" },
        statusline_indicator = nil,
      }
    })
  end
}

-- Claude Code集成
local claudecode = {
  'coder/claudecode.nvim',
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = {
        -- 配置snacks使用终端颜色
        styles = {
          notification = {
            wo = {
              wrap = true,
              winhighlight = "Normal:Normal,NormalNC:NormalNC,WinBar:WinBar,WinBarNC:WinBarNC",
            },
            bo = { filetype = "snacks_notif" },
            -- 使用终端背景
            backdrop = false,
          },
          -- 所有浮动窗口使用透明背景
          float = {
            backdrop = false,
            wo = {
              winhighlight = "Normal:Normal,NormalNC:NormalNC,WinBar:WinBar,WinBarNC:WinBarNC",
            },
          },
          -- Dashboard 透明背景
          dashboard = {
            backdrop = false,
            wo = {
              winhighlight = "Normal:Normal,NormalNC:NormalNC,WinBar:WinBar,WinBarNC:WinBarNC",
            },
          },
        },
      },
      config = function(_, opts)
        require("snacks").setup(opts)
        -- 覆盖默认高亮组，使其使用透明背景
        vim.api.nvim_set_hl(0, "SnacksNormal", { link = "Normal" })
        vim.api.nvim_set_hl(0, "SnacksNormalNC", { link = "NormalNC" })
        vim.api.nvim_set_hl(0, "SnacksDashboardNormal", { link = "Normal" })
        vim.api.nvim_set_hl(0, "SnacksBackdrop", { bg = "NONE" })
      end
    }
  },
  opts = {
    -- 自动启动Claude Code服务
    auto_start = true,

    -- 终端配置
    terminal = {
      split_side = "right",
      split_width_percentage = 0.30,
      provider = "auto",
      auto_close = true,
    },

    -- Diff集成配置 - 关键设置
    diff_opts = {
      auto_close_on_accept = true,    -- 接受后自动关闭diff
      vertical_split = true,          -- 垂直分割显示
      open_in_current_tab = true,     -- 在当前标签页打开
    },

    -- 选择跟踪
    track_selection = true,
    visual_demotion_delay_ms = 50,

    -- 日志级别
    log_level = "info",
  },
  config = function(_, opts)
    require("claudecode").setup(opts)

    -- 设置Neovim自动重载外部修改的文件
    vim.opt.autoread = true          -- 启用自动读取
    vim.opt.updatetime = 100         -- 快速检测文件变化

    -- 设置自动命令来检测文件变化
    vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
      pattern = "*",
      callback = function()
        if vim.fn.mode() ~= 'c' then
          vim.cmd('checktime')
        end
      end,
    })

    -- Claude Code diff接受后强制重载所有缓冲区
    vim.api.nvim_create_autocmd("User", {
      pattern = "ClaudeCodeDiffAccepted",
      callback = function()
        -- 延迟执行以确保文件已写入磁盘
        vim.defer_fn(function()
          vim.cmd('checktime')  -- 检查所有缓冲区
          vim.cmd('bufdo! edit') -- 强制重载所有缓冲区
        end, 100)
      end,
    })
  end,
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}

local luaSnip = {
	"L3MON4D3/LuaSnip",
	version = "v2.4.0",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets", -- 提供VSCode风格的代码片段
	},
	config = function()
		local ls = require("luasnip")

		-- 键位映射配置
		vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true, desc = "展开代码片段"})
		vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump(1) end, {silent = true, desc = "跳转到下一个占位符"})
		vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true, desc = "跳转到上一个占位符"})
		vim.keymap.set({"i", "s"}, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, {silent = true, desc = "切换选择项"})

		-- 加载friendly-snippets提供的VSCode风格代码片段
		require("luasnip.loaders.from_vscode").lazy_load()

		-- 加载自定义代码片段（如果存在）
		require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
	end
}

return {
  tagbar,
  nvimtree,
  auto_pairs,
  drawit,
  vim_markdown,
  markdown_preview,
  table_mode,
  gutentags,
--  cscope_maps,
  claudecode,
  luaSnip
}
