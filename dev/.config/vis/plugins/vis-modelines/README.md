## vis-modelines

Vim's modelines are very useful for setting per-file settings in Vim.
For example, the filetype can't always be reliably inferred from the filename, i.e. for templates with generic file extensions or script files that omit the file extension altogether.

This Vis plugin tries to read standard Vim modelines and set the following (Vis) settings:

`autoindent`, `expandtab`, `numbers`, `tabwidth`, `syntax`.

Vim (by default) looks for modelines in the first 5 and last 5 lines of the file. This will emulate this behaviour, but omit the setting to change this threshold, as no sane person would change it (it would break everybody else's Vim).

This parser assumes you will only use *one* modeline per file, to avoid having to resolve conflicts. It will use the first modeline it finds from the top.

### Installation

Add the Lua file to you Vis path (`~/.config/vis`) and add this to your `visrc.lua`:
```
require("vis-modelines")
```
The settings from the modeline will be applied *after* Vis is initialized, with the `vis.events.START` event callback.

### Notes

The unit tests require the [busted](https://github.com/Olivine-Labs/busted) Lua unit testing framework.

### TODO

- [x] Write unit tests
