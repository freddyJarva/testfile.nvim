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
        go = {
            test_suffix = '_test',
            test_prefix = '',
            test_dir = '',
            src_dir = '',
        },
    }
end

M._is_testfile = function (file_stub, cfg)
    return string.sub(file_stub, 1, string.len(cfg.test_prefix)) == cfg.test_prefix
    and string.sub(file_stub, -string.len(cfg.test_suffix)) == cfg.test_suffix
end

M._reset_config()

M.toggle = function ()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == vim.fn.fnamemodify(current_file, ':.') then
        print('current file must exist under cwd. aborting test creation.')
    end
    local extension = vim.fn.fnamemodify(current_file, ':e')

    local cfg = M.config[extension]
    if cfg == nil then
        print('did nothing: no config for file type ', extension)
        return
    end

    local stub = vim.fn.fnamemodify(current_file, ':t:r')

    local target_dir = vim.fn.fnamemodify(current_file, ':h:s?/'..cfg.src_dir..'/?/'..cfg.test_dir..'/?')
    if cfg.src_dir ~= cfg.test_dir and target_dir == vim.fn.fnamemodify(current_file, ':h') then
        target_dir = vim.fn.fnamemodify(current_file, ':h:s?/'..cfg.test_dir..'/?/'..cfg.src_dir..'/?')
    end

    local target_filename = cfg.test_prefix..stub..cfg.test_suffix..'.'..extension
    if M._is_testfile(stub, cfg) then
        target_filename = vim.fn.fnamemodify(current_file, ':t:r:s?'.. cfg.test_prefix .. '??:s?' .. cfg.test_suffix .. '??') .. '.' .. extension
    end

    local targetfile = target_dir..'/'..target_filename

    local newbuf = vim.fn.bufadd(targetfile)
    vim.cmd.buffer(newbuf)
end


return M
