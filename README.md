# wd(1) -- WebDriver command line tool

`wd` is a simple tool for interacting with servers that implement the
W3C WebDriver API.

It can be used to write web integration tests as shell scripts or to
perform web automation tasks.

See [the spec](https://w3c.github.io/webdriver/webdriver-spec.html)
for details.

## Dependencies

  - `bash`
  - `perl` with `JSON::PP` (included since Perl 5.14)
  - [`jq`](https://github.com/stedolan/jq) (would like to replace with Perl)
  - `curl`

## Example session

    $ export WEBDRIVER_BROWSER=chrome
    $ export WEBDRIVER_SESSION="$(wd new-session)"
    $ wd go https://github.com/mbrock/wd
    $ wd screenshot > /tmp/wd.png
    $ wd click "$(wd find css '.user-mention')"
    $ wd exec 'return document.title'

## Command reference

### Managing sessions

#### `wd new-session`

Prints the new session ID.

All other commands expect this ID to be in `WEBDRIVER_SESSION`, so

    export WEBDRIVER_SESSION="$(wd new-session)"

is a useful pattern.

You must configure desired capabilities by setting either

  - `WEBDRIVER_CAPABILITIES` to a stringified JSON object, or
  - `WEBDRIVER_BROWSER` to a browser name (`chrome`, `firefox`, etc).

#### `wd delete-session`

Deletes the current session.

### Navigation

#### `wd go <url>`

Opens `<url>` in the current window.

#### `wd back`

Navigates back in the current window.

#### `wd forward`

Navigates forward in the current window.

#### `wd refresh`

Refreshes the page of the current window.

### Element finding

#### `wd find <strategy> <selector> ...`

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

#### `wd find-all <strategy> <selector>`

See `wd find`; finds all matching elements.

#### `wd find-in <element-id> <strategy> <selector>`

See `wd find`; finds one matching sub-element.

(Not supported by Chrome.)

#### `wd find-all-in <element-id> <strategy> <selector>`

See `wd find`; finds all matching sub-elements.

(Not supported by Chrome.)

### Element information

#### `wd is-selected <element-id>`

Exits with a non-zero status if the element is not a selected or
checked `input` or `option`.

#### `wd is-enabled <element-id>`

Exits with a non-zero status if the element is not an enabled
form control.

#### `wd attribute <element-id> <attribute-name>`

Prints an element attribute value.

Exits with non-zero status if the given attribute does not exist.

#### `wd css-value <element-id> <css-property-name>`

Prints an element CSS property value.

Exits with non-zero status if the given style property does not exist.

#### `wd text <element-id>`

Prints an element's `innerText`.

#### `wd tag-name <element-id>`

Prints the tag name of an element.

### Element actions

#### `wd click <element-id>`

Clicks an element.

#### `wd clear <element-id>`

Clears the value, checkedness, or text content of an element.

#### `wd send-keys <element-id> [keys] ...`

Sends keys to an element.

Key arguments are concatenated for convenience.

Example:

    $ wd send-keys "$(wd find id search)" webdriver json api

### JavaScript execution

#### `wd execute <body> [argument] ...`

Evaluates the JavaScript code `<body>` as a function called with the
given arguments.

Prints the return value of the specified function.

#### `wd execute-async <body> [argument] ...`

Evaluates as in `wd execute` but waiting for the script to invoke a callback
which is passed as an additional final argument to the specified function.

Prints the value finally passed to the callback.

### Page information

#### `wd get-current-url`

Prints the URL of the page in the current window.

#### `wd get-title`

Prints the title of the page in the current window.

#### `wd get-page-source`

Prints the raw HTML source of the page in the current window.

### Windows

#### `wd get-window-size`

Prints the current window's width and height on separate lines.

#### `wd set-window-size <width> <height>`

Changes the size of the current window.

#### `wd maximize`

Maximizes the current window.

#### `wd get-window-handle`

Prints the window handle of the current window.

#### `wd get-window-handles`

Prints a list of all window handles in the current session.

#### `wd switch-to-window <window-handle>`

Changes which window is the current window.

### Frames

#### `wd switch-to-frame <frame-id>`

Changes the current frame.

`<frame-id>` can be either a number or an element ID.

See [the specification](https://www.w3.org/TR/webdriver/#switch-to-frame)
for exact details.

#### `wd switch-to-top-level-frame`

Resets the current frame to the top level.

#### `wd switch-to-parent-frame`

Sets the current frame to the parent of the current frame.

### Cookies

See [the spec](https://w3c.github.io/webdriver/webdriver-spec.html#cookies)
for details on cookie JSON serialization.

#### `wd cookies`

Prints the currently set cookies as a JSON array.

#### `wd cookie <name>`

Prints the cookie named `<name>` as JSON.

#### `wd add-cookie <key> <value> <key> <value> ...`

Adds a cookie according to the given keys/values.

Example: `wd add-cookie name '"user"' value '"mbrock"'`

#### `wd delete-cookie <name>`

Deletes the cookie whose name is `<name>`.

#### `wd delete-cookies`

Deletes all cookies.

### Screenshots

#### `wd screenshot`

Prints a binary PNG screenshot to stdout.

#### `wd element-screenshot <element-id>`

Prints a binary PNG screenshot of a specific element to stdout.

(Not supported by Chrome.)
