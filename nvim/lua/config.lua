resize = require("easy_resize")
require("plugins")

vim.keymap.set('n', '<C-right>', resize.right_resize)
vim.keymap.set('n', '<C-left>', resize.left_resize)
vim.keymap.set('n', '<C-up>', resize.up_resize)
vim.keymap.set('n', '<C-down>', resize.down_resize)
vim.api.nvim_set_option("clipboard", "unnamedplus")


-- autoread
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained", "FileChangedShellPost" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Set up nvim-cmp.
require("mason").setup()
require("mason-lspconfig").setup()

-- LSP
local cmp = require 'cmp'
local lspconfig = require 'lspconfig'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
    }),
    sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
        }, {
            { name = 'buffer' },
        },
        {
            { name = 'path' }
        }),
    experimental = {
        ghost_text = true,
    },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Set up lspconfig.

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local bufopts = { noremap = true, silent = false, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-i>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    --    vim.keymap.set('i', '<C-c>', 'copilot#Accept("<CR>")', {expr=true, silent=true, replace_keycodes=false})

    require "lsp_signature".on_attach({
        doc_lines = 0,
        handler_opts = {
            border = "none"
        },
    })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
--lspconfig.rust_analyzer.setup {
--  on_attach = on_attach,
--  flags = {
--    debounce_text_changes = 150,
--  },
--  settings = {
--    ["rust-analyzer"] = {
--      cargo = {
--        allFeatures = true,
--      },
--      completion = {
--        postfix = {
--          enable = false,
--        },
--      },
--    },
--  },
--  capabilities = capabilities,
--}

local opts = {
    tools = {
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = true,
        },
    },
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
        settings = {
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                },

                cargo = {
                    allFeatures = true,
                },
                completion = {
                    postfix = {
                        enable = false,
                    },
                },
            },
        },
    },
}

require("rust-tools").setup(opts)



lspconfig.pyright.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",
            },
        },
    },
}

lspconfig.gopls.setup({
    on_attach = on_attach,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true
        },
    },
})

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    },
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities
}

lspconfig["ltex"].setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities
}

lspconfig.texlab.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        texlab = {
            rootDirectory = os.getenv("TEX_ROOT"),
            build = {
                onSave = true,
                args = { '-output-directory=build' }
            },
            chktex = {
                onEdit = true
            },
            outputDirectory = { 'build' }
        }
    },
    capabilities = capabilities
}

lspconfig.clangd.setup {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=bundled",
        "--cross-file-rename",
        "--header-insertion=iwyu",
    },
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities
}

lspconfig.terraformls.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities
}


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        update_in_insert = true,
    }
)

lspconfig.bufls.setup{
    on_attach= on_attach,
    capabilities = capabilities,
    cmd = {
        "bufls", "serve"
    }
}

-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = ':(' })
sign({ name = 'DiagnosticSignWarn', text = ':?' })
sign({ name = 'DiagnosticSignHint', text = ':)' })
sign({ name = 'DiagnosticSignInfo', text = ':o' })


null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy.with({
            extra_args = { "--ignore-missing-imports" }
        })
    },
})

local actions = require "telescope.actions"

require("telescope").setup {
    defaults = {
        initial_mode = "normal",
        mappings = {
            i = {
                ["<C-_>"] = actions.select_horizontal,
                ["<C-\\>"] = actions.select_vertical,
            },
            n = {
                ["<C-_>"] = actions.select_horizontal,
                ["<C-\\>"] = actions.select_vertical,
            }
        }
    }
}

require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "help", "rust", "python", "cpp" },
    sync_install = false,
    auto_install = true,
    ignore_install = { "help" },
    highlight = {
        enable = true,
        disable = { "markdown" },
        additional_vim_regex_highlighting = false,
    },
}

local iron = require("iron.core")

repl_open_cmd = "vertical botright 80 split"
iron.setup {
    config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
            sh = {
                -- Can be a table or a function that
                -- returns a table (see below)
                command = { "zsh" }
            }
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = repl_open_cmd,
    },
    -- Iron doesn't set keymaps by default anymore.
    -- You can set them here or manually add keymaps to the functions in iron.core
    keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = {
        italic = true
    },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')



--require('copilot').setup({
--  panel = {
--    enabled = true,
--    auto_refresh = false,
--    keymap = {
--      jump_prev = "[[",
--      jump_next = "]]",
--      accept = "<CR>",
--      refresh = "gr",
--      open = "<M-CR>"
--    },
--    layout = {
--      position = "bottom", -- | top | left | right
--      ratio = 0.4
--    },
--  },
--  suggestion = {
--    enabled = true,
--    auto_trigger = false,
--    debounce = 75,
--    keymap = {
--      accept = "<C-c>",
--      accept_word = false,
--      accept_line = false,
--      next = "<M-]>",
--      prev = "<M-[>",
--      dismiss = "<C-]>",
--    },
--  },
--  filetypes = {
--    yaml = false,
--    markdown = false,
--    help = false,
--    gitcommit = false,
--    gitrebase = false,
--    hgcommit = false,
--    svn = false,
--    cvs = false,
--    ["."] = false,
--  },
--  copilot_node_command = 'node', -- Node.js version must be > 16.x
--  server_opts_overrides = {},
--})


return {
    is_first_in_col = is_first_in_col,
    is_last_in_row = is_last_in_row
}
