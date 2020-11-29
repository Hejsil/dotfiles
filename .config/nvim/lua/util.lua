local util = {}

function util.read_all(filename)
    local f = io.open(filename)
    local r = f:read("*all")
    f:close()
    return r
end

function util.edit(stdout)
    local it = vim.gsplit(stdout, ":", true)
    vim.cmd("e " .. it())
    vim.cmd(it())
end

function util.term(cmd, callback)
    local tmp = vim.fn.tempname()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(buf)

    -- TODO: We cannot use nvim_buf_set_option for this propety. Is there
    --       another way we can set 'norelativenumber' locally for the buffer?
    vim.cmd("set norelativenumber")
    vim.fn.termopen(cmd .. " > " .. tmp, {
        on_exit = function()
            vim.api.nvim_buf_delete(buf, { force = true })
            vim.cmd("set relativenumber")
            local stdout = util.read_all(tmp)
            os.remove(tmp)
            callback(stdout)
        end,
    })
    vim.cmd("startinsert!")
end

function util.snippet(word, text)
    local escaped = text
        :gsub("\n", "<cr>")
        :gsub("|", "\\|")

    if escaped:find("<c>") then
        vim.cmd("inorea <buffer> " .. word .. " " .. escaped .. '<esc>?<c><cr>c3l<c-o>:lua vim.fn.getchar(0)<cr>')
    else
        vim.cmd("inorea <buffer> " .. word .. " " .. escaped .. '<c-o>:lua vim.fn.getchar(0)<cr>')
    end
end

return util

