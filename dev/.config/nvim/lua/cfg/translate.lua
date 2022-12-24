local status, pantran = pcall(require, 'pantran')
if (not status) then return end
pantran.setup{
    default_engine="yandex",
    engines={yandex={default_source="auto", default_target="ru"}},
    controls={mappings={edit={n={["j"]="gj", ["k"]="gk"}}}}
}
