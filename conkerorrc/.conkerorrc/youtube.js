// enable >360p in the HTML5 player
//make sure libavcodec is installed for mp4 support.
//WebM performance seems to be too bad to use.
session_pref("media.mediasource.enabled",true);
session_pref("media.mediasource.ignore_codecs",true);
session_pref("media.mediasource.mp4.enabled",true);
session_pref("media.mediasource.webm.enabled",true);
session_pref("media.fragmented-mp4.enabled",true);
session_pref("media.fragmented-mp4.exposed",true);
session_pref("media.fragmented-mp4.ffmpeg.enabled",true);
session_pref("media.fragmented-mp4.gmp.enabled",true);
session_pref("media.fragmented-mp4.use-blank-decoder",false);

