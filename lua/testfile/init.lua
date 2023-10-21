local M = {}

M.create_test = function ()
    local current_file = vim.api.nvim_buf_get_name(0)
    local cwd_relative_file = vim.fn.fnamemodify(current_file, ':.')
    if current_file == cwd_relative_file then
        print('current file must exist under cwd. aborting test creation.')
    end

    local testfile = vim.fn.fnamemodify(current_file, ':s?/src/?/tests/?')

    local testbuf = vim.fn.bufadd(testfile)
    vim.cmd.buffer(testbuf)
end

return M
