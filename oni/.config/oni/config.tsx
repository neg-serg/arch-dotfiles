import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    oni.input.bind("<S-Insert>", "editor.clipboard.paste")
    oni.input.unbind("<c-p>")
    oni.input.unbind("<enter>")
    oni.input.unbind("<c-g>")
    oni.input.bind("<s-c-g>", () => oni.commands.executeCommand("sneak.show"))
}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    "autoClosingPairs.enabled": false, // Disable oni's autoclosing pairs.
    "commandline.icons": true, // Commandline icons.
    "sidebar.enabled": false, // Disable sidebar.
    "commandline.mode": false, // Do not override commandline UI.
    "notifications.enabled": true,
    "editor.completions.mode": "native", // VSCode-like completion.
    "editor.backgroundOpacity": 0.88, // Dark enough.
    "editor.backgroundImageUrl":
    "/home/neg/pic/wl/art-celldweller-transmissions.jpg",
    "editor.cursorLine": false, // Disables cursor line highlight.
    "editor.cursorColumn": false, // Disables cursor column highlight.
    "editor.cursorLineOpacity": 0.5, // Defines opacity of cursor line highlight.
    "editor.cursorColumnOpacity": 0.5, // Defines opacity of cursor column highlight.
    "editor.clipboard.enabled": true,
    "editor.fontFamily": "Iosevka Term Medium", // Editor font.
    "editor.textMateHighlighting.enabled": true, // TextMate highlighting.
    "editor.fontSize": "20pt", // Font size.
    "editor.fontLigatures": true, // Use ligatures in editor.
    "editor.quickOpen.execCommand": "fzf", // FZF as default src to populate fuzzy finder.
    "editor.quickInfo.delay": 200,
    "editor.scrollBar.visible": false, // Hide scrollbar.
    "editor.errors.slideOnFocus": true, // Enables showing details when cursor is over an error.
    "editor.typingPrediction": false,

    "editor.imageLayerExtensions": [".gif", ".jpg", ".jpeg", ".bmp", ".png"],

    "oni.hideMenu": true, // Hide default menu, can be opened with <alt>.
    "oni.loadInitVim": true, // Load user's init.vim.
    "oni.useDefaultConfig": false, // Do not load Oni's init.vim.
    "oni.enhancedSyntaxHighlighting": true,
    "oni.useExternalPopupMenu": true, // Use oni GUI popup menu.
    "statusbar.enabled": false,
    "tabs.mode": "native", // Tabs behave like vim.
    "tabs.wrap": true, // Wrap tabs.
    "tabs.height": "1.2em", // Tabs height.
    "ui.animations.enabled": false, // Use animations.
    "ui.colorscheme": "n/a", // My custom colorscheme.

    "ui.fontFamily": "Iosevka, 'Segoe UI', Ubuntu, Cantarell, sans-serif", // GUI font family.
    "ui.iconTheme": "theme-icons-seti",
    "ui.fontSize": "14pt", // GUI font size.
    "ui.fontSmoothing": "antialiased", // Auto font smooth.

    "wildmenu.mode": false, // Do not override vim's native wildmenu UI.
    "learning.enabled": false, // Disable learning.
    "browser.enabled": false, // Disable browser

    "browser.defaultUrl": "https://duckduckgo.com",
    "configuration.editor": "typescript",
    "experimental.sessions.enabled": false,
    "experimental.sessions.directory": null,

    "experimental.colorHighlight.enabled": false,
    "experimental.colorHighlight.filetypes": [ ".css", ".js", ".jsx", ".tsx", ".ts", ".re", ".sass",
        ".scss", ".less", ".pcss", ".sss", ".stylus", ".xml", ".svg", ],

    "experimental.markdownPreview.enabled": false, // Experimental Markdown preview.
    "experimental.indentLines.enabled": true,
    "experimental.indentLines.skipFirst": true,

    // cpp
    "language.cpp.languageServer.arguments": ["-std=c++17"],

    // bash
    "language.bash.languageServer.command": "bash-language-server",
    "language.bash.languageServer.arguments": ["start"],

    // haskell support ( need haskell-ide-engine )
    "language.haskell.languageServer.command": "hi",
    "language.haskell.languageServer.arguments": ["--lsp"],
    "language.haskell.languageServer.rootFiles": [".git"],

    //------------------------------------------------------
    "language.typescript.textMateGrammar": {
    ".ts":
        "/opt/oni/resources/app/extensions/typescript/syntaxes/TypeScript.tmLanguage.json",
    ".tsx":
        "/opt/oni/resources/app/extensions/typescript/syntaxes/TypeScriptReact.tmLanguage.json",
    },
    "language.lua.textMateGrammar":
    "/opt/oni/resources/app/extensions/lua/syntaxes/lua.tmLanguage.json",
    "language.clojure.textMateGrammar":
    "/opt/oni/resources/app/extensions/clojure/syntaxes/clojure.tmLanguage.json",
    "language.ruby.textMateGrammar":
    "/opt/oni/resources/app/extensions/ruby/syntaxes/ruby.tmLanguage.json",
    "language.swift.textMateGrammar":
    "/opt/oni/resources/app/extensions/swift/syntaxes/swift.tmLanguage.json",
    "language.rust.textMateGrammar":
    "/opt/oni/resources/app/extensions/rust/syntaxes/rust.tmLanguage.json",
    "language.php.textMateGrammar":
    "/opt/oni/resources/app/extensions/php/syntaxes/php.tmLanguage.json",
    "language.objc.textMateGrammar": {
    ".m":
        "/opt/oni/resources/app/extensions/objective-c/syntaxes/objective-c.tmLanguage.json",
    ".h":
        "/opt/oni/resources/app/extensions/objective-c/syntaxes/objective-c.tmLanguage.json",
    },
    "language.objcpp.textMateGrammar": {
    ".mm":
        "/opt/oni/resources/app/extensions/objective-c++/syntaxes/objective-c++.tmLanguage.json",
    },
    "language.python.textMateGrammar":
    "/opt/oni/resources/app/extensions/python/syntaxes/python.tmLanguage.json",
    "language.sh.textMateGrammar":
    "/opt/oni/resources/app/extensions/shell/syntaxes/shell.tmLanguage.json",
    "language.zsh.textMateGrammar":
    "/opt/oni/resources/app/extensions/shell/syntaxes/shell.tmLanguage.json",
    "language.markdown.textMateGrammar": {
    ".md":
        "/opt/oni/resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
    ".markdown":
        "/opt/oni/resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
    ".mkd":
        "/opt/oni/resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
    ".mdown":
        "/opt/oni/resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
    },
    "language.java.textMateGrammar": {
    ".java":
        "/opt/oni/resources/app/extensions/java/syntaxes/Java.tmLanguage.json",
    ".jar":
        "/opt/oni/resources/app/extensions/java/syntaxes/Java.tmLanguage.json",
    },
    "language.cs.textMateGrammar":
    "/opt/oni/resources/app/extensions/csharp/syntaxes/csharp.tmLanguage.json",
    "language.javascript.completionTriggerCharacters": [".", "/", "\\"],
    "language.javascript.textMateGrammar": {
    ".js":
        "/opt/oni/resources/app/extensions/javascript/syntaxes/JavaScript.tmLanguage.json",
    ".jsx":
        "/opt/oni/resources/app/extensions/javascript/syntaxes/JavaScriptReact.tmLanguage.json",
    },
    //------------------------------------------------------

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

    "colors.editor.hover.title.background": "#000000",
    "colors.editor.hover.title.foreground": "#617287",
    "colors.editor.hover.border": "#395573",
    "editor.hover.contents.background": "#000000",
    "editor.hover.contents.foreground": "#617287",
    "editor.hover.contents.codeblock.background": "#000000",
    "editor.hover.contents.codeblock.foreground": "#617287",
}
