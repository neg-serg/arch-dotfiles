// https://github.com/onivim/oni/wiki/Configuration

const activate = oni => {
    console.log("config activated")
    oni.input.unbind("<c-p>")
    oni.input.bind("<f8>", "markdown.togglePreview")
    oni.commands.executeCommand("sidebar.toggle")
}

const deactivate = () => {
    console.log("config deactivated")
}

module.exports = {
    activate,
    deactivate,
    "autoClosingPairs.enabled": false, // disable autoclosing pairs
    "commandline.icons": true,
    "commandline.mode": false, // Do not override commandline UI
    "editor.backgroundImageUrl": "/home/neg/pic/wl/Path_of_Exile_Wallpaper_18.jpg",
    "editor.backgroundOpacity": 0.88,
    "editor.completions.enabled": true,
    "editor.cursorLine": true,
    "editor.fontFamily": "Iosevka Term Medium",
    "editor.fontSize": "20pt",
    "editor.quickOpen.execCommand": false,
    "editor.scrollBar.visible": false,
    "oni.hideMenu": true, // Hide default menu, can be opened with <alt>
    "oni.loadInitVim": true, // Load user's init.vim
    "oni.useDefaultConfig": false, // Do not load Oni's init.vim
    "oni.useExternalPopupMenu": true,
    "statusbar.enabled": false, // Disable statusbar
    "statusbar.fontSize": "16pt", // Statusbar fontsize
    "tabs.mode": "native", // tabs behave like vim
    "tabs.wrap": true, // wrap tabs
    "tabs.height" : "1.2em",
    "ui.animations.enabled": true,
    "ui.colorscheme": "neg",
    "ui.fontFamily": "Iosevka Term Medium",
    "ui.fontSize": "18pt",
    "ui.fontSmoothing": "auto",
    "wildmenu.mode": false, // Do not override wildmenu UI
}

