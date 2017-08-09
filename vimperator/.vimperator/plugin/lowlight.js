/**
 * Copyright (c) 2010 - 2013 by Eric Van Dewoestine
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * Plugin which darkens the current web page for low light conditions.
 *
 * Usage:
 *   :lowlight
 *
 * Configuration:
 *   The following configuration settings can be overridden in your vimperatorrc file like so:
 *     javascript lowlightBackground = "#444"
 *     ...
 *
 *   lowlightBackground (default: #222):
 *     The background color.
 *
 *   lowlightForground (default: #bababa):
 *     The forground color.
 *
 *   lowlightInputBackground (default: #777):
 *     The input background color.
 *
 *   lowlightInputForground (default: #111):
 *     The input forground color.
 *
 *   lowlightBorder (default: #555):
 *     The border color.
 *
 *   lowlightLinkColor (default: #5d96b7):
 *     The link/href color.
 *
 *   lowlightLinkVisitedColor (default: #426a82):
 *     The link/href color.
 *
 * @version 0.1
 */

function LowLight() {
  if (typeof(lowlightBackground) === 'undefined'){
    lowlightBackground = '#222';
  }

  if (typeof(lowlightForground) === 'undefined'){
    lowlightForground = '#bababa';
  }

  if (typeof(lowlightBorder) === 'undefined'){
    lowlightBorder = '#555';
  }

  if (typeof(lowlightInputBackground) === 'undefined'){
    lowlightInputBackground = '#777';
  }

  if (typeof(lowlightInputForground) === 'undefined'){
    lowlightInputForground = '#111';
  }

  if (typeof(lowlightLinkColor) === 'undefined'){
    lowlightLinkColor = '#5d96b7';
  }

  if (typeof(lowlightLinkVisitedColor) === 'undefined'){
    lowlightLinkVisitedColor = '#426a82';
  }

  function connect(){
    var db = Components.classes['@mozilla.org/file/directory_service;1']
      .getService(Components.interfaces.nsIProperties)
      .get('ProfD', Components.interfaces.nsIFile);
    db.append('lowlight.sqlite');

    var storageService = Components.classes['@mozilla.org/storage/service;1']
      .getService(Components.interfaces.mozIStorageService);
    return storageService.openDatabase(db);
  }

  function apply(){
    var document = window.content.document;
    var style = document.getElementById('lowlight');
    if (!style){
      style = document.createElement('style');
      style.id = 'lowlight';
      var css = document.createTextNode(
        '* {' +
        '  background: none !important;' +
        '  border-color: ' + lowlightBorder + ' !important;' +
        '  color: ' + lowlightForground + ' !important;' +
        '  text-shadow: none !important;' +
        '}\n' +
        'body {' +
        '  background: ' + lowlightBackground + ' !important;' +
        '}\n' +
        'input, select, option, textarea {' +
        '  background: ' + lowlightInputBackground + ' !important;' +
        '  color: ' + lowlightInputForground + ' !important;' +
        '}\n' +
        'a:link {' +
        '  color: ' + lowlightLinkColor + ' !important;' +
        '}\n' +
        'a:visited {' +
        '  color: ' + lowlightLinkVisitedColor + ' !important;' +
        '}\n' +
        '.clear{' +
        '  background-color: transparent !important;' +
        '}'
      );
      style.appendChild(css);
      var head = document.getElementsByTagName('head');
      if (head.length > 0){
        head[0].appendChild(style);
      }
    }
  }

  function unapply(){
    var style = window.content.document.getElementById('lowlight');
    if (style){
      style.parentNode.removeChild(style);
    }
  }

  return {
    init: function(){
      var conn = connect();
      conn.executeSimpleSQL(
        'create table if not exists lowlight (' +
        '  host VARCHAR(255),' +
        '  primary key (host)' +
        ')'
      );
      conn.asyncClose();
    },

    toggle: function(){
      var document = window.content.document;
      var host = document.location.host;
      var style = document.getElementById('lowlight');
      var conn = connect();
      var sql;
      try {
        if (style){
          unapply();

          sql = conn.createStatement('delete from lowlight where host = :host');
          sql.params.host = host;
          sql.execute();
        } else {
          apply();

          sql = conn.createStatement('insert into lowlight (host) values (:host)');
          sql.params.host = host;
          sql.execute();
        }
      }finally{
        conn.asyncClose();
      }
    },

    onload: function(args){
      var document = window.content.document;

      // occurs on start w/ unfocused tabs, just ignore
      try{
        var host = document.location.host;
      }catch(e){
        return;
      }

      var conn = connect();
      try{
        var sql = conn.createStatement('select 1 from lowlight where host = :host');
        sql.params.host = host;
        if (sql.executeStep()){
          apply();
        }else{
          unapply();
        }
        sql.finalize();
      }catch(e){
        Firebug.Console.log(e);
      }finally{
        conn.asyncClose();
      }
    }
  };
}

var lowlight = LowLight();
lowlight.init();

commands.add(["lowlight"],
  "Apply a dark style to the current web page.",
  lowlight.toggle
);

autocommands.add(['LocationChange', 'DOMLoad'], '.*', lowlight.onload);
