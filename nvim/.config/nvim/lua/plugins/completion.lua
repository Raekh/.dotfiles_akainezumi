return {
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
    "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's builtin lsp
    "onsails/lspkind-nvim",
    {
	 "hrsh7th/nvim-cmp", -- Completion
        config = function()
                local lspkind = require('lspkind')
                local cmp = require('cmp')
                local luasnip = require('luasnip')

                local separator = "• "

                local source_mapping = {
                    buffer = separator .. "Buffer",
                    nvim_lsp = separator .. "LSP",
                    nvim_lua = separator .. "Lua",
                    cmp_tabnine = separator .. "TN",
                    path = separator .. "Path",
                }

                cmp.setup({
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-p>'] = cmp.mapping.select_prev_item(),
                        ['<C-n>'] = cmp.mapping.select_next_item(),
                        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.close(),
                        ['<CR>'] = cmp.mapping.confirm({
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = true
                        }),
                    }),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'buffer' },
                        { name = 'cmp_tabnine' },
                    }),
                    formatting = {
                        format = function (entry, vim_item)
                            vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol_text"})
                            vim_item.menu = source_mapping[entry.source.name]
                            if entry.source.name == "cmp_tabnine" then
                                local detail = (entry.completion_item.data or {}).detail
                                vim_item.kind = ""
                                if detail and detail:find('.*%%.*') then
                                    vim_item.kind = vim_item.kind .. ' ' .. detail
                                end

                                if (entry.completion_item.data or {}).multiline then
                                    vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                                end
                            end
                            local maxwidth = 80
                            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
                            return vim_item
                        end
                    }
                })

                vim.cmd [[
                    set completeopt=menuone,noinsert,noselect
                    highlight! default link CmpItemKind CmpItemMenuDefault
                ]]
        end
    }
}