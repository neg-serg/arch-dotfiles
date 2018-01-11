
function jjf_title_format_fn (window) {
    var prefix = '['+get_current_profile()+' '+window.tag+'] ';
    if (window.buffers.current instanceof download_buffer)
        prefix = "*download* "+prefix;
    else if (window.buffers.current instanceof special_buffer)
        prefix = "*special* "+prefix;
    return prefix + window.buffers.current.title;
}

title_format_fn = jjf_title_format_fn;

// download_buffer.prototype.update_title = function () { return false; }
download_buffer_min_update_interval = 10000;

