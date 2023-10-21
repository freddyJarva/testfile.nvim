local M = {}

M.create_test = function ()
    local current_file = vim.api.nvim_buf_get_name(0)
    local cwd_relative_file = vim.fn.fnamemodify(current_file, ':.')
    if current_file == cwd_relative_file then
        print('current file must exist under cwd. aborting test creation.')
    end
    local extension = vim.fn.fnamemodify(current_file, ':e')
    local stub = vim.fn.fnamemodify(current_file, ':t:r')
    local testfile_dir = vim.fn.fnamemodify(current_file, ':h:s?/src/?/tests/?')
    -- TODO make this change depending on extension/language
    local testname_prefix = 'Test'
    local testfile = testfile_dir..'/'..stub..testname_prefix..'.'..extension

    local testbuf = vim.fn.bufadd(testfile)
    vim.cmd.buffer(testbuf)
end

return M
