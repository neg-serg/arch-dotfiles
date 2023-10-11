const actions = {};
const util = {};
const {
    Clipboard,
    Front,
    Hints,
    Visual,
    Normal,
} = api;

function dbg(s) { console.log("[megakeys]: " + s); }
function swapKeys(key1, key2, mode="map", mode_remove="unmap") {
  api[mode]("temp", key1);
  api[mode](key1, key2);
  api[mode](key2, key1);
  api[mode_remove]("temp");
}

settings.hintAlign = "left";
settings.defaultSearchEngine = "g"; // (b)rave, (n)eeva, etc
settings.smoothScroll = false;
settings.cursorAtEndOfInput = true; // Input box true
settings.blocklistPattern = /mail.google.com/;
settings.modeAfterYank = "Normal";
settings.scrollStepSize = 100;
settings.omnibarPosition = "bottom";
settings.hintAlign = "left";

// -- [ HINTS ]
Hints.characters = "qwertasdfgzxcvb";
Hints.style(`
    font-family: 'Iosevka', 'SF Pro', monospace;
    font-size: 14px;
    font-weight: bold;
    text-transform: lowercase;
    color: #E5E9F0 !important;
    background: #3B4252 !important;
    border: solid 1px #4C566A !important;
    text-align: center;
    padding: 5px;
    line-height: 1;
`);

Hints.style(`
    font-family: 'Iosevka', monospace;
    font-size: 14px;
    font-weight: bold;
    text-transform: lowercase;
    color: #E5E9F0 !important;
    background: #6272a4 !important;
    border: solid 2px #4C566A !important;
    text-align: center;
    padding: 5px;
    line-height: 1;
  `, "text"
);

let videoKeys = ["v", "s", "d", "h", "l", "r"]; //Video Speed Controller Keys
let youtubeKeys = ["i", "f", "c", "0"];
let blockSites = ["netflix.com", "youtube.com", ".*dizi.*", ".*film.*", ".*anime.*", "udemy.com"];

const leaderKey = ",";
const alt_key = (key) => leaderKey + key;
// `map` handles bad domain
const key = (newKey, oldKey, domain) => {
  if (newKey) {
    api.map(newKey, oldKey, domain);
  }
  api.unmap(oldKey);
};

let videoBlockedKeys = new RegExp(blockSites.join("|"), "i");
let youtubeBlockedKeys = new RegExp(blockSites.join("|"), "i");

videoKeys.forEach((i) => api.map(alt_key(i), i, videoBlockedKeys));
youtubeKeys.forEach((i) => api.map(alt_key(i), i, youtubeBlockedKeys));

videoKeys.forEach((i) => api.unmap(i, videoBlockedKeys));
youtubeKeys.forEach((i) => api.unmap(i, youtubeBlockedKeys));

key(";o", "<Ctrl-6>");

swapKeys("o", "t");
swapKeys("x", "d");

swapKeys(";u", ";U");
swapKeys("P", "p");
api.vunmap("p");
api.map("H", "S");
api.map("L", "D");
api.map("F", "gf"); // open link in new tab
// api.map("<Ctrl-f>", "d");
// api.map("<Ctrl-b>", "e");

api.unmap("<Alt-p>"); // pin/unpin current tab
api.unmap("<Alt-m>"); // mute/unmute current tab

api.unmap("C")
api.unmap("<Ctrl-h>");
api.unmap("<Ctrl-i>")
api.unmap("<Ctrl-j>");
api.unmap("e")
api.unmap(";m")
api.unmap("P");
api.unmap("w")
api.unmap("b")

api.map("e", "<C-Tab>");
api.map("E", "<C-Shift-Tab>");

api.imap("<Ctrl-[>", "<Esc>");
api.imap("<Ctrl-c>", "<Esc>");
api.cmap("<Ctrl-[>", "<Esc>");
api.cmap("<Ctrl-c>", "<Esc>");

api.mapkey(';i', 'Copy src URL of an image', function() {
    Hints.create('img[src]',(element, event) =>  {
        api.Clipboard.write(element.src);
    });
});

api.mapkey(';mi', 'Copy multiple link URLs to the clipboard', function() {
    let linksToYank = [];
    Hints.create('img[src]', function(element) {
        linksToYank.push(element.src);
        api.Clipboard.write(linksToYank.join('\n'));
    }, {multipleHits: true});
});

api.mapkey(';n', 'Go to next episode',
   function next_episode(){
       base_url = window.location.href
       ep_no = base_url.match(/(\d+)(?!.*\d)/)[0];
       new_ep = parseInt(ep_no, 10) + 1;
       n = base_url.lastIndexOf(ep_no);
       new_url = base_url.slice(0, n) + base_url.slice(n).replace(ep_no, new_ep);
       window.location = new_url;
});

api.mapkey(";c", "Copy title and url for org mode", () => {
  let url = document.URL;
  let title = document.title;
  api.Clipboard.write(`[[${url}][${title}]]`);
});

const showCurrentTrainingBindings = () => {
    const messages = [...mouse, ...tabs].map(row => ( {
            binding: row[0].slice(1, -1),
            description: row[1]
        }))
        .map(obj => `${obj.binding}\t\t\t\t${obj.description}`)
    Front.showPopup(`<h1>${messages.join('<br>')} </h1>`);
}
api.mapkey(";?", "Show currently training keybindings", showCurrentTrainingBindings);

api.mapkey("ec", "GitHub Clone Repo (HTTPS)",
  () => {
    const gitURL = `${document.URL}.git`;
    const terminalCommand = `git clone ${gitURL}`;
    api.Clipboard.write(terminalCommand);
  },
  { domain: /github.com/i }
);

api.aceVimMap(",w", ":w", "normal");
api.aceVimMap(",q", ":q", "normal");
api.aceVimMap("kj", "<Esc>", "insert");
api.aceVimMap("<C-c>", "<Esc>", "insert");
api.vmapkey("<Ctrl-c>", "#9Exit visual mode", function () { Visual.exit(); });
api.vmapkey("<Ctrl-[>", "#9Exit visual mode", function () {
  if (Visual.state > 1) {
    Visual.hideCursor();
    Visual.selection.collapse(selection.anchorNode, selection.anchorOffset);
    Visual.showCursor();
  } else {
    Visual.visualClear();
    Visual.exit();
  }
  Visual.state--;
  Visual._onStateChange();
});

Visual.style(
    "marks",
    "background-color: #A3BE8C; border: 1px solid #3B4252 !important; text-decoration: underline;"
);
Visual.style(
    "cursor",
    "background-color: #E5E9F0 !important; border: 1px solid #6272a4 !important; border-bottom: 2px solid green !important; padding: 2px !important; outline: 1px solid rgba(255,255,255,.75) !important;"
);

// set theme
settings.theme = `
  :root {
    --font: "Iosevka", Arial, sans-serif;
    --font-size: 16px;
    --font-weight: bold;
    --fg: #E5E9F0;
    --bg: #3B4252;
    --bg-dark: #2E3440;
    --border: #4C566A;
    --main-fg: #88C0D0;
    --accent-fg: #A3BE8C;
    --info-fg: #5E81AC;
    --select: #4C566A;
    --orange: #D08770;
    --red: #BF616A;
    --yellow: #EBCB8B;
  }
  /* ---------- Generic ---------- */
  .sk_theme {
  background: var(--bg);
  color: var(--fg);
    background-color: var(--bg);
    border-color: var(--border);
    font-family: var(--font);
    font-size: var(--font-size);
    font-weight: var(--font-weight);
  }
  input {
    font-family: var(--font);
    font-weight: var(--font-weight);
  }

  div.surfingkeys_cursor {
    background-color: #0642CE;
    color: red;
  }
  .sk_theme tbody {
    color: var(--fg);
  }
  .sk_theme input {
    color: var(--fg);
  }
  /* Hints */
  #sk_hints .begin {
    color: var(--accent-fg) !important;
  }
  #sk_tabs .sk_tab {
    background: var(--bg-dark);
    border: 1px solid var(--border);
  }
  #sk_tabs .sk_tab_title {
    color: var(--fg);
  }
  #sk_tabs .sk_tab_url {
    color: var(--main-fg);
  }
  #sk_tabs .sk_tab_hint {
    background: var(--bg);
    border: 1px solid var(--border);
    color: var(--accent-fg);
  }
  .sk_theme #sk_frame {
    background: var(--bg);
    opacity: 0.2;
    color: var(--accent-fg);
  }

  /* ---------- Omnibar ---------- */
  /* Uncomment this and use settings.omnibarPosition = 'bottom' for Pentadactyl/Tridactyl style bottom bar */
  /* .sk_theme#sk_omnibar {
    width: 100%;
    left: 0;
  } */
  .sk_theme .title {
    color: var(--accent-fg);
  }
  .sk_theme .url {
    color: var(--main-fg);
  }
  .sk_theme .annotation {
    color: var(--accent-fg);
  }
  .sk_theme .omnibar_highlight {
    color: var(--accent-fg);
  }
  .sk_theme .omnibar_timestamp {
    color: var(--info-fg);
  }
  .sk_theme .omnibar_visitcount {
    color: var(--accent-fg);
  }
  .sk_theme #sk_omnibarSearchResult ul li .url {
    font-size: calc(var(--font-size) - 2px);
  }
  .sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: var(--border);
    padding: 5px;
  }
  .sk_theme #sk_omnibarSearchResult ul li:nth-child(even) {
    background: var(--border);
    padding: 5px;
  }
  .sk_theme #sk_omnibarSearchResult ul li.focused {
    background: var(--bg-dark);
    border-left: 2px solid var(--orange);
    padding: 5px;
    padding-left: 15px;
  }
  .sk_theme #sk_omnibarSearchArea {
    border-top-color: var(--border);
    border-bottom-color: transparent;
    margin: 0;
    padding: 5px 10px;
  }
  .sk_theme #sk_omnibarSearchArea:before {
    content: "󱋤";
    display: inline-block;
    margin-left: 5px;
    font-size: 22px;
  }
  .sk_theme #sk_omnibarSearchArea input,
  .sk_theme #sk_omnibarSearchArea span {
    font-size: 20px;
    padding:10px 0;
  }
  .sk_theme #sk_omnibarSearchArea .prompt {
    text-transform: uppercase;
    padding-left: 10px;
  }
  .sk_theme #sk_omnibarSearchArea .prompt:after {
    content: "";
    display: inline-block;
    margin-right: 5px;
    color: var(--accent-fg);
  }
  .sk_theme #sk_omnibarSearchArea .separator {
    color: var(--bg);
    display: none;
  }
  .sk_theme #sk_omnibarSearchArea .separator:after {
    content: "";
    display: inline-block;
    margin-right: 5px;
    color: var(--accent-fg);
  }

  /* ---------- Popup Notification Banner ---------- */
  #sk_banner {
    font-family: var(--font);
    font-size: var(--font-size);
    font-weight: var(--font-weight);
    background: var(--bg);
    border-color: var(--border);
    color: var(--fg);
    opacity: 0.9;
  }

  /* ---------- Popup Keys ---------- */
  #sk_keystroke {
    background-color: var(--bg);
  }
  .sk_theme kbd .candidates {
    color: var(--info-fg);
  }
  .sk_theme span.annotation {
    color: var(--accent-fg);
  }

  /* ---------- Popup Translation Bubble ---------- */
  #sk_bubble {
    background-color: var(--bg) !important;
    color: var(--fg) !important;
    border-color: var(--border) !important;
  }
  #sk_bubble * {
    color: var(--fg) !important;
  }
  #sk_bubble div.sk_arrow div:nth-of-type(1) {
    border-top-color: var(--border) !important;
    border-bottom-color: var(--border) !important;
  }
  #sk_bubble div.sk_arrow div:nth-of-type(2) {
    border-top-color: var(--bg) !important;
    border-bottom-color: var(--bg) !important;
  }

  /* ---------- Search ---------- */
  #sk_status,
  #sk_find {
    font-size: var(--font-size);
    border-color: var(--border);
  }
  .sk_theme kbd {
    background: var(--bg-dark);
    border-color: var(--border);
    box-shadow: none;
    color: var(--fg);
  }
  .sk_theme .feature_name span {
    color: var(--main-fg);
  }

  /* ---------- ACE Editor ---------- */
  #sk_editor {
    background: var(--bg-dark) !important;
    height: 50% !important;
    /* Remove this to restore the default editor size */
  }
  .ace_dialog-bottom {
    border-top: 1px solid var(--bg) !important;
  }
  .ace-chrome .ace_print-margin,
  .ace_gutter,
  .ace_gutter-cell,
  .ace_dialog {
    background: var(--bg) !important;
  }
  .ace-chrome {
    color: var(--fg) !important;
  }
  .ace_gutter,
  .ace_dialog {
    color: var(--fg) !important;
  }
  .ace_cursor {
    color: var(--fg) !important;
  }
  .normal-mode .ace_cursor {
    background-color: var(--fg) !important;
    border: var(--fg) !important;
    opacity: 0.7 !important;
  }
  .ace_marker-layer .ace_selection {
    background: var(--select) !important;
  }
  .ace_editor,
  .ace_dialog span,
  .ace_dialog input {
    font-family: var(--font);
    font-size: var(--font-size);
    font-weight: var(--font-weight);
  }

  /* Disable RichHints CSS animation */
  .expandRichHints {
      animation: 0s ease-in-out 1 forwards expandRichHints;
  }
  .collapseRichHints {
      animation: 0s ease-in-out 1 forwards collapseRichHints;
  }
  `;

api.mapkey("gH", "tmp", () => {
  location.href = `
  org-protocol://roam-ref?template=r&ref=
  ${encodeURIComponent(location.href)}
  &title=
  ${encodeURIComponent(document.title)}
  &body=
  ${encodeURIComponent(window.getSelection())}
`;
});

api.Hints.style("padding: 1px; color:#efe1eb; background: none; background-color: #b16286; font-size: 14px;");

api.Hints.style(
  "div{color:#efe1eb; background: none; background-color: #a73a1e;} div.begin{color:#ea6962; font-size: 0.9em;}",
  "text");

////////////////////////////////////////////////////////////////
// github default shortcut lists                              //
// https:help.github.com/articles/using-keyboard-shortcuts/   //
////////////////////////////////////////////////////////////////
const mapkeyGithub = (...args) => api.mapkey(...args, { domain: /github\.com/i });
mapkeyGithub("yp", "Copy project path", () => {
  const path = new URL(window.location.href).pathname.split("/");
  Clipboard.write(`${path[1]}/${path[2]}`);
});
mapkeyGithub("ygh", "Copy project path", () => {
  const path = new URL(window.location.href).pathname.split("/");
  Clipboard.write(`${path[1]}/${path[2]}`);
});
mapkeyGithub("ygc", "git clone - git clone address", () =>
  Clipboard.write("git clone " + window.location.href + ".git")
);
mapkeyGithub("yv", "Copy for vim", () => {
  const path = new URL(window.location.href).pathname.split("/");
  Clipboard.write(`use({"${path[1]}/${path[2]}"})`);
});
mapkeyGithub(";gC", "Go to the code tab", () => {
  document
    .querySelectorAll(".js-selected-navigation-item.reponav-item")[0]
    .click();
});
mapkeyGithub(";gI", "Go to the Issues tab", () => {
  document
    .querySelectorAll(".js-selected-navigation-item.reponav-item")[1]
    .click();
});
mapkeyGithub(";gP", "Go to the Pull requests tab", () => {
  document
    .querySelectorAll(".js-selected-navigation-item.reponav-item")[2]
    .click();
});
mapkeyGithub(";gB", "Go to the Projects tab", () => {
  document
    .querySelectorAll(".js-selected-navigation-item.reponav-item")[3]
    .click();
});
mapkeyGithub(";gW", "Go to the Wiki tab", () => {
  document
    .querySelectorAll(".js-selected-navigation-item.reponav-item")[4]
    .click();
});
mapkeyGithub(";gO", "Go to the Overview tab", () => {
  document.querySelectorAll(".UnderlineNav-item")[0].click();
});
mapkeyGithub(";gR", "Go to the Repository tab", () => {
  document.querySelectorAll(".UnderlineNav-item")[1].click();
});
mapkeyGithub(";gS", "Go to the Stars tab", () => {
  document.querySelectorAll(".UnderlineNav-item")[2].click();
});
