
// http://developer.mozilla.org/en/nsICookie
//   list of attributes on nsICookie
//
// http://developer.mozilla.org/en/nsICookieManager
//
// nsICookiePermission

/*
 * call callback with each cookie.
 */
function cookies_foreach (callback) {
    var cookieMgr = Cc["@mozilla.org/cookiemanager;1"]
        .getService(Ci.nsICookieManager);
    for (var e = cookieMgr.enumerator; e.hasMoreElements();) {
        callback(e.getNext().QueryInterface(Ci.nsICookie));
    }
}

/*
 * unconditionally delete all cookies.
 */
function cookies_remove_all () {
    Cc["@mozilla.org/cookiemanager;1"]
        .getService(Ci.nsICookieManager)
        .removeAll();
}

/*
 * call callback with each cookie.  if callback returns
 * true, keep the cookie.  if callback returns false,
 * delete the cookie.  careful with this one.
 */
function cookies_filter_destructive (callback) {
    var cookieman = Cc["@mozilla.org/cookiemanager;1"]
        .getService(Ci.nsICookieManager);
    for (var e = cookieman.enumerator; e.hasMoreElements();) {
        var c = e.getNext().QueryInterface(Ci.nsICookie);
        if (! callback(c)) {
            cookieman.remove(c.host, c.name, c.path, false);
        }
    }
}


/*

// print all google cookies
cookies_foreach (
    function (cookie) {
        if (cookie.host.indexOf("google") != -1) {
            dumpln(cookie.host + ";" + cookie.name + ";" + cookie.value);
        }
    });

// print all cookies
cookies_foreach (
    function (cookie) {
        dumpln(cookie.host + ";" + cookie.name + "=" + cookie.value);
    });

// destroy all google cookies
cookies_filter_destructive (
    function (cookie) {
        if (cookie.host.indexOf("google") == -1) {
            return true;
        } else {
            return false;
        }
    });

// print all cookies' hosts
cookies_foreach (
    function (cookie) {
        dumpln(cookie.host);
    });

*/

