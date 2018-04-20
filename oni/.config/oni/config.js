// https://github.com/onivim/oni/wiki/Configuration
const activate = oni => {
    oni.input.unbind("<c-p>");
    oni.input.bind("<f8>", "markdown.togglePreview");
    oni.input.bind(["<enter>", "<tab>"], "contextMenu.select");
    oni.input.bind("<c-enter>", () => oni.recorder.takeScreenshot());
}

module.exports = {
    activate,
    "autoClosingPairs.enabled": false, // Disable oni's autoclosing pairs.
    "commandline.icons": true, // Commandline icons.
    "sidebar.enabled": false, // Disable sidebar.
    "commandline.mode": false, // Do not override commandline UI.
    "editor.backgroundImageUrl": "/home/neg/pic/wl/wallpaper-2519516.jpg",
    "editor.backgroundOpacity": 0.88, // Dark enough.
    "editor.completions.mode": 'oni', // VSCode-like completion.
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
    "experimental.markdownPreview.enabled": true, // Experimental Markdown preview.
}

