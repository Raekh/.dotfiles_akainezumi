return {
    "akinsho/nvim-bufferline.lua",
    lazy = false,
    keys = {
        {'<C-l>', '<cmd>BufferLineCycleNext<CR>'},
        {'<C-h>', '<cmd>BufferLineCyclePrev<CR>'},
        {'<C-x>', '<cmd>Bdelete<CR>'}
    },
    config = function()
        local symbol_map = {
            error = "",
            warning = "",
            info = "",
            hint = "",
        }

        require('bufferline').setup {
            options = {
                mode = 'buffers',
                numbers = 'none',
                show_tab_indicators = true,
                max_name_length = 30,
                max_prefix_length = 20,
                diagnostics = "nvim_lsp",
                indicator = {
                    icon = '▎', -- this should be omitted if indicator style is not 'icon'
                    -- separator_style = { "│", "│" },
                    style = 'icon',
                },
                ---@diagnostic disable-next-line: unused-local
                diagnostics_indicator = function(total_count, level, diagnostics_dict, context)
                    -- local icon = level:match("error") and " " or " "
                    -- return " " .. icon .. count
                    local s = ""
                    for kind, count in pairs(diagnostics_dict) do
                        s = string.format("%s %s %d", s, symbol_map[kind], count)
                    end
                    return s
                end,
                diagnostics_update_in_insert = true,
                name_formatter = function(buf)
                    if buf.name:match('%.md') then
                        return vim.fn.fnamemodify(buf.name, ':t:r')
                    end
                end,
                ---@diagnostic disable-next-line: assign-type-mismatch
                separator_style = { "│", "│" },
                always_show_bufferline = true,
                show_buffer_close_icons = true,
                show_close_icon = false,
                color_icons = true,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true
                    }
                },
            },
            --[[
            highlights = {
                separator = {
                    guifg = '#073642',
                    guibg = '#002b36',
                },
                separator_selected = {
                    guifg = '#073642',
                },
                background = {
                    guifg = '#657b83',
                    guibg = '#002b36',
                },
                buffer_selected = {
                    guifg = '#fdf6e3',
                    gui = 'bold',
                },
                fill = {
                    guibg = '#073642'
                }
            }
        --]]
        }
    end
}