-- Claude Code 工作布局模块

local M = {}

-- 配置选项
M.config = {
  question_file = vim.fn.expand('PROMPT.md'),
  window_width_percent = 50,  -- 左侧编辑器窗口宽度百分比
  auto_focus_editor = true,   -- 自动聚焦到编辑器窗口
}

-- 创建 Claude 工作布局
function M.setup_layout()
  -- 清理现有窗口，只保留当前窗口
  vim.cmd('only')
  
  -- 优先使用命令行传入的文件，否则使用默认配置
  local file_to_open = vim.fn.argv(0)  -- 获取第一个命令行参数
  if file_to_open == '' or file_to_open == nil then
    -- 没有文件参数，使用默认问题文件
    file_to_open = M.config.question_file
  end
  
  -- 打开文件
  vim.cmd('e ' .. file_to_open)
  
  -- 右侧打开终端
  vim.cmd('rightbelow vsplit')
  vim.cmd('terminal claude')
  
  -- 计算左侧窗口的列数（基于总宽度的百分比）
  local total_width = vim.o.columns
  local left_width = math.floor(total_width * M.config.window_width_percent / 100)
  
  -- 回到左侧窗口并设置绝对宽度
  vim.cmd('wincmd h')
  vim.cmd('vertical resize ' .. left_width)
  
  -- 根据配置决定最终焦点位置
  if not M.config.auto_focus_editor then
    vim.cmd('wincmd l')  -- 回到右侧终端
  end
end

-- 初始化函数
function M.setup(opts)
  -- 合并用户配置
  if opts then
    M.config = vim.tbl_extend('force', M.config, opts)
  end
  
  -- 创建用户命令
  vim.api.nvim_create_user_command('ClaudeLayout', M.setup_layout, {})
end

return M
