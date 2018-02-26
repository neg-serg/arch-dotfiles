// https://github.com/onivim/oni/wiki/Configuration

const activate = oni => {
    console.log("config activated")
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))
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
    "wildmenu.mode": false,
    "commandline.icons": true,
    "commandline.mode": false,
    "editor.backgroundImageUrl": "/home/neg/pic/wl/HeuanqL.jpg",
    "editor.backgroundOpacity": 0.9,
    "editor.completions.enabled": true,
    "editor.cursorLine": true,
    "editor.fontFamily": "Iosevka Term Medium",
    "editor.fontSize": "19pt",
    "editor.quickOpen.execCommand": true,
    "editor.scrollBar.visible": false,
    "oni.hideMenu": true,
    "oni.loadInitVim": true,
    "oni.useDefaultConfig": false, 
    "oni.useExternalPopupMenu": true,
    "statusbar.enabled": false,
    "statusbar.fontSize": "14pt",
    "tabs.mode": "hidden",
    "ui.animations.enabled": true,
    "ui.colorscheme": "neg",
    "ui.fontFamily": "Iosevka Term Medium",
    "ui.fontSize": "18pt",
    "ui.fontSmoothing": "auto",
}

