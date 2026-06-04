return {
  -- The plugin location on GitHub
  "vimwiki/vimwiki",
  lazy = false,
  priority = 1000,
  -- The event that triggers the plugin
  event = "BufEnter *.md",
  -- The keys that trigger the plugin
  keys = { "<leader>ww", "<leader>wt" },
  -- The configuration for the plugin
  init = function()
    vim.g.vimwiki_path = '~/vimwiki/'
    vim.g.vimwiki_syntax = 'markdown'
    vim.g.vimwiki_ext = 'md'
  end,
}
