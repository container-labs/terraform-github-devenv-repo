{
  "workbench.iconTheme": "vscode-icons",
  "materialTheme.accent": "Orange",
  "workbench.startupEditor": "readme",
  "workbench.colorTheme": "Community Material Theme High Contrast",
  "terminal.integrated.shell.linux": "/usr/bin/zsh",
  // == VSCode / Dart recommended settings ==
  // Those are the settings applied when running "Use Recommended Settings" in Flutter extension
  // see https://dartcode.org/docs/recommended-settings/
  //
  // Causes the debug view to automatically appear when a breakpoint is hit. This
  // setting is global and not configurable per-language.
  "debug.openDebug": "openOnDebugBreak",
  "[dart]": {
    // Automatically format code on save and during typing of certain characters
    // (like `;` and `}`).
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    // Draw a guide line at 80 characters, where Dart's formatting will wrap code.
    "editor.rulers": [
      100
    ],
    // Disables built-in highlighting of words that match your selection. Without
    // this, all instances of the selected text will be highlighted, interfering
    // with Dart's ability to highlight only exact references to the selected variable.
    "editor.selectionHighlight": false,
    // By default, VS Code prevents code completion from popping open when in
    // "snippet mode" (editing placeholders in inserted code). Setting this option
    // to `false` stops that and allows completion to open as normal, as if you
    // weren't in a snippet placeholder.
    "editor.suggest.snippetsPreventQuickSuggestions": false,
    // By default, VS Code will pre-select the most recently used item from code
    // completion. This is usually not the most relevant item.
    //
    // "first" will always select top item
    // "recentlyUsedByPrefix" will filter the recently used items based on the
    //     text immediately preceeding where completion was invoked.
    "editor.suggestSelection": "first",
    // Allows pressing <TAB> to complete snippets such as `for` even when the
    // completion list is not visible.
    "editor.tabCompletion": "onlySnippets",
    // By default, VS Code will populate code completion with words found in the
    // current file when a language service does not provide its own completions.
    // This results in code completion suggesting words when editing comments and
    // strings. This setting will prevent that.
    "editor.wordBasedSuggestions": false,
  },
  // == CUSTOM - DTx ==
  // Settings to keep our JSON file in a consistent format
  "[json]": {
    "editor.formatOnSave": true,
    "editor.wordWrap": "on",
    "editor.defaultFormatter": "vscode.json-language-features"
  },
  "[jsonc]": {
    "editor.formatOnSave": true,
    "editor.wordWrap": "on",
    "editor.defaultFormatter": "vscode.json-language-features"
  },
  "dart.devToolsPort": 9191,
  "dart.lineLength": 100,
  "git.ignoreLimitWarning": true,
}
