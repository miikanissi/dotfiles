/*** MY OVERRIDES ***/
// 0800
user_pref("keyword.enabled", true);
user_pref("browser.search.suggest.enabled", true);
user_pref("browser.urlbar.suggest.searches", true);
// 1000
user_pref("browser.cache.disk.enable", true);
// 2000
user_pref("media.autoplay.blocking_policy", 0);
user_pref("media.peerconnection.enabled", true);
// 2400
user_pref("dom.allow_cut_copy", true);
// 2800
user_pref("privacy.sanitize.sanitizeOnShutdown", false);
user_pref("privacy.clearOnShutdown.cache", false);
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.history", false); // Browsing & Download History
user_pref("privacy.clearOnShutdown.offlineApps", false); // Offline Website Data
user_pref("privacy.clearOnShutdown.sessions", false); // Active Logins
user_pref("privacy.clearOnShutdown.siteSettings", false); // Site Preferences
user_pref("privacy.cpd.cache", false);
user_pref("privacy.cpd.cookies", false);
user_pref("privacy.cpd.history", false); // Browsing & Download History
user_pref("privacy.cpd.offlineApps", false); // Offline Website Data
user_pref("privacy.cpd.passwords", false); // this is not listed
user_pref("privacy.cpd.sessions", false); // Active Logins
user_pref("privacy.cpd.siteSettings", false); // Site Preferences
// 4000
user_pref("privacy.firstparty.isolate", false);
// 4500
user_pref("privacy.resistFingerprinting.letterboxing", false); // [HIDDEN PREF]
// 5000
user_pref("browser.tabs.warnOnClose", true);
user_pref("browser.download.autohideButton", true); // [FF57+]
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // [FF68+] allow userChrome/userContent
user_pref("general.autoScroll", true); // middle-click enabling auto-scrolling
user_pref("middlemouse.paste", false);
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.toolbars.bookmarks.visibility", "always");
user_pref("browser.backspace_action", 2); // 0=previous page, 1=scroll up, 2=do nothing
user_pref("identity.fxaccounts.enabled", false); // Firefox Accounts & Sync
user_pref("reader.parse-on-load.enabled", false); // Reader View
user_pref("signon.rememberSignons", false); // Ask to save passwords
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("media.autoplay.blocking_policy", 2);
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled",	false);
user_pref("browser.startup.page", 3); // Restore previous sesssion
