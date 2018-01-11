session_pref("browser.enable_automatic_image_resizing", false);
session_pref("image.animation_mode", "normal"); // default is "normal"

interactive("toggle-animation-mode", null,
    function (I) {
        if (get_pref("image.animation_mode") == "normal") {
            session_pref("image.animation_mode", "none");
            I.minibuffer.message("Animations off");
        } else {
            session_pref("image.animation_mode", "normal");
            I.minibuffer.message("Animations on");
        }
    });
