local M = {}

local _default_config = {
    php = {
        test_suffix = 'Test',
        test_prefix = '',
        test_dir = 'tests',
        src_dir = 'src',
    },
    lua = {
        test_suffix = '_spec',
        test_prefix = '',
        test_dir = 'tests',
        src_dir = 'lua',
    },
}

M._reset_config = function ()
    M.config = _default_config
end

M.config = {
    _default_config
}

M.create = function ()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == vim.fn.fnamemodify(current_file, ':.') then
        print('current file must exist under cwd. aborting test creation.')
    end
    local extension = vim.fn.fnamemodify(current_file, ':e')
    local stub = vim.fn.fnamemodify(current_file, ':t:r')

    local cfg = M.config[extension]
    if cfg == nil then
        print('did nothing: no config for file type ', extension)
        return
    end

    local testfile_dir = vim.fn.fnamemodify(current_file, ':h:s?/'..cfg.src_dir..'/?/'..cfg.test_dir..'/?')
    if testfile_dir == vim.fn.fnamemodify(current_file, ':h') then
        print('did nothing: current file seems to be a test file')
        return
    end

    -- TODO make this change depending on extension/language
    local testfile = testfile_dir..'/'..cfg.test_prefix..stub..cfg.test_suffix..'.'..extension

    local testbuf = vim.fn.bufadd(testfile)
    vim.cmd.buffer(testbuf)
end

return M
