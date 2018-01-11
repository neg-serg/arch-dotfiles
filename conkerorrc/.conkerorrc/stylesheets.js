interactive("toggle-stylesheets",
            "Toggle whether conkeror uses style sheets (CSS) for the " +
            "current buffer.  It is sometimes useful to turn off style " +
            "sheets when the web site makes obnoxious choices.",
            function(I) {
  var s = I.buffer.document.styleSheets;
  for (var i = 0; i < s.length; i++)
    s[i].disabled = !s[i].disabled;
});
