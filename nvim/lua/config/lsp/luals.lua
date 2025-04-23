local M = {}

M.on_init = function(client)
  local ws = client.workspace_folders[1].name
  if not vim.uv.fs_stat(ws .. "/.luarc.json") and not vim.uv.fs_stat(ws .. "/.luarc.jsonc") then
    -- Assume Neovim workspace
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    })
  end
end

M.settings = { Lua = { diagnostics = { globals = { "vim" } } } }

return M
