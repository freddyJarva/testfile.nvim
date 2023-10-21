local M = {}

M.create_test = function ()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == vim.fn.fnamemodify(current_file, ':.') then
        print('current file must exist under cwd. aborting test creation.')
    end
    local extension = vim.fn.fnamemodify(current_file, ':e')
    local stub = vim.fn.fnamemodify(current_file, ':t:r')

    local testfile_dir = vim.fn.fnamemodify(current_file, ':h:s?/src/?/tests/?')
    if testfile_dir == vim.fn.fnamemodify(current_file, ':h') then
        print('did nothing: current file seems to be a test file')
        return
    end


    -- TODO make this change depending on extension/language
    local testname_prefix = 'Test'
    local testfile = testfile_dir..'/'..stub..testname_prefix..'.'..extension

    local testbuf = vim.fn.bufadd(testfile)
    vim.cmd.buffer(testbuf)
end

return M
