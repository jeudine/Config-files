---@type LazySpec
return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
"   _______    _______       _______  ________  ________  ________ ",
"  ╱       ╲╲╱╱       ╲    ╱╱       ╲╱        ╲╱        ╲╱        ╲",
" ╱        ╱╱╱      __╱   ╱╱        ╱         ╱         ╱         ╱",
"╱         ╱        _╱   ╱        _╱         ╱         ╱         ╱ ",
"╲__╱__╱__╱╲_______╱     ╲____╱___╱╲________╱╲________╱╲__╱__╱__╱  ",
  }
      return opts
    end,
  },

  {
    "windwp/nvim-autopairs", enabled = false
  },
}
