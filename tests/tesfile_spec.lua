describe("tesfile", function ()
    it("can be required", function()
        require("testfile")
    end)

    after_each(function()
        vim.cmd('!rm -r /tmp/testfile-spec')
    end)

    it("can create a new buffer with a testfile path from current buffer", function()
        local spec_dir = '/tmp/testfile-spec'
        vim.fn.mkdir(spec_dir)
        vim.fn.chdir(spec_dir)
        local bufnr = vim.fn.bufadd(spec_dir..'/src/Controller/LameController.php')
        vim.cmd.buffer(bufnr)
        require("testfile").create_test()

        assert.are.same(spec_dir..'/tests/Controller/LameController.php', vim.api.nvim_buf_get_name(0))
    end)
end)
