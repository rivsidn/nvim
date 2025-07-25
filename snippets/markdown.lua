local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- cb 展开为代码块
  s("cb", {
    t("```"),
    i(1, "language"),  -- 第一个占位符，默认为 "language"
    t({"", "```"}),    -- 换行并闭合代码块
    i(0)               -- 最终光标位置
  }),

  -- 标题片段
  s("1", {
    t("# "),
    i(1, "标题"),
    i(0)
  }),

  s("2", {
    t("## "),
    i(1, "标题"),
    i(0)
  }),

  s("3", {
    t("### "),
    i(1, "标题"),
    i(0)
  }),

  s("4", {
    t("#### "),
    i(1, "标题"),
    i(0)
  }),

  s("5", {
    t("##### "),
    i(1, "标题"),
    i(0)
  }),

  s("6", {
    t("###### "),
    i(1, "标题"),
    i(0)
  }),
}
