local spec_dir = '/tmp/testfile-spec'

describe("testfile", function ()
    before_each(function ()
        vim.fn.mkdir(spec_dir)
    end)

    after_each(function()
        if next(vim.fs.find('testfile-spec', {
            path = '/tmp'
        })) then
            vim.cmd('!rm -r '..spec_dir)
        end
        require('testfile')._reset_config()
    end)

    it("can be required", function()
        require("testfile")
    end)

    it("can create a new buffer with a testfile path from current buffer - php config", function()
        vim.fn.chdir(spec_dir)
        local bufnr = vim.fn.bufadd(spec_dir..'/src/controller/LameController.php')
        vim.cmd.buffer(bufnr)
        require("testfile").toggle()

        assert.are.same(spec_dir..'/tests/controller/LameControllerTest.php', vim.api.nvim_buf_get_name(0))
    end)

    it("can create a new buffer with a srcfile  path from current buffer - php config", function()
        vim.fn.chdir(spec_dir)
        local bufnr = vim.fn.bufadd(spec_dir..'/tests/controller/LameControllerTest.php')
        vim.cmd.buffer(bufnr)
        require("testfile").toggle()

        assert.are.same(spec_dir..'/src/controller/LameController.php', vim.api.nvim_buf_get_name(0))
    end)

    it("can create a new buffer with a testfile path from current buffer - lua config", function()
        vim.fn.chdir(spec_dir)
        local bufnr = vim.fn.bufadd(spec_dir..'/lua/somename/awesome.lua')
        vim.cmd.buffer(bufnr)
        require("testfile").toggle()

        assert.are.same(spec_dir..'/tests/somename/awesome_spec.lua', vim.api.nvim_buf_get_name(0))
    end)

    it("can create a new buffer with a testfile path from current buffer - go config", function()
        vim.fn.chdir(spec_dir)
        local bufnr = vim.fn.bufadd(spec_dir..'/awesome.go')
        vim.cmd.buffer(bufnr)
        require("testfile").toggle()

        assert.are.same(spec_dir..'/awesome_test.go', vim.api.nvim_buf_get_name(0))
    end)

    it("can create a new buffer with a srcfile path from current buffer - go config", function()
        vim.fn.chdir(spec_dir)
        local bufnr = vim.fn.bufadd(spec_dir..'/awesome_test.go')
        vim.cmd.buffer(bufnr)
        require("testfile").toggle()

        assert.are.same(spec_dir..'/awesome.go', vim.api.nvim_buf_get_name(0))
    end)

    it("can create a new buffer with a srcfile path if current buffer is testfile", function()
        local testfile = require('testfile')
        vim.fn.chdir(spec_dir)
        local bufnr = vim.fn.bufadd(spec_dir..'/tests/Controller/LameControllerTest.php')
        vim.cmd.buffer(bufnr)
        testfile.toggle()

        assert.are.same(spec_dir..'/src/Controller/LameController.php', vim.api.nvim_buf_get_name(0))
    end)
end)
