require("noice").setup({
    cmdline={
        view="cmdline",
    },
    routes={
        {filter={event="msg_show", kind="", find="line less",},opts={skip=true},},
        {filter={event="cmdline", find="^%s*[/?]",}, view="cmdline",},
        {filter={event="msg_show", kind="", find="written",}, opts={skip=true},},
        {filter={event="msg_show", kind="", find="1 time",}, opts={skip=true},},
        {filter={event="msg_show", kind="", find="Nothing to repeat",}, opts={skip=true},},
        {filter={event="msg_show", kind="", find="more line",}, opts={skip=true},},
        {filter={event="msg_show", kind="", find="line yanked",}, opts={skip=true},},
    },
})
