local M = {}

M.create_test = function ()
    local current_file = vim.api.nvim_buf_get_name(0)
    print("current_file: ", current_file)
end

print("hello")

M.create_test()

