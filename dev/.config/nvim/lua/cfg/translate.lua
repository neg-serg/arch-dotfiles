require("pantran").setup{
    default_engine="yandex",
    engines={yandex={default_source="auto", default_target="ru"}},
    controls={mappings={edit={n={["j"]="gj", ["k"]="gk"}}}}
}
