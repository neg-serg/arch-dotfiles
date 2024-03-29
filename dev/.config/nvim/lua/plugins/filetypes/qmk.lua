-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ codethread/qmk.nvim                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'codethread/qmk.nvim', -- qmk ft
    config=function()
        qmk.setup {
            name='LAYOUT_preonic_grid', -- identify your layout name
            layout = {
                "x x x x x x _ _ x x x x x x",
                "x x x x x x _ _ x x x x x x",
                "x x x x x x x^x x x x x x x",
                "_ _ _ x x x x x x x x _ _ _",
            },
            comment_preview = {
                keymap_overrides = {
                    ["&trans"] = "",
                    ["&sys_reset"] = "🔄",
                    ["&bootloader"] = "💾",
                    SEMI = ";",
                    FSLH = "/",
                    BSLH = "\\",
                    LBKT = "[",
                    RBKT = "]",
                    LBRC = "{",
                    RBRC = "}",
                    SQT = "'",
                    EXCL = "!",
                    PRCNT = "%",
                    CARET = "^",
                    C_NEXT = "⏭️",
                    C_PREV = "⏮️",
                    C_PP = "⏯️",
                    BT_NXT = "🛜🔼",
                    BT_PRV = "🛜🔽",
                    BT_CLR = "🛜❌",
                    C_MUTE = "🔇",
                    C_VOL_DN = "🔉",
                    C_VOL_UP = "🔊",
                    C_BRI_UP = "🔆",
                    C_BRI_DN = "🔅",
                    EP_TOG = "🔌",
                    AMPS = "&",
                    STAR = "*",
                    LPAR = "(",
                    RPAR = ")",
                    MEH = "MEH",
                    K_UNDO = "↩️",
                    ["COPY"] = "📄",
                    ["PASTE"] = "📋",
                    ["CUT"] = "✂️",
                    ["LG(Q)"] = "⌘Q",
                    ["LC(W)"] = "⌃W",
                    ["LC(T)"] = "⌃T",
                    ["LC(TAB)"] = "⌃⇥",
                    ["LS(LC(TAB))"] = "⇧⌃⇥",
                    SPACE = "SPACE",
                    KP_MULTIPLY = "*",
                    -- use MENU as compose key
                    K_CMENU = "🌍",
                    K_MENU = "🌍",
                    COMPOSE = "🌍",
                    LEFT = "←",
                    RIGHT = "→",
                    UP = "↑",
                    DOWN = "↓",
                    KP_PLUS = "+",
                    DQT = '"',
                    PG_UP = "⇞",
                    PG_DN = "⇟",
                    HOME = "⇱",
                    END = "⇲",
                    _LTX = "",
                    _LMX = "",
                    _LBX = "",
                    _LHX = "",
                    _RTX = "",
                    _RMX = "",
                    _RBX = "",
                    _RHX = "",
                    _MTX = "",
                    _MMX = "",
                    _MBX = "",
                    _MHX = "",
                },
                symbols = {
                    tl = "╭",
                    tr = "╮",
                    bl = "╰",
                    br = "╯",
                },
            },
        }
    end, ft='dts', lazy=true
}

