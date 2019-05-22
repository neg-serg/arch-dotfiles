"use strict";
exports.__esModule = true;
exports.activate = function (oni) {
    console.log("config activated");
    oni.input.bind("<S-Insert>", "editor.clipboard.paste");
    oni.input.unbind("<c-p>");
    oni.input.unbind("<enter>");
    oni.input.unbind("<c-g>");
    oni.input.unbind("<c-/>");
    oni.input.bind("<s-c-g>", function () { return oni.commands.executeCommand("sneak.show"); });
};
exports.deactivate = function (oni) {
    console.log("config deactivated");
};
exports.configuration = {
    "autoClosingPairs.enabled": false,
    "commandline.icons": true,
    "sidebar.enabled": false,
    "commandline.mode": false,
    "notifications.enabled": true,
    "editor.completions.mode": "native",
    "editor.backgroundOpacity": 0.88,
    "editor.backgroundImageUrl": "/home/neg/pic/wl/art-celldweller-transmissions.jpg",
    "editor.cursorLine": false,
    "editor.cursorColumn": false,
    "editor.cursorLineOpacity": 0.5,
    "editor.cursorColumnOpacity": 0.5,
    "editor.clipboard.enabled": true,
    "editor.fontFamily": "Iosevka Term Medium",
    "editor.textMateHighlighting.enabled": true,
    "editor.fontSize": "20pt",
    "editor.fontLigatures": true,
    "editor.quickOpen.execCommand": "fzf",
    "editor.quickInfo.delay": 200,
    "editor.scrollBar.visible": false,
    "editor.errors.slideOnFocus": true,
    "editor.typingPrediction": false,
    "editor.imageLayerExtensions": [".gif", ".jpg", ".jpeg", ".bmp", ".png"],
    "oni.hideMenu": true,
    "oni.loadInitVim": true,
    "oni.useDefaultConfig": false,
    "oni.enhancedSyntaxHighlighting": true,
    "oni.useExternalPopupMenu": true,
    "statusbar.enabled": false,
    "tabs.mode": "native",
    "tabs.wrap": true,
    "tabs.height": "1.2em",
    "ui.animations.enabled": false,
    "ui.colorscheme": "n/a",
    "ui.fontFamily": "Iosevka, 'Segoe UI', Ubuntu, Cantarell, sans-serif",
    "ui.iconTheme": "theme-icons-seti",
    "ui.fontSize": "14pt",
    "ui.fontSmoothing": "antialiased",
    "wildmenu.mode": false,
    "learning.enabled": false,
    "browser.enabled": false,
    "browser.defaultUrl": "https://duckduckgo.com",
    "configuration.editor": "typescript",
    "experimental.sessions.enabled": false,
    "experimental.sessions.directory": null,
    "experimental.colorHighlight.enabled": false,
    "experimental.colorHighlight.filetypes": [".css", ".js", ".jsx", ".tsx", ".ts", ".re", ".sass",
        ".scss", ".less", ".pcss", ".sss", ".stylus", ".xml", ".svg",],
    "experimental.markdownPreview.enabled": false,
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
        ".ts": "/opt/oni/resources/app/extensions/typescript/syntaxes/TypeScript.tmLanguage.json",
        ".tsx": "/opt/oni/resources/app/extensions/typescript/syntaxes/TypeScriptReact.tmLanguage.json"
    },
    "language.lua.textMateGrammar": "/opt/oni/resources/app/extensions/lua/syntaxes/lua.tmLanguage.json",
    "language.clojure.textMateGrammar": "/opt/oni/resources/app/extensions/clojure/syntaxes/clojure.tmLanguage.json",
    "language.ruby.textMateGrammar": "/opt/oni/resources/app/extensions/ruby/syntaxes/ruby.tmLanguage.json",
    "language.swift.textMateGrammar": "/opt/oni/resources/app/extensions/swift/syntaxes/swift.tmLanguage.json",
    "language.rust.textMateGrammar": "/opt/oni/resources/app/extensions/rust/syntaxes/rust.tmLanguage.json",
    "language.php.textMateGrammar": "/opt/oni/resources/app/extensions/php/syntaxes/php.tmLanguage.json",
    "language.objc.textMateGrammar": {
        ".m": "/opt/oni/resources/app/extensions/objective-c/syntaxes/objective-c.tmLanguage.json",
        ".h": "/opt/oni/resources/app/extensions/objective-c/syntaxes/objective-c.tmLanguage.json"
    },
    "language.objcpp.textMateGrammar": {
        ".mm": "/opt/oni/resources/app/extensions/objective-c++/syntaxes/objective-c++.tmLanguage.json"
    },
    "language.python.textMateGrammar": "/opt/oni/resources/app/extensions/python/syntaxes/python.tmLanguage.json",
    "language.sh.textMateGrammar": "/opt/oni/resources/app/extensions/shell/syntaxes/shell.tmLanguage.json",
    "language.zsh.textMateGrammar": "/opt/oni/resources/app/extensions/shell/syntaxes/shell.tmLanguage.json",
    "language.markdown.textMateGrammar": {
        ".md": "/opt/oni/resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
        ".markdown": "/opt/oni/resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
        ".mkd": "/opt/oni/resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
        ".mdown": "/opt/oni/resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json"
    },
    "language.java.textMateGrammar": {
        ".java": "/opt/oni/resources/app/extensions/java/syntaxes/Java.tmLanguage.json",
        ".jar": "/opt/oni/resources/app/extensions/java/syntaxes/Java.tmLanguage.json"
    },
    "language.cs.textMateGrammar": "/opt/oni/resources/app/extensions/csharp/syntaxes/csharp.tmLanguage.json",
    "language.javascript.completionTriggerCharacters": [".", "/", "\\"],
    "language.javascript.textMateGrammar": {
        ".js": "/opt/oni/resources/app/extensions/javascript/syntaxes/JavaScript.tmLanguage.json",
        ".jsx": "/opt/oni/resources/app/extensions/javascript/syntaxes/JavaScriptReact.tmLanguage.json"
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
    "colors.toolTip.foreground": "#617287",
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
    "editor.hover.contents.codeblock.foreground": "#617287"
};
