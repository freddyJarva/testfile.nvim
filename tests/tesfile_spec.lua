local spec_dir = '/tmp/testfile-spec'

describe("testfile", function ()
    after_each(function()
        if next(vim.fs.find('testfile-spec', {
            path = '/tmp'
        })) then
            vim.cmd('!rm -r '..spec_dir)
        end
    end)

    it("can be required", function()
        require("testfile")
    end)

    it("can create a new buffer with a testfile path from current buffer", function()
        vim.fn.mkdir(spec_dir)
        vim.fn.chdir(spec_dir)
        local bufnr = vim.fn.bufadd(spec_dir..'/src/Controller/LameController.php')
        vim.cmd.buffer(bufnr)
        require("testfile").create_test()

        assert.are.same(spec_dir..'/tests/Controller/LameControllerTest.php', vim.api.nvim_buf_get_name(0))
    end)
end)
