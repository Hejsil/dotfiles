-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/zig')
require('plugins/fzf-open')

vis.ftdetect.filetypes.zig = {
    ext = { "%.zig$" },
}

vis.events.subscribe(vis.events.INIT, function()
    -- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    -- Your per window configuration options e.g.
    vis:command('set autoindent on')
    vis:command('set change-256colors on')
    vis:command('set cursorline off')
    vis:command('set expandtab on')
    vis:command('set loadmethod auto')
    vis:command('set numbers on')
    vis:command('set relativenumbers on')
    vis:command('set savemethod auto')
    vis:command('set show-eof on')
    vis:command('set show-newlines off')
    vis:command('set show-spaces off')
    vis:command('set show-tabs on')
    vis:command('set tabwidth 4')
    vis:command('set theme my-theme')

    vis:map(vis.modes.NORMAL, '<C-Up>', '<C-k>')
    vis:map(vis.modes.NORMAL, '<C-Down>', '<C-j>')
    vis:map(vis.modes.NORMAL, '<C-Left>', 'b')
    vis:map(vis.modes.NORMAL, '<C-Right>', 'w')
    vis:map(vis.modes.NORMAL, '<C-p>', function() vis:command('fzf') end)    


end)
