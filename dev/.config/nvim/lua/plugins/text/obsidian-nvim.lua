return {'epwalsh/obsidian.nvim', dependencies={
        'nvim-lua/plenary.nvim',
        'hrsh7th/nvim-cmp',
        'nvim-telescope/telescope.nvim'}, config=function()
            require'obsidian'.setup({
                  dir="~/1st_level", -- Required, the path to your vault directory.
                  completion={
                    nvim_cmp=true, -- If using nvim-cmp, otherwise set to false
                    min_chars=2, -- Trigger completion at 2 chars
                    new_notes_location="current_dir",
                    prepend_note_id=true
                  },
                  mappings={
                    ["gf"]={ -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                      action=function()
                        return require'obsidian'.util.gf_passthrough()
                      end,
                      opts={ noremap=false, expr=true, buffer=true },
                    },
                  },
                  note_id_func=function(title)
                    local suffix=""
                    if title ~= nil then
                      suffix=title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                    else
                      for _=1, 4 do
                        suffix=suffix .. string.char(math.random(65, 90))
                      end
                    end
                    return tostring(os.time()) .. "-" .. suffix
                  end,
                  disable_frontmatter=true,
                  note_frontmatter_func=function(note)
                    local out={ id=note.id, aliases=note.aliases, tags=note.tags }
                    if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
                      for k, v in pairs(note.metadata) do
                        out[k]=v
                      end
                    end
                    return out
                  end,
                  backlinks={height=10, wrap=true},
                  follow_url_func=function(url)
                    vim.fn.jobstart({"xdg-open", url})  -- linux
                  end,
                  use_advanced_uri=true, -- https://github.com/Vinzent03/obsidian-advanced-uri
                  open_app_foreground=false,
                  finder="telescope.nvim",
                  sort_by="modified",
                  sort_reversed=true,
                  open_notes_in="current"
            })
        end}
