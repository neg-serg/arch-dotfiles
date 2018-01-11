
// google translate
//
function read_url_google_translate_handler (input) {
    var m = /^(\S+\|\S+)\s+(.*)/.exec(input);
    if (m)
        return "http://translate.google.com/#"+m[1]+"|"+m[2];
    return null;
}

// default webjump
//
read_url_handler_list = [
    read_url_google_translate_handler,
    read_url_make_default_webjump_handler("duckduckgo")];

function possibly_valid_url (str) {
    return /^\s*[^\/\s]*(\/|\s*$)/.test(str)
        && /[:\/\.]/.test(str);
}

/*
walnut_run({
    suite_setup: function () {
        this.original = conkeror.possibly_valid_url;
        conkeror.possibly_valid_url = function (str) {
            return /^\s*[^\/\s]*(\/|\s*$)/.test(str)
                && /[:\/\.]/.test(str);
        };
    },
    suite_teardown: function () {
        conkeror.possibly_valid_url = this.original;
    },
    test_alternative_possibly_valid_url_1: function () {
        assert_not(possibly_valid_url(""));
    },
    test_alternative_possibly_valid_url_2: function () {
        assert_not(possibly_valid_url("         "));
    },
    test_alternative_possibly_valid_url_3: function () {
        assert_not(possibly_valid_url("example"));
    },
    test_alternative_possibly_valid_url_4: function () {
        assert_not(possibly_valid_url("  example  "));
    },
    test_alternative_possibly_valid_url_5: function () {
        assert_not(possibly_valid_url("example foo"));
    },
    test_alternative_possibly_valid_url_6: function () {
        assert(possibly_valid_url("example/ foo"));
    },
    test_alternative_possibly_valid_url_7: function () {
        assert_not(possibly_valid_url("example /foo"));
    },
    test_alternative_possibly_valid_url_8: function () {
        assert(possibly_valid_url("/example foo"));
    },
    test_alternative_possibly_valid_url_9: function () {
        assert(possibly_valid_url(" /example foo"));
    },
    test_alternative_possibly_valid_url_10: function () {
        assert(possibly_valid_url(" ex/ample foo"));
    },
    test_alternative_possibly_valid_url_11: function () {
        assert(possibly_valid_url("/"));
    }
});
*/


// open multiple urls hack.  this lets you type multiple urls in the
// prompt, separated by spaces.  it's a horrible hack.
//
/*
function check_for_multi_url (input) {
    if (input.indexOf(", ") == -1)
        return null;
    var buffer = get_recent_conkeror_window().buffers.current;
    var urls = input.split(", ");
    var first = urls.shift();
    for each (let url in urls) {
        browser_object_follow(buffer, OPEN_NEW_BUFFER_BACKGROUND, url);
    }
    return first;
}
read_url_handler_list = [check_for_multi_url];
*/
