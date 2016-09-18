# wd(1) -- WebDriver command line tool

## Example session

    $ export WEBDRIVER_BROWSER=chrome
    $ export WEBDRIVER_SESSION="$(wd new-session)"

    $ wd go https://github.com/mbrock/wd
    $ wd screenshot > /tmp/wd.png
    $ wd click "$(wd find css '.user-mention')"
    $ wd exec 'return document.title'

## Command reference

### `wd new-session`

Prints the new session ID.

All other commands expect this ID to be in `WEBDRIVER_SESSION`, so

    export WEBDRIVER_SESSION="$(wd new-session)"

is a useful pattern.

You must configure desired capabilities by setting either

  - `WEBDRIVER_CAPABILITIES` to a JSON string, or
  - `WEBDRIVER_BROWSER` to a browser name (`chrome`, `firefox`, etc).

### `wd delete-session`

Deletes the current session.

### `wd go <url>`

Opens <url> in the current session.

### `wd back`
### `wd forward`
### `wd refresh`

### `wd get-current-url`
### `wd get-title`
### `wd get-page-source`

### `wd get-window-handle`
### `wd get-window-handles`

### `wd switch-to-window <window-handle>`

### `wd switch-to-frame <frame-id>`

`<frame-id>` can be either a number or an element ID.

### `wd switch-to-parent-frame`

### `wd get-window-size`

Prints width and height on separate lines.

### `wd set-window-size <width> <height>`

### `wd maximize`

### `wd find <strategy> <selector> ...`

Finds one matching element.

The `<strategy>` can be one of:

  - `css` (CSS selector)
  - `xpath` (XPath selector)
  - `id` (element ID)
  - `name` (element name)
  - `class` (element class name)
  - `tag` (element tag name)
  - `link` (element link text)
  - `partial` (partial element link text)

The `<selector>` values are concatenated for convenience.

### `wd find-all <strategy> <selector>`

See `wd find`; finds all matching elements.

### `wd find-in <element-id> <strategy> <selector>`

See `wd find`; finds one matching sub-element.

(Not supported by Chrome.)

### `wd find-all-in <element-id> <strategy> <selector>`

See `wd find`; finds all matching sub-elements.

(Not supported by Chrome.)

### `wd is-selected <element-id>`
### `wd is-enabled <element-id>`

### `wd attribute <element-id> <attribute-name>`

Gets an element attribute value.

### `wd css-value <element-id> <css-property-name>`

Gets an element CSS property value.

### `wd text <element-id>`

Gets an element's `innerText`.

### `wd tag-name <element-id>`

Gets the tag name of an element.

### `wd click <element-id>`

Clicks an element.

### `wd clear <element-id>`

Clears the value, checkedness, or text content of an element.

### `wd send-keys <element-id> [keys] ...`

Sends keys to an element.

Key arguments are concatenated for convenience.

### `wd execute <body> [argument] ...`

Evaluates the JavaScript code `<body>` as a function called with the
given arguments.

Prints the return value of the specified function.

### `wd execute-async <body> [argument] ...`

Evaluates as in `wd execute` but waiting for the script to invoke a callback
which is passed as an additional final argument to the specified function.

Prints the value finally passed to the callback.

### `wd cookies`

Prints the currently set cookies as a JSON array.

### `wd cookie <name>`

Prints the cookie named `<name>` as JSON.

### `wd add-cookie <key> <value> <key> <value> ...`

Adds a cookie according to the given keys/values.

Example: `wd add-cookie name '"user"' value '"mbrock"'`

### `wd delete-cookie <name>`

Deletes the cookie whose name is `<name>`.

### `wd delete-cookies`

Deletes all cookies.

### `wd screenshot`

Prints a binary PNG screenshot to stdout.

### `wd element-screenshot <element-id>`

Prints a binary PNG screenshot of a specific element to stdout.

(Not supported by Chrome.)

