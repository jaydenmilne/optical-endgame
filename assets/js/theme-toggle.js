(function () {
  "use strict";

  var storageKey = "olt-color-scheme";
  var button = document.getElementById("theme-toggle");
  var systemTheme = window.matchMedia("(prefers-color-scheme: dark)");

  function applyTheme(theme, remember) {
    document.documentElement.dataset.theme = theme;

    if (window.jtd && typeof window.jtd.setTheme === "function") {
      window.jtd.setTheme(theme);
    }

    if (remember) {
      try { localStorage.setItem(storageKey, theme); } catch (error) {}
    }

    if (button) {
      var nextTheme = theme === "dark" ? "light" : "dark";
      button.setAttribute("aria-label", "Switch to " + nextTheme + " theme");
      button.setAttribute("title", "Switch to " + nextTheme + " theme");
    }
  }

  applyTheme(window.oltInitialTheme || (systemTheme.matches ? "dark" : "light"), false);

  if (button) {
    button.addEventListener("click", function () {
      var current = document.documentElement.dataset.theme || "light";
      applyTheme(current === "dark" ? "light" : "dark", true);
    });
  }

  systemTheme.addEventListener("change", function (event) {
    var saved;
    try { saved = localStorage.getItem(storageKey); } catch (error) {}
    if (!saved) applyTheme(event.matches ? "dark" : "light", false);
  });
})();

