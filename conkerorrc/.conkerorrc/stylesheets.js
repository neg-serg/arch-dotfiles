// conkerorrc_dir = get_pref('conkeror.rcfile');
site_css_dir = conkerorrc_dir + "/home/neg/.dotfiles/conkerorrc/.conkerorrc/css/";

function site_css(filename, url_prefixes) {
    var styles = read_text_file(make_file(site_css_dir+filename+".css"));
    var stylesheet = make_css_data_uri([styles], $url_prefixes = url_prefixes);
    register_user_stylesheet(stylesheet);
    interactive("toggle-"+filename,"", function() {
                    unregister_user_stylesheet(stylesheet);
                });
}

site_css("vk"    ,["https://vk.com"]);
// site_css("hacker-news"    ,["http://news.ycombinator.com"]);
// site_css("mobile-twitter" ,["https://mobile.twitter.com"]);
// site_css("facebook"       ,["https://www.facebook.com"]);
// site_css("moodle-iie" ,["http://iie.fing.edu.uy/cursos"]);

