function save_minibuffer_history () {
    var mr_json = Cc["@mozilla.org/dom/json;1"]
        .createInstance(Ci.nsIJSON);
    var str = mr_json.encode(minibuffer_history_data);
    write_text_file(make_file("~/conkeror-minibuffer-history.json"), str);
}

function load_minibuffer_history () {
    var mr_json = Cc["@mozilla.org/dom/json;1"]
        .createInstance(Ci.nsIJSON);
    var data = mr_json.decode(read_text_file(make_file("~/conkeror-minibuffer-history.json")));
    minibuffer_history_data = data;
}
