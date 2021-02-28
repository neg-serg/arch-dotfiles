local o = vim.o
local g = vim.g
local a = vim.api
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end
opt('o', 'exrc', false)
opt('o', 'secure', true)
opt('o', 'termguicolors', true)
opt('o', 'packpath', '/home/neg/.config/nvim,/home/neg/.config/nvim/after,/home/neg/.local/share/nvim/site/')
opt('o', 'formatprg', 'par -140')                               -- Better format
opt('o', 'report', 0)                                           -- No report on substitution
opt('o', 'fileformats', 'unix,dos,mac')                         -- File format fallback
opt('o', 'synmaxcol', 256)                                      -- No syntax hi for too long lines
opt('o', 'regexpengine', 0)                                     -- Autoselect regex engine
opt('w', 'conceallevel', 2)                                     -- Enable conceal
opt('w', 'concealcursor', 'niv')                                -- Conceal cursor
opt('o', 'keymap', 'russian-jcukenwin')                         -- Add ru keymap
opt('o', 'magic', true)                                         -- Use magic
opt('o', 'listchars', '')                                       -- Disable listchars
opt('o', 'path', vim.o.path .. ',.,..,/usr/include,./include,../include,*') -- Add path settings
opt('o', 'hidden', true)                                        -- It hides buffers instead of closing them
opt('o', 'lazyredraw', true)                                    -- Reduce useless redrawing
opt('o', 'backup', true)                                        -- Backuping is good
opt('o', 'writebackup', true)                                   -- Backuping is good for write
opt('o', 'cindent', true)                                       -- Smart indenting for c-like code
opt('o', 'cinoptions', 'b1,g0,N-s,t0,(0,W4')                    -- See :h cinoptions-values
opt('o', 'clipboard', 'unnamedplus')                            -- Always clipboard all operations
opt('o', 'copyindent', true)                                    -- Copy the previous indentation on autoindenting
opt('o', 'diffopt', o.diffopt..',internal,algorithm:patience')  -- Better diff algorithm
opt('o', 'eadirection', 'hor')                                  -- Ver/hor/both - where does equalalways apply
opt('o', 'expandtab', true)                                     -- Tabs are spaces, not tabs
opt('o', 'fileencodings', 'utf-8,default')                      -- Less file encodings
opt('o', 'gdefault', true)                                      -- This makes search/replace global by default
opt('o', 'ignorecase', true)                                    -- Case insensitive search
opt('o', 'iminsert', 0)                                         -- Write latin1 characters first
opt('o', 'imsearch', 0)                                         -- Search with latin1 characters first
opt('o', 'inccommand', 'nosplit')                               -- Better live substitution
opt('o', 'isfname', o.isfname .. ',{,}')                        -- Scan in filenames in such brackets
opt('o', 'jumpoptions', 'stack')                                -- Jumplist behave like tagstack
opt('o', 'linespace', 0)                                        -- No extra spaces between rows
opt('o', 'matchtime', 0)                                        -- Default time to hi brackets too long for me
opt('o', 'matchpairs', o.matchpairs..',<:>,《:》,〈:〉')        -- More matchpairs
opt('o', 'maxfuncdepth', 100)                                   -- Maximum depth of function calls for user functions
opt('o', 'maxmapdepth', 1000)                                   -- Maximum number of times a mapping is done without resulting in a character to be used.
opt('o', 'maxmempattern', 1000)                                 -- Maximum amount of memory (in Kbyte) to use for pattern matching.
opt('o', 'autochdir', false)                                    -- Don't change pwd automaticly because of problems with plugins
opt('o', 'autoread', false)                                     -- Autoread file on change
opt('o', 'autowrite', false)                                    -- Don't autowrite by default
opt('w', 'foldenable', false)                                   -- Disable folds as
opt('o', 'joinspaces', false)                                   -- Prevents inserting two spaces after punctuation on a join (J)
opt('o', 'showmatch', false)                                    -- Show matching brackets/parenthesis
opt('w', 'spell', false)                                        -- Disable spell checking by default
opt('w', 'number', true)                                        -- Line numbers on
opt('o', 'pumblend', 15)                                        -- setup pmenu transparency
opt('o', 'pumheight', 12)                                       -- Do not make pmenu too wide
opt('o', 'scrolljump', 0)                                       -- Lines to scroll when cursor leaves screen
opt('o', 'scrolloff' , 0)                                       -- Minimum lines to keep above and below cursor
opt('o', 'scrollback', 0)                                       -- Disable scrollback
opt('o', 'sidescrolloff', 0)                                    -- Min num of scr columns to keep to the left and to the
opt('o', 'shiftround', false)                                   -- Makes indenting a multiple of shiftwidth
opt('o', 'shiftwidth', 4)                                       -- Spaces for autoindents
opt('o', 'termguicolors', true)                                 -- Enable termguicolors
opt('o', 'confirm', false)                                      -- Disable 'no write'
opt('o', 'incsearch', true)                                     -- Move cursor during search
opt('o', 'wildmenu', true)                                      -- Command line completion mode
opt('o', 'hlsearch', true)                                      -- Highlight search results (enforce)
opt('o', 'shortmess', vim.o.shortmess ..'aoOstTWAIcqFS')        -- Shorting messages for all
opt('o', 'showmode', true)                                      -- Show the mode ("-- INSERT --") at the bottom
opt('o', 'showtabline', 0)                                      -- Do not show tab line
opt('o', 'smartcase', true)                                     -- Case sensitive when uc present
opt('o', 'softtabstop', 4)                                      -- Let backspace delete indent
opt('o', 'splitbelow', true)                                    -- Puts new split windows to the bottom of the current
opt('o', 'splitright', true)                                    -- Puts new vsplit windows to the right of the current
opt('o', 'switchbuf', 'useopen,usetab')                         -- 'useopen' may be useful for re-using QuickFix window.
opt('o', 'tabstop', 4)                                          -- An indentation every four columns
opt('o', 'timeoutlen', 1000)                                    -- 1sec wait to sequence complete
opt('o', 'ttimeoutlen', 20)                                     -- Very fast and also you shouldn't make combination too fast
opt('o', 'updatetime', 250)                                     -- Faster diagnostics
opt('o', 'virtualedit', 'onemore,block')                        -- Allow for cursor beyond last character
opt('o', 'whichwrap', 'b,s,h,l,<,>,[,]')                        -- Backspace and cursor keys wrap too
opt('o', 'wildmode', 'full')                                    -- Command <Tab> completion, list matches, then longest common part, then all.
opt('o', 'wildoptions', 'pum')                                  -- Wild options
opt('w', 'winblend', 15)                                        -- Pseudo-transparency for floating windows
opt('o', 'winminheight', 0)                                     -- Windows can be 0 line high
opt('o', 'winminwidth', 0)                                      -- Windows can be 0 line width
opt('w', 'wrap', false)                                         -- Do not wrap lines by default
opt('o', 'mouse', 'a')                                          -- Add mouse support
opt('o', 'backupdir', '/home/neg/trash/')                       -- Setup backupdir
opt('o', 'directory', '/home/neg/trash/')                       -- Directory for swap files
opt('o', 'undodir', '/home/neg/trash/')                         -- Setup undo dir
opt('o', 'swapfile', false)                                     -- No swap file
opt('o', 'undofile', false)                                     -- So is persistent undo ...
opt('o', 'undolevels', 1000)                                    -- Maximum number of changes that can be undone
opt('o', 'undoreload', 10000)                                   -- Maximum number lines to save for undo on a buffer reload
opt('o', 'shada', "!,'100,<50,s100,h,:100,%,/100")              -- Shada settings
opt('o', 'background', "dark")
-- formatoptions+=t -- Auto-wrap using textwidth (not comments)
-- formatoptions+=c -- Auto-wrap comments too
-- formatoptions+=r -- Continue the comment header automatically on <CR>
-- formatoptions+=q -- Allow formatting of comments with gq
-- formatoptions+=n -- Recognize numbered lists when autoindenting
-- formatoptions+=l -- Don't break long lines in insert mode
-- formatoptions+=1 -- Don't break lines after one-letter words, if possible
-- formatoptions-=o -- Don't insert comment leader with 'o' or 'O'
-- formatoptions-=2 -- Don't use second line of paragraph when autoindenting
-- formatoptions-=v -- Don't worry about vi compatiblity
-- formatoptions-=b -- Don't worry about vi compatiblity
-- formatoptions-=j -- Delete comment character when joining
opt('o','formatoptions', 'n1jcroql')
-- cpoptions+=$ -- No line redisplay -> put a '$' at the end
-- cpoptions+=A -- -- : write --
-- cpoptions+=B -- A backslash has no special meaning in mappings
-- cpoptions+=F -- :write opt('o', name for current buffer if no
-- cpoptions+=W -- Overwrite file when possible
-- cpoptions+=c -- Search -> end of any match at the cursor pos but not start of the next line
-- cpoptions+=d -- Make ./ in tags relative to tags file in current dir
-- cpoptions+=e -- :@r adds CR and nonlinewise
-- cpoptions+=s -- opt('o', buf opts before it created
-- cpoptions+=a -- :read with a filename opt('o', the alternate filename for window
opt('o', 'cpoptions', '_$ABFWcdesa')
vim.cmd('syntax on')
vim.cmd("colorscheme neg")
