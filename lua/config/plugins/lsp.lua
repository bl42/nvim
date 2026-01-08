return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Mason removed - using NixOS to manage LSPs instead!
		{ "j-hui/fidget.nvim", opts = {} },

		-- TODO: move cmp into new file
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		-- Configure LSPs using vim.lsp.config (Neovim 0.11+)

		-- TypeScript/JavaScript (tsserver renamed to ts_ls)
		vim.lsp.config.ts_ls = {
			capabilities = capabilities,
			on_attach = function(client)
				-- Disable ts_ls formatting if you prefer prettier
				client.server_capabilities.documentFormattingProvider = false
			end,
		}

		-- Tailwind CSS
		vim.lsp.config.tailwindcss = {
			capabilities = capabilities,
			filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
							{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							{ "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						},
					},
				},
			},
		}

		-- Lua (for neovim config)
		vim.lsp.config.lua_ls = {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "it", "describe", "before_each", "after_each" },
					},
				},
			},
		}

		-- Rust
		vim.lsp.config.rust_analyzer = {
			capabilities = capabilities,
		}

		-- Python
		vim.lsp.config.pyright = {
			capabilities = capabilities,
		}

		-- Nix
		vim.lsp.config.nil_ls = {
			capabilities = capabilities,
		}

		-- Go
		vim.lsp.config.gopls = {
			capabilities = capabilities,
		}

		-- Bash
		vim.lsp.config.bashls = {
			capabilities = capabilities,
		}

		-- C/C++
		vim.lsp.config.clangd = {
			capabilities = capabilities,
		}

		-- HTML/CSS/JSON (from vscode-langservers-extracted)
		vim.lsp.config.html = {
			capabilities = capabilities,
		}
		vim.lsp.config.cssls = {
			capabilities = capabilities,
		}
		vim.lsp.config.jsonls = {
			capabilities = capabilities,
		}

		-- YAML
		vim.lsp.config.yamlls = {
			capabilities = capabilities,
		}

		-- Markdown
		vim.lsp.config.marksman = {
			capabilities = capabilities,
		}

		-- Enable all configured LSPs
		vim.lsp.enable({
			"ts_ls",
			"tailwindcss",
			"lua_ls",
			"rust_analyzer",
			"pyright",
			"nil_ls",
			"gopls",
			"bashls",
			"clangd",
			"html",
			"cssls",
			"jsonls",
			"yamlls",
			"marksman",
		})

		cmp.setup({
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			window = {
				completion = { -- rounded border; thin-style scrollbar
					border = "single",
				},
				documentation = { -- no border; native-style scrollbar
					border = "single",
					-- other options
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Configure hover to display with proper formatting
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attached", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("[d", vim.diagnostic.goto_prev, "Go to previous [D]iagnostic")
				map("]d", vim.diagnostic.goto_next, "Go to next [D]iagnostic")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})
	end,
}
