// user agent
var user_agents = {
    "conkeror": null,
    "ipad": "Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 " +
        "(KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25",
    "iphone": "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; " +
        "en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 " +
        "Mobile/8A293 Safari/6531.22.7",
    "linux-chromium": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36" +
        "(KHTML, like Gecko) Chrome/41.0.2228.0 Safari/4E423F",
    "linux-palemoon": "Mozilla/5.0 (X11; Linux x86_64; rv:52.9) Gecko/20100101 Goanna/3.4 Firefox/52.9 PaleMoon/27.6.2",
    "linux-yabrowser" : "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 YaBrowser/17.10.1.1202 (beta) Yowser/2.5 Safari/537.36"
};

// user agent (via escondida via retroj)
interactive("user-agent",
            "Pick a user agent from the list of presets",
            function (I) {
                var ua = (yield I.window.minibuffer.read_object_property(
                    $prompt = "Agent:",
                    $object = user_agents));
                set_user_agent(user_agents[ua]);
            });

set_user_agent(user_agents["linux-palemoon"]);
