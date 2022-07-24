vim.opt.sessionoptions='blank,buffers,curdir,folds,help,tabpages,winsize'
-- thx to https://www.reddit.com/r/neovim/comments/opipij/guide_tips_and_tricks_to_reduce_startup_and/
local disabled_built_ins = {
    '2html_plugin',
    'bugreport',
    'compiler',
    'did_load_filetypes',
    'ftplugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'matchit',
    'optwin',
    'perl_provider',
    'rplugin',
    'rrhelper',
    'ruby_provider',
    'spellfile_plugin',
    'synmenu',
    'syntax',
    'tar',
    'tarPlugin',
    'tutor',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin',
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g['loaded_' .. plugin] = 1
end
vim.g.netrw_banner = 0 -- Do not show netrw banner
if vim.fn.executable('ugrep') == 1 then
    vim.opt.grepprg='ugrep -RInk -j -u --tabs=1 --ignore-files'
    vim.opt.grepformat='%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\|%l\\|%c\\|%m'
end
if vim.fn.executable('nvr') == 1 then
    vim.env.GIT_EDITOR = "nvr -cc split +'setl bh=delete' --remote-wait"
    vim.env.EDITOR = 'nvr -l --remote'
    vim.env.VISUAL = 'nvr -l --remote'
end
vim.opt.path = vim.env.XDG_CONFIG_HOME .. '/nvim,' ..
	vim.env.XDG_CONFIG_HOME .. '/nvim/after,' ..
	vim.env.HOME .. '/.local/share/nvim/site/' ..
		',.,..,/usr/include,./include,../include,*'
vim.opt.fillchars:append { eob = " " }                       -- Disable ~ symbol
vim.opt.formatprg = 'par -140'                               -- Better format
vim.opt.report = 0                                           -- No report on substitution
vim.opt.fileformats = 'unix,dos,mac'                         -- File format fallback
vim.opt.conceallevel = 1                                     -- Enable conceal without hide
vim.opt.concealcursor = 'niv'                                -- Conceal cursor
vim.opt.keymap = 'russian-jcukenwin'                         -- Add ru keymap
vim.opt.backup = true                                        -- Backuping is good
vim.opt.writebackup = true                                   -- Backuping is good for write
vim.opt.cindent = true                                       -- Smart indenting for c-like code
vim.opt.cinoptions = 'b1,g0,N-s,t0,(0,W4'                    -- See :h cinoptions-values
vim.opt.clipboard = 'unnamedplus'                            -- Always clipboard all operations
vim.opt.copyindent = true                                    -- Copy the previous indentation on autoindenting
vim.opt.diffopt:append {'internal','algorithm:patience'}     -- Better diff algorithm
vim.opt.diffopt:append("indent-heuristic")                   -- Use the indent heuristic for the internal diff library.
vim.opt.eadirection = 'hor'                                  -- Ver/hor/both - where does equalalways apply
vim.opt.expandtab = true                                     -- Tabs are spaces = not tabs
vim.opt.fileencodings = 'utf-8,default'                      -- Less file encodings
vim.opt.gdefault = true                                      -- This makes search/replace global by default
vim.opt.ignorecase = true                                    -- Case insensitive search
vim.opt.iminsert = 0                                         -- Write latin1 characters first
vim.opt.imsearch = 0                                         -- Search with latin1 characters first
vim.opt.isfname:append {','}                                 -- Scan in filenames in such brackets
vim.opt.jumpoptions = 'stack'                                -- Stack jumpoptions
vim.opt.matchtime = 0                                        -- Default time to hi brackets too long for me
vim.opt.matchpairs:append '<:>'                              -- More matchpairs
vim.opt.autowrite = false                                    -- Dont autowrite by default
vim.opt.foldenable = false                                   -- Disable folds as
vim.opt.joinspaces = false                                   -- Prevents inserting two spaces after punctuation on a join (J
vim.opt.showmatch = false                                    -- Show matching brackets/parenthesis
vim.opt.numberwidth = 3                                      -- Shorter number width
vim.opt.signcolumn = 'auto:1'                                -- Merge sign and numbers
vim.opt.pumblend = 15                                        -- setup pmenu transparency
vim.opt.pumheight = 10                                       -- Do not make pmenu too wide
vim.opt.scrolljump = 0                                       -- Lines to scroll when cursor leaves screen
vim.opt.scrolloff  = 0                                       -- Minimum lines to keep above and below cursor
vim.opt.sidescrolloff = 0                                    -- Min num of scr columns to keep to the left and to the
vim.opt.scrollback = 1                                       -- Disable scrollback
vim.opt.shiftround = false                                   -- Makes indenting a multiple of shiftwidth
vim.opt.shiftwidth = 4                                       -- Spaces for autoindents
vim.opt.termguicolors = true                                 -- Enable termguicolors
vim.opt.wildignorecase = true                                -- Ignore case for wildmenu
vim.opt.wildignore:append {
	"*.7z" , "*.aux" , "*.avi" , "*.bak" , "*.bib" , "*.class" , "*.cls" , "*.cmi"
	, "*.cmo" , "*.doc" , "*.docx" , "*.dvi" , "*.flac" , "*.flv" , "*.gif" , "*.ico"
	, "*.jpeg" , "*.jpg" , "*.log" , "*.min*.js" , "*.mov" , "*.mp3" , "*.mp4" , "*.mpg"
	, "*.nav" , "*.o" , "*.ods" , "*.odt" , "*.ogg" , "*.opus" , "*.out" , "*.pdf"
	, "*.pem" , "*.png" , "*.rar" , "*.sty" , "*.svg" , "*.swp" , "*.swp*." , "*.tar"
	, "*.tgz" , "*.toc" , "*.wav" , "*.webm" , "*.xcf" , "*.xls" , "*.xlsx" , "*.zip"
}
vim.opt.hlsearch = true                                      -- Highlight search results
vim.opt.shortmess:append 'aoOstTAIcqF'                       -- Shorting messages for all
vim.opt.more = false                                         -- Do not ask to press enter
vim.opt.showmode = false                                     -- Do not show the mode ("-- INSERT --" at the bottom)
vim.opt.showcmd = false                                      -- Do not show command output
vim.opt.showtabline = 0                                      -- Do not show tab line
vim.opt.smartcase = true                                     -- Case sensitive when uc present
vim.opt.softtabstop = 4                                      -- Let backspace delete indent
vim.opt.splitbelow = true                                    -- Puts new split windows to the bottom of the current
vim.opt.splitright = true                                    -- Puts new vsplit windows to the right of the current
vim.opt.switchbuf = 'useopen,usetab'                         -- useopen may be useful for re-using QuickFix window.
vim.opt.tabstop = 4                                          -- An indentation every four columns
vim.opt.timeoutlen = 400                                     -- 400 ms wait to sequence complete
vim.opt.ttimeoutlen = 20                                     -- Very fast and also you shouldnt make combination too fast
vim.opt.updatetime = 100                                     -- Faster diagnostics
vim.opt.redrawtime = 1500                                    -- Shorter redrawtime
vim.opt.virtualedit = 'onemore,block'                        -- Allow for cursor beyond last character
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'                        -- Backspace and cursor keys wrap too
vim.opt.wildoptions = 'pum'                                  -- Wild options
vim.opt.winblend = 15                                        -- Pseudo-transparency for floating windows
vim.opt.winminheight = 0                                     -- Windows can be 0 line high
vim.opt.winminwidth = 0                                      -- Windows can be 0 line width
vim.opt.wrap = false                                         -- Do not wrap lines by default
vim.opt.mouse = 'a'                                          -- Add mouse support
vim.opt.backupdir = vim.env.HOME .. '/trash/'                -- Setup backupdir
vim.opt.directory = vim.env.HOME .. '/trash/'                -- Directory for swap files
vim.opt.undodir = vim.env.HOME .. '/trash/'                  -- Setup undo dir
vim.opt.undofile = true                                      -- Enable undofile
vim.opt.shada = "!,'100,<50,s100,h,:100,%,/100"              -- Shada settings
vim.opt.completeopt = {'menu','menuone','noselect'}          -- Completion options
vim.opt.formatoptions = 'n1jcroqlj'                          -- Format settings
vim.opt.cpoptions = '_$ABFWcdesa'                            -- Vim-exclusive stuff
vim.opt.ruler = false                                        -- No ruler
vim.opt.cmdheight = 1                                        -- Fancy cmdheight for neovim-nightly(disable for now)
vim.opt.laststatus = 3                                       -- One statusline for all
