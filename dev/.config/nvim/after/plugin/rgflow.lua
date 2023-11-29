require("rgflow").setup({
    default_trigger_mappings=true,
    default_ui_mappings=true,
    default_quickfix_mappings=true,
    cmd_flags=("--smart-case -g *.{*,py} -g !*.{min.js,pyc} --fixed-strings --no-fixed-strings --no-ignore -M 500"
    .. " -g !**/.angular/"
    .. " -g !**/node_modules/"
    .. " -g !**/static/*/jsapp/"
    .. " -g !**/static/*/wcapp/"
    ) })
