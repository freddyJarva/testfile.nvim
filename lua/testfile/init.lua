local M = {}

M._reset_config = function ()
    M.config = {
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
end

M.config = {
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

    local testfile = testfile_dir..'/'..cfg.test_prefix..stub..cfg.test_suffix..'.'..extension

    local testbuf = vim.fn.bufadd(testfile)
    vim.cmd.buffer(testbuf)
end

M.toggle = function ()
    print("WHAT IS CRACKALACKIN")
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

    local target_dir = vim.fn.fnamemodify(current_file, ':h:s?/'..cfg.src_dir..'/?/'..cfg.test_dir..'/?')
    local target_filename = cfg.test_prefix..stub..cfg.test_suffix..'.'..extension
    if target_dir == vim.fn.fnamemodify(current_file, ':h') then
        target_dir = vim.fn.fnamemodify(current_file, ':h:s?/'..cfg.test_dir..'/?/'..cfg.src_dir..'/?')
        -- remove testprefix and testsuffix from filename
        target_filename = vim.fn.fnamemodify(current_file, ':t:r:s?'.. cfg.test_prefix .. '??:s?' .. cfg.test_suffix .. '??') .. '.' .. extension
        -- target_filename = vim.fn.fnamemodify(current_file, ':t:r:s?'..cfg.test_prefix..'??'..cfg.test_suffix..'??'..'.'..extension)
    end
    print('current_file', current_file)
    print('target_dir', target_dir)
    print('target_filename', target_filename)

    local targetfile = target_dir..'/'..target_filename

    local newbuf = vim.fn.bufadd(targetfile)
    vim.cmd.buffer(newbuf)
end


return M
