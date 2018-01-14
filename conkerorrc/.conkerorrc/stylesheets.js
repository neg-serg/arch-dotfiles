site_css_dir = "/home/neg/.dotfiles/conkerorrc/.conkerorrc/css/";

function site_css(filename, url_prefixes) {
    var styles = read_text_file(make_file(site_css_dir+filename+".css"));
    var stylesheet = make_css_data_uri([styles]);
    register_user_stylesheet(stylesheet);
    interactive("toggle-"+filename,"", function() {
                    unregister_user_stylesheet(stylesheet);
                });
}

site_css("vk"    ,["https://vk.com"]);
