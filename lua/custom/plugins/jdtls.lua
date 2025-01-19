return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {
      setup = {
        jdtls = function(_, opts)
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
              require("lazyvim.util").on_attach(function(_, buffer)
                vim.keymap.set(
                  "n",
                  "<leader>di",
                  "<Cmd>lua require'jdtls'.organize_imports()<CR>",
                  { buffer = buffer, desc = "Organizar Importações" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>dt",
                  "<Cmd>lua require'jdtls'.test_class()<CR>",
                  { buffer = buffer, desc = "Classe de Teste" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>dn",
                  "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
                  { buffer = buffer, desc = "Método de Teste Mais Próximo" }
                )
                vim.keymap.set(
                  "v",
                  "<leader>de",
                  "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
                  { buffer = buffer, desc = "Extrair Variável" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>de",
                  "<Cmd>lua require('jdtls').extract_variable()<CR>",
                  { buffer = buffer, desc = "Extrair Variável" }
                )
                vim.keymap.set(
                  "v",
                  "<leader>dm",
                  "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
                  { buffer = buffer, desc = "Extrair Método" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>cf",
                  "<cmd>lua vim.lsp.buf.formatting()<CR>",
                  { buffer = buffer, desc = "Formatar" }
                )
              end)

              local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
              -- vim.lsp.set_log_level('DEBUG')
              local workspace_dir = "/home/jake/.workspace/" .. project_name -- Veja `:help vim.lsp.start_client` para uma visão geral das opções `config` suportadas.
              local config = {
                -- O comando que inicia o servidor de linguagem
                -- Veja: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                cmd = {

                  "java", -- ou '/path/to/java17_or_newer/bin/java'
                  -- depende se `java` está na sua variável de ambiente $PATH e se aponta para a versão correta.

                  "-javaagent:/home/jake/.local/share/java/lombok.jar",
                  -- '-Xbootclasspath/a:/home/jake/.local/share/java/lombok.jar',
                  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                  "-Dosgi.bundles.defaultStartLevel=4",
                  "-Declipse.product=org.eclipse.jdt.ls.core.product",
                  "-Dlog.protocol=true",
                  "-Dlog.level=ALL",
                  -- '-noverify',
                  "-Xms1g",
                  "--add-modules=ALL-SYSTEM",
                  "--add-opens",
                  "java.base/java.util=ALL-UNNAMED",
                  "--add-opens",
                  "java.base/java.lang=ALL-UNNAMED",
                  "-jar",
                  vim.fn.glob("/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
                  -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
                  -- Deve apontar para o                                                     Altere isso para
                  -- eclipse.jdt.ls instalação                                           a versão real

                  "-configuration",
                  "/usr/share/java/jdtls/config_linux",
                  -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                  -- Deve apontar para o                      Altere para um dos `linux`, `win` ou `mac`
                  -- eclipse.jdt.ls instalação            Dependendo do seu sistema.

                  -- Veja a seção `data directory configuration` no README
                  "-data",
                  workspace_dir,
                },

                -- Este é o padrão se não fornecido, você pode removê-lo. Ou ajuste conforme necessário.
                -- Um servidor e cliente LSP dedicado será iniciado por diretório raiz exclusivo
                root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

                -- Aqui você pode configurar as configurações específicas do eclipse.jdt.ls
                -- Veja https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                -- para uma lista de opções
                settings = {
                  java = {},
                },
                handlers = {
                  ["language/status"] = function(_, result)
                    -- print(result)
                  end,
                  ["$/progress"] = function(_, result, ctx)
                    -- desabilitar atualizações de progresso.
                  end,
                },
              }
              require("jdtls").start_or_attach(config)
            end,
          })
          return true
        end,
      },
    },
  },
}
