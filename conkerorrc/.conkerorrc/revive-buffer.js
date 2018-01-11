var kill_buffer_original = kill_buffer_original || kill_buffer;
var killed_buffer_urls = [];
var killed_buffer_histories = [];

//  remember_killed_buffer
kill_buffer = function (buffer, force) {
    var hist = buffer.web_navigation.sessionHistory;

    if (buffer.display_uri_string && hist) {
        killed_buffer_histories.push(hist);
        killed_buffer_urls.push(buffer.display_uri_string);
    }

    kill_buffer_original(buffer,force);
};

interactive("revive-buffer",
    "Loads url from a previously killed buffer",
    function restore_killed_buffer (I) {
        if (killed_buffer_urls.length !== 0) {
            var url = yield I.minibuffer.read(
                $prompt = "Restore killed url:",
                $completer = new all_word_completer($completions = killed_buffer_urls),
                $default_completion = killed_buffer_urls[killed_buffer_urls.length - 1],
                $auto_complete = "url",
                $auto_complete_initial = true,
                $auto_complete_delay = 0,
                $require_match = true);

            var window = I.window;
            var creator = buffer_creator(content_buffer);
            var idx = killed_buffer_urls.indexOf(url);

            // Create the buffer
            var buf = creator(window, null);

            // Recover the history
            buf.web_navigation.sessionHistory = killed_buffer_histories[idx];

            // This line may seem redundant, but it's necessary.
            var original_index = buf.web_navigation.sessionHistory.index;
            buf.web_navigation.gotoIndex(original_index);

            // Focus the new tab
            window.buffers.current = buf;

            // Remove revived from cemitery
            killed_buffer_urls.splice(idx,1);
            killed_buffer_histories.splice(idx,1);
        } else {
            I.window.minibuffer.message("No killed buffer urls");
        }
    });

