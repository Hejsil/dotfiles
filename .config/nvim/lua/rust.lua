local rust = {}
local util = require("util")

function rust.load()
    vim.cmd("setlocal spell")
    vim.cmd("setlocal spelllang=en_us")

    vim.cmd("inorea <buffer> unwarp unwrap")

    util.snippet("implæ", "impl <c> {\n}")
    util.snippet("structæ", "struct <c> {\n}")
    util.snippet("enumæ", "enum <c> {\n}")
    util.snippet("fnæ", "fn <c>() {\n}")
    util.snippet("ifæ", "if <c> {\n}")
    util.snippet("matchæ", "match <c> {\n}")
    util.snippet("foræ", "for <c> in {\n}")
end

return rust
