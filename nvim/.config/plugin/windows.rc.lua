import('windows', function(windows)
    windows.setup({
        autowidth = {
            -- filetype = {
            --     DiffviewFiles = 5,
            -- },
        },
        ignore = {
            -- buftype = { "diffview.nvim" },
            filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "DiffviewFiles" }
        },
        animation = {
            enable = true,
            duration = 300,
            fps = 144,
            easing = "in_out_sine"
        }
    })

    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false

    vim.keymap.set('n', ';wz', '<Cmd>WindowsMaximize<CR>')
end)