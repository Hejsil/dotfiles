local util = require("util")

vim.cmd("inorea <buffer> unwarp' unwrap")

util.snippet("impl", [[impl <c> {
}]])
util.snippet("struct", [[struct <c> {
}]])
util.snippet("enum", [[enum <c> {
}]])
util.snippet("fn", [[fn <c>() {
}]])
util.snippet("if", [[if <c> {
}]])
util.snippet("match", [[match <c> {
}]])
util.snippet("for", [[for <c> in {
}]])
