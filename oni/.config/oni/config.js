// https://github.com/onivim/oni/wiki/Configuration
const activate = oni => {
    oni.input.unbind("<c-p>");
    oni.input.bind("<S-Insert>", "editor.clipboard.paste");
    oni.input.bind(["<enter>", "<S-tab>", "<C-Space>"], "contextMenu.select");
}

module.exports = {
    activate,

    "autoClosingPairs.enabled": false, // Disable oni's autoclosing pairs.
    "commandline.icons": true, // Commandline icons.
    "sidebar.enabled": false, // Disable sidebar.
    "commandline.mode": false, // Do not override commandline UI.
    "editor.completions.mode": 'oni', // VSCode-like completion.
    "editor.backgroundOpacity": 0.88, // Dark enough.
    "editor.backgroundImageUrl": "/home/neg/pic/wl/J8IW4DE.png",
    "editor.cursorLine": false, // Disables cursor line highlight.
    "editor.cursorColumn": false, // Disables cursor column highlight. 
    "editor.cursorLineOpacity": 0.5, // Defines opacity of cursor line highlight.
    "editor.cursorColumnOpacity": 0.5, // Defines opacity of cursor column highlight.
    "editor.fontFamily": "Iosevka Term Medium", // Editor font.
    "editor.textMateHighlighting.enabled": true, // TextMate highlighting.
    "editor.fontSize": "20pt", // Font size.
    "editor.fontLigatures": true, // Use ligatures in editor.
    "editor.quickOpen.execCommand": 'fzf', // FZF as default src to populate fuzzy finder.
    "editor.scrollBar.visible": false, // Hide scrollbar.
    "editor.errors.slideOnFocus": true, // Enables showing details when cursor is over an error.
    "oni.hideMenu": true, // Hide default menu, can be opened with <alt>.
    "oni.loadInitVim": true, // Load user's init.vim.
    "oni.useDefaultConfig": false, // Do not load Oni's init.vim.
    "oni.useExternalPopupMenu": false, // Use oni GUI popup menu.
    "statusbar.enabled": false, // Disable statusbar.
    "statusbar.fontSize": "16pt", // Statusbar fontsize.
    "tabs.mode": "native", // Tabs behave like vim.
    "tabs.wrap": true, // Wrap tabs.
    "tabs.height" : "1.2em", // Tabs height.
    "ui.animations.enabled": true, // Use animations.
    "ui.colorscheme": "neg", // My custom colorscheme.
    "ui.fontFamily": "Iosevka Term Medium", // GUI font family.
    "ui.fontSize": "14pt", // GUI font size.
    "ui.fontSmoothing": "auto", // Auto font smooth.
    "wildmenu.mode": false, // Do not override vim's native wildmenu UI.
    "learning.enabled": false, // Disable learning.
    "experimental.markdownPreview.enabled": false, // Experimental Markdown preview.
    "language.cpp.languageServer.arguments": ["-std=c++17"],

    // haskell support ( need haskell-ide-engine )
    "language.haskell.languageServer.command": "hi",
    "language.haskell.languageServer.arguments": ["--lsp"],
    "language.haskell.languageServer.rootFiles": [".git"],

    // Lua support ( need lua-lsp )
    "language.lua.languageServer.command": "lua-ls",
    "language.lua.languageServer.rootFiles": [".git"],

    "colors.background": "#000000",
    "colors.foreground": "#617287",

    "colors.title.background": "#1E2127",
    "colors.title.foreground": "#ABB2BF",

    "colors.editor.background": "#000000",
    "colors.editor.foreground": "#375BC1",

    "colors.tabs.background": "#282C34",
    "colors.tabs.foreground": "#ABB3BF",

    "colors.toolTip.background": "#000000",
    "colors.toolTip.foreground": "#617287", // like pmenu color
    "colors.toolTip.border": "#080820",

    "colors.menu.background": "#282C34",
    "colors.menu.foreground": "#ABB2BF",
    "colors.menu.border": "#080820",

    "colors.contextMenu.background": "#000000",
    "colors.contextMenu.foreground": "#ABB2BF",
    "colors.contextMenu.border": "#080820",
    "colors.contextMenu.highlight": "#1E2127",

    "colors.sidebar.background": "#1E2127",
    "colors.sidebar.foreground": "#ABB2BF",
    "colors.sidebar.active.background": "#282C34",
    "colors.sidebar.selection.border": "#080830",
    "colors.statusBar.background": "#000000",
    "colors.statusBar.foreground": "#617287",

    "colors.highlight.mode.insert.background": "#375BC1",
    "colors.highlight.mode.insert.foreground": "#282c34",
    "colors.highlight.mode.normal.background": "#375BC1",
    "colors.highlight.mode.normal.foreground": "#282c34",
    "colors.highlight.mode.operator.background": "#d19a66",
    "colors.highlight.mode.operator.foreground": "#282c34",
    "colors.highlight.mode.visual.background": "#56b6c2",
    "colors.highlight.mode.visual.foreground": "#282c34",

    "colors.editor.hover.title.background": '#000000',
    "colors.editor.hover.title.foreground": "#617287",
    "colors.editor.hover.border": "#395573",
    "editor.hover.contents.background": '#000000',
    "editor.hover.contents.foreground": "#617287",
    "editor.hover.contents.codeblock.background": '#000000',
    "editor.hover.contents.codeblock.foreground": "#617287",
}

