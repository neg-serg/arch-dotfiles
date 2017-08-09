/* NEW BSD LICENSE {{{
Copyright (c) 2009-2010, anekos.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
    3. The names of the authors may not be used to endorse or promote products
       derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.


###################################################################################
# http://sourceforge.jp/projects/opensource/wiki/licenses%2Fnew_BSD_license       #
# に参考になる日本語訳がありますが、有効なのは上記英文となります。                #
###################################################################################

}}} */

// PLUGIN_INFO {{{
let PLUGIN_INFO = xml`
<VimperatorPlugin>
  <name>Option Selector</name>
  <description>Select a option of the select element.</description>
  <description lang="ja">select 要素の option を選択する。</description>
  <version>1.1.2</version>
  <author mail="anekos@snca.net" homepage="http://d.hatena.ne.jp/nokturnalmortum/">anekos</author>
  <license>new BSD License (Please read the source code comments of this plugin)</license>
  <license lang="ja">修正BSDライセンス (ソースコードのコメントを参照してください)</license>
  <updateURL>https://github.com/vimpr/vimperator-plugins/raw/master/option-selector.js</updateURL>
  <minVersion>2.2pre</minVersion>
  <maxVersion>2.3</maxVersion>
  <detail><![CDATA[
     Type <C-i> on "select" element.
  ]]></detail>
  <detail lang="ja"><![CDATA[
     "select" 要素上で <C-i> を打つ。
  ]]></detail>
</VimperatorPlugin>`;
// }}}

(function () {

  function select () {
    let targetElement = buffer.lastInputField;

    commandline.input(
      'Select a option of the select element: ',
      function (arg) {
        targetElement.selectedIndex = parseInt(arg, 10);
        let event = content.document.createEvent('Event');
        event.initEvent('change', true, true);
        targetElement.dispatchEvent(event);
        targetElement.focus();
      },
      {
        completer: function (context, args) {
          let elem = targetElement = buffer.lastInputField;
          if (!elem)
            return;

          context.title = ['value', 'text'];
          context.completions = Array.from(elem.options).map(function (opt, n) {
            return [[n + ': ' + opt.textContent, n + ': ' + opt.value], opt.textContent];
          });
        }
      }
    );
    events.feedkeys('<Space><C-u>', true); // FIXME
  }

  autocommands.add(
    'VimperatorEnter',
    /.*/,
    function () {
      let mapping = mappings.get(modes.INSERT, '<C-i>')
      let action = mapping.action;
      mapping.action = function () {
        if (buffer.lastInputField instanceof HTMLSelectElement)
          select()
        else
          action.apply(action, arguments);
      };
    }
  );

})();

// vim:sw=2 ts=2 et si fdm=marker:
