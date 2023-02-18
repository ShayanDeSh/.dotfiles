resize = require("easy_resize")

vim.keymap.set('n', '<C-right>', resize.right_resize)
vim.keymap.set('n', '<C-left>', resize.left_resize)
vim.keymap.set('n', '<C-up>', resize.up_resize)
vim.keymap.set('n', '<C-down>', resize.down_resize)


-- Set up nvim-cmp.
require("mason").setup()
require("mason-lspconfig").setup()

-- LSP 
local cmp = require'cmp'
local lspconfig = require'lspconfig'

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
    { name = 'path'}
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

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local bufopts = { noremap=true, silent=false, buffer=bufnr }
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
    require "lsp_signature".on_attach({
        doc_lines = 0,
        handler_opts = {
            border = "none"
            },
    })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
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
  capabilities = capabilities,
}


lspconfig.pyright.setup {
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
          build = {
              onSave = true
          },
          chktex = {
              onEdit = true
          }
      }
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

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ':('})
sign({name = 'DiagnosticSignWarn', text = ':?'})
sign({name = 'DiagnosticSignHint', text = ':)'})
sign({name = 'DiagnosticSignInfo', text = ':o'})


null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black
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

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help", "rust", "python", "cpp" },
  sync_install = false,
  auto_install = true,
  ignore_install = { },
  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = false,
  },
}


return {
    is_first_in_col = is_first_in_col,
    is_last_in_row = is_last_in_row
}
