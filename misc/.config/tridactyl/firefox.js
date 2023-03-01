// Preferences for Firefox. To be symlinked in the profile as user.js.
// Settings synced through Firefox Accounts may not be present.

user_pref("browser.uidensity", 1); // Be more compact
// user_pref("intl.accept_languages", "en-us,en"); // Languages
// user_pref("layout.css.prefers-color-scheme.content-override", 1); // light
// No popup at all!
// user_pref("browser.link.open_newwindow.restriction", 0);

// Disable pocket
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("extensions.pocket.enabled", false);

// Backspace is like back
user_pref("browser.backspace_action", 0);

user_pref("browser.tabs.allowTabDetach", false); // Don't allow detaching a tab by pulling it
user_pref("browser.tabs.tabClipWidth", 1000); // Don't display a close button for tabs

// Don't display fullscreen warning
user_pref("full-screen-api.warning.timeout", 0);
user_pref("full-screen-api.transition.timeout", 0);

// Don't display a close button for tabs
user_pref("browser.tabs.tabClipWidth", 1000);

// And VAAPI decoding with ffmpeg
user_pref("media.ffmpeg.vaapi.enabled", true);

// Legacy indicator is buggy (no content)
user_pref("privacy.webrtc.legacyGlobalIndicator", false);
user_pref("privacy.webrtc.globalMuteToggles", true);

// Disable annoying prompts
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.disableResetPrompt", true);
user_pref("browser.tabs.firefox-view", false);

// Disable safebrowsing malware (sends hash of each file to Google)
user_pref("browser.safebrowsing.malware.enabled", false);

// Don't trim URLs
user_pref("browser.urlbar.trimURLs", false);

// Enable userContent.css (disabled)
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", false);
