local lexer = require("lexer")
local token, word_match = lexer.token, lexer.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local lex = lexer.new("zig")
local bin = R("01")
local oct = R("07")
local dec = R("09")
local hex = dec + R("af") + R("AF")

-- Whitespace.
lex:add_rule("whitespace", token(lexer.WHITESPACE, S("\n ") ^ 1))
lex:add_rule("keywords", token(
    lexer.KEYWORD,
    lexer.word_match(
        [[ align and anyerror asm async await break cancel
           catch comptime const continue defer else enum
           errdefer error export extern false fn for if inline
           nakedcc noalias null or orelse packed promise pub
           resume return linksection stdcallcc struct suspend 
           switch test threadlocal true try undefined union
           unreachable use var volatile while                  ]]
    )
))
lex:add_rule("types", token(
    lexer.TYPE,
    lexer.upper * (lexer.alnum + "_")^0 +
    S("ui") * dec^1 +
    "f" * lexer.word_match("16 32 64 128") +
    "c" * lexer.word_match(
        [[ ĺongdouble short ushort int uint long ulong longlong
           ulonglong char void                                  ]]
    ) +
    lexer.word_match(
        [[ void bool isize usize noreturn type anyerror
           comptime_int comptime_float                          ]]
    )
))
lex:add_rule("identifier", token(lexer.IDENTIFIER, lexer.word))
lex:add_rule("builtins", token(lexer.PREPROCESSOR, "@" * lexer.word))
lex:add_rule("number", token(
    lexer.NUMBER,
    "0b" * bin^1 * "." * bin^1 * (S("eE") * S("-+")^-1 * bin^1)^-1 +
    "0o" * oct^1 * "." * oct^1 * (S("eE") * S("-+")^-1 * oct^1)^-1 +
    "0x" * hex^1 * "." * hex^1 * (S("pP") * S("-+")^-1 * hex^1)^-1 +
           dec^1 * "." * dec^1 * (S("eE") * S("-+")^-1 * dec^1)^-1 +

    "0b" * bin^1 * P(".")^-1 * S("eE") * S("-+")^-1 * bin^1 +
    "0o" * oct^1 * P(".")^-1 * S("eE") * S("-+")^-1 * oct^1 +
    "0x" * hex^1 * P(".")^-1 * S("eE") * S("-+")^-1 * hex^1 +
           dec^1 * P(".")^-1 * S("eE") * S("-+")^-1 * dec^1 +

    "0b" * bin^1 +
    "0o" * oct^1 +
    "0x" * hex^1 +
           dec^1
))
lex:add_rule("string", token(lexer.STRING, lexer.delimited_range('"') + "\\" * lexer.nonnewline^0))
lex:add_rule("comment", token(lexer.COMMENT, "//" * lexer.nonnewline^0))
lex:add_rule("operators", token(lexer.OPERATOR, S("!%&()*+,-./:;<=>?[]^{|}~")))
lex:add_rule("error", token(lexer.ERROR, lexer.any))

return lex
