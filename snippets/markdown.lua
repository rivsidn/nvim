local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- cb 展开为代码块
  s("cb", {
    t("```"),
    i(1, "language"),  -- 第一个占位符，默认为 "language"
    t({"", ""}),       -- 换行
    i(2, "code"),      -- 第二个占位符，默认为 "code"
    t({"", "```"}),    -- 换行并闭合代码块
    i(0)               -- 最终光标位置
  }),
}
