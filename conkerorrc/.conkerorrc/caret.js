// http://developer.mozilla.org/en/docs/DOM:Selection
//
// http://www.xulplanet.com/references/xpcomref/ifaces/nsISelectionController.html
//
// http://www.xulplanet.com/references/xpcomref/ifaces/nsISelection.html
//
// http://www.xulplanet.com/references/xpcomref/ifaces/nsIDOMRange.html
//

//session_pref('accessibility.browsewithcaret', true);

user_pref('ui.caretWidth', 2);
//add_hook('create_buffer_hook', caret_mode_enable);


/*



var buf = window_watcher.activeWindow.buffers.current;
var ds = window_watcher.activeWindow.buffers.current.doc_shell;

var selCon = ds
    .QueryInterface(Components.interfaces.nsIInterfaceRequestor)
    .getInterface(Components.interfaces.nsISelectionDisplay)
    .QueryInterface(Components.interfaces.nsISelectionController);

  selCon.setDisplaySelection(
    Components.interfaces.nsISelectionController.SELECTION_ON);

selCon.setCaretEnabled(true);
selCon.setCaretVisibilityDuringSelection(true);
selCon.setCaretReadOnly(false);

theSel = selCon.getSelection(Ci.nsISelectionController.SELECTION_NORMAL);
// theSel is now an nsISelection
var r = theSel.getRangeAt(0);
// r is an nsIDOMRange


// Select all STRONG elements in an HTML document
 var els = buf.browser.contentDocument.getElementsByTagName("a");
 var s = buf.window.getSelection();
 if(s.rangeCount > 0) s.removeAllRanges();
 for(var i = 0; i < els.length; i++) {
  var range = buf.browser.contentDocument.createRange();
  range.selectNode(els[i]);
  s.addRange(range);
 }

var els = buf.browser.contentDocument.getElementsByTagName("u");

*/
