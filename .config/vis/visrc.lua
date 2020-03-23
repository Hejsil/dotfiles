-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/zig')

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
    vis:command('set numbers off')
    vis:command('set relativenumbers off')
    vis:command('set savemethod auto')
    vis:command('set show-eof on')
    vis:command('set show-newlines off')
    vis:command('set show-spaces off')
    vis:command('set show-tabs on')
    vis:command('set tabwidth 4')
    vis:command('set theme my-theme')

    vis:map(vis.modes.NORMAL, '<C-Left>', 'b')
    vis:map(vis.modes.NORMAL, '<C-Right>', 'w')
    vis:map(vis.modes.INSERT, '<C-Left>', function () vis:feedkeys('<vis-motion-word-start-prev>') end)
    vis:map(vis.modes.INSERT, '<C-Right>', function () vis:feedkeys('<vis-motion-word-start-next>') end)
    vis:map(vis.modes.NORMAL, '<C-Up>', '<C-k>')
    vis:map(vis.modes.NORMAL, '<C-Down>', '<C-j>')
    vis:map(vis.modes.INSERT, '<C-Up>', function () vis:feedkeys('<vis-selection-new-lines-above-first>') end)
    vis:map(vis.modes.INSERT, '<C-Down>', function () vis:feedkeys('<vis-selection-new-lines-below-last>') end)
end)
