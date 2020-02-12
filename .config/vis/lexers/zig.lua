local l = require('lexer')
local token, word_match = l.token, l.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local M = {_NAME = 'zig'}

local bin = R('01')
local oct = R('07')
local dec = R('09')
local hex = dec + R('af') + R('AF')

local builtins = token(l.PREPROCESSOR, '@' * l.word)
local comment = token(l.COMMENT, '//' * l.nonnewline_esc^0)
local identifier = token(l.IDENTIFIER, l.word)
local operator = token(l.OPERATOR, S('!%&()*+,-./:;<=>?[]^{|}~'))
local ws = token(l.WHITESPACE, l.space^1)

local string = token(l.STRING,
    l.delimited_range('"', true) +
    l.delimited_range("'", true) +
    '\\' * l.nonnewline_esc^0
)
local number = token(l.NUMBER,
    '0x' * hex^1 * '.' * hex^1 * (S('pP') * S('-+')^-1 * hex^1)^-1 +
           dec^1 * '.' * dec^1 * (S('eE') * S('-+')^-1 * dec^1)^-1 +

    '0x' * hex^1 * P('.')^-1 * S('eE') * S('-+')^-1 * hex^1 +
           dec^1 * P('.')^-1 * S('eE') * S('-+')^-1 * dec^1 +

    '0b' * bin^1 +
    '0o' * oct^1 +
    '0x' * hex^1 +
           dec^1
)
local keyword = token(l.KEYWORD, word_match{
    'align',    'allowzero', 'and',         'asm',
    'async',    'await',     'break',       'catch',
    'comptime', 'const',     'continue',    'defer',
    'else',     'enum',      'errdefer',    'error',
    'export',   'extern',    'fn',          'for',
    'if',       'inline',    'noalias',     'or',
    'orelse',   'packed',    'promise',     'pub',
    'resume',   'return',    'linksection', 'struct',
    'suspend',  'switch',    'test',        'threadlocal',
    'try',      'union',     'unreachable', 'usingnamespace',
    'var',      'volatile',  'while'
})
local constant = token(l.CONSTANT, word_match{
  'true', 'false', 'undefined', 'null'
})
local type = token(l.TYPE,
    l.upper * (l.alnum + '_')^0 +
    S('ui') * dec^1 +
    'f' * l.word_match{ '16', '32', '64', '128' } +
    'c_' * l.word_match{
        'short',      'ushort', 'int',      'uint',
        'long',       'ulong',  'longlong', 'ulonglong',
        'longdouble', 'void'
    } +
    l.word_match{
        'void',           'bool', 'isize',    'usize',
        'noreturn',       'type', 'anyerror', 'comptime_int',
        'comptime_float'
    }
)

M._rules = {
    {'whitespace', ws},
    {'comment', comment},
    {'keyword', keyword},
    {'type', type},
    {'constant', constant},
    {'operator', operator},
    {'identifier', identifier},
    {'string', string},
    {'number', number},
    {'builtins', builtins},
}

M._foldsymbols = {
  _patterns = {'[{}]', '//'},
  [l.OPERATOR] = {['{'] = 1, ['}'] = -1},
  [l.COMMENT] = {
    ['//'] = l.fold_line_comments('//'),
  }
}

return M
