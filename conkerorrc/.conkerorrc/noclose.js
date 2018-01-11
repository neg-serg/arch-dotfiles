add_hook("window_before_close_hook",
    function () {
        var w = get_recent_conkeror_window();
        var result = (w == null)
        if (result){
            ;;
        }
        yield co_return(result);
    });
