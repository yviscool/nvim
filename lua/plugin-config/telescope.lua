local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end

base_ignore_patterns = {
      "nuts/*",
      "node%_modules/*",
      "external_data/*",
      ".idea/*",
      ".git/*",
      "app/Domain/Smartloader/assets/libs/*",
      "storage/*",
      "_ide_helper.php",
      ".phpstorm.meta.php",
      "public/js/*",
      "public/css/*",
      "public/libs/*",
      "public/vendor/*",
      "public/assets/*",
      "test/*",
}

local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- vertical , center , cursor
    layout_strategy = "horizontal",
    -- 窗口内快捷键
    mappings = require("keybindings").telescopeList,

    file_ignore_patterns = base_ignore_patterns,
  },
  pickers = {
    find_files = {
      -- theme = "dropdown"
    },
    live_grep = {
      -- theme = "dropdown"
    },
    buffers = {
      -- theme = "dropdown"
    },
    help_tags = {
      -- theme = "dropdown"
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),
    },
  },
})

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "env")
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
pcall(telescope.load_extension, "ui-select")
pcall(telescope.load_extension, "media_files")
