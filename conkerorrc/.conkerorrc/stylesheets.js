// interactive("toggle-stylesheets",
//             "Toggle whether conkeror uses style sheets (CSS) for the " +
//             "current buffer.  It is sometimes useful to turn off style " +
//             "sheets when the web site makes obnoxious choices.",
//             function(I) {
//   var s = I.buffer.document.styleSheets;
//   for (var i = 0; i < s.length; i++)
//     s[i].disabled = !s[i].disabled;
// });

// let (sheet = get_home_directory()) {
//     sheet.append(".conkerorrc");
//     sheet.append("stylesheets");
//     register_user_stylesheet(make_uri(sheet));
// }

// register_user_stylesheet(
//     make_css_data_uri(
//         ["@namespace url(http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul); browser { background-color: #222233 !important; }"]
//     )
// );
