user_pref("browser.uidensity", 1); // Be more compact
user_pref("intl.accept_languages", "en-us,en"); // Languages

// Disable pocket
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("extensions.pocket.enabled", false);

user_pref("browser.tabs.allowTabDetach", false); // Don't allow detaching a tab by pulling it
user_pref("browser.tabs.tabClipWidth", 1000); // Don't display a close button for tabs

// Don't display fullscreen warning
user_pref("full-screen-api.warning.timeout", 0);
user_pref("full-screen-api.transition.timeout", 0);

// Disable annoying prompts
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.disableResetPrompt", true);
