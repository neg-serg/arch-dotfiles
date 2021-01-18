# Fuzzy find and open files in vis

Use [fzf](https://github.com/junegunn/fzf) to open files in [vis](https://github.com/martanne/vis).

## Usage

In vis:
- `:fzf`: search all files in the current sub-tree.
- You can pass arguments to fzf, e.g. : `:fzf -p !.class` 

## Configuration

In visrc.lua:

```lua
plugin_vis_open =require('plugins/vis-fzf-open/fzf-open')

-- Path to the fzf executable (default: "fzf")
plugin_vis_open.fzf_path = "fzf"

-- Arguments passed to fzf (defaul: "")
 plugin_vis_open.fzf_args = "-q '!.class '"
```

