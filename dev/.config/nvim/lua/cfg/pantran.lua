-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ potamides/pantran.nvim                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, pantran = pcall(require, 'pantran')
if (not status) then return end
pantran.setup{
    default_engine="yandex",
    engines={
        yandex={default_target="ru"}
    },
    controls={mappings={
        edit={n={["j"]="gj", ["k"]="gk"}}
    }},
    ui={width_percentage=0.8, height_percentage=0.8},
}
