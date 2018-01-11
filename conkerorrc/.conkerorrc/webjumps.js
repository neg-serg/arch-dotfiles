webjumps.g = webjumps.google;
webjumps.w = webjumps.wikipedia;

define_webjump("gi", "http://www.google.com/images?q=%s&safe=off", $alternative = "http://www.google.com/imghp?as_q=&safe=off");

// Webjump oneliners
define_webjump("codesearch", "http://codesearch.debian.net/search?q=%s");
define_webjump("leo", "http://dict.leo.org/?lp=ende&lang=de&searchLoc=0&cmpType=relaxed&relink=on&sectHdr=off&spellToler=std&search=%s");
define_webjump("identica", "http://identi.ca/%s");
define_webjump("imdb", "http://imdb.com/find?q=%s");
define_webjump("kol", "http://kol.coldfront.net/thekolwiki/index.php/%s");
define_webjump("oh", "https://www.openhub.net/p?query=%s");
define_webjump("ixquick", "http://ixquick.com/do/metasearch.pl?query=%s");
define_webjump("trans", "http://translate.google.com/translate_t#auto|en|%s");
define_webjump("tw", "https://twitter.com/%s");
define_webjump("urban", "http://www.urbandictionary.com/define.php?term=%s");
define_webjump("wo", "http://www.wolframalpha.com/input/?i=%s");

// CVE
define_webjump("cve", "https://cve.mitre.org/cgi-bin/cvename.cgi?name=%s");
