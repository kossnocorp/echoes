# Echoes.js — comfort and elegance (while digging in logs)

Need something for logging in JavaScript? Want to powerful and simple solution?

Want to know what happened in module X between 9:00 and 10:00? You wish to see all logs of exact object for last 15 minutes?

Echoes.js is your choose, bro!

## Usage

### Basic usage

``` coffeescript
echo       'You'      # => Level of importance is 0
echo.debug 'are'      # => … is 0
echo.info  'awesome,' # => … is 1
echo.warn  'my'       # => … is 2
echo.error 'friend!'  # => … is 3
```

``` coffeescript
echo('Good news!', level: 3)       # => … is 3
echo('Good news!', level: 'error') # => … is 3
```

### Structure of logs:

This code:

``` coffeescript
echo.log('Test', 'logging', namespace: 'app.lol_module.45')
echo.log(['trololo'])
```

… will store:

``` json
[
  {
    "timestamp":  1341468018606,
    "body":       ["Test", "logging"],
    "namespace":  "app.lol_module.45"
  },
  {
    "timestamp":  1341468018606,
    "body":       [["trololo"]],
    "namespace":  ""
  }
]
```

### Print

By default logs is don't print to developer console (Web Inspector, Firebug etc).

If you want to log with print you should add `print: true` key:

``` coffeescript
echo('', print: true)
```

If you want to setup `print: true` for specific levels:

``` coffeescript
echo.definePrint
  0:     false
  3:     true
  error: true
```

Or you can you advanced rules:

```
all                                       - Set true to all levels.
only                                      - Set true to only …
except                                    - Set true to all except …
greaterThan (alias: gt)                   - Greater than.
greaterThanOrEqualTo (aliases: gte, gteq) - Greater than or equal to.
lessThan (alias: lt)                      - Less than.
lessThanOrEqualTo (aliases: lte, lteq)    - Less than or equal to.
```

#### Examples

Always print:

``` coffeescript
echo.definePrint('all')

# equal to

echo.definePrint(all: true)

# equal to

echo.defaultOptions.print = true
```

Only for specific levels:

``` coffeescript
echo.definePrint('only', [1, 'warn'])
```

Print log with level great than 4 (but 7 and 9):

``` coffeescript
echo.definePrint
  gt:     4
  except: [7, 9]

# equal to

echo.definePrint
  gt: 4
  7:  false
  9:  false

# equal to

echo.definePrint
  gt:     4
  except: 7
  9:      false
```

etc

#### Print function

By default Echoes use `console.log` (if defined) for logs with level `0`, `console.info` for `1`, `console.warn` for `2`, `console.error` for `3`.

But you can setup you own print function:

``` coffeescript
ownPrint = (log, options) ->
  alert(log.body)

echo.setPrintFunction(ownPrint)
```

### Log objects (with clone)

All objects and arrays clone on log:

``` coffeescript
obj =
  qwe: 1
  asd: 2
  obj: qwe: 1, asd: 2

echo obj

loggedObj = echo.logs.first().body[0]

loggedObj == obj     #=> false, because obj was cloned
loggedObj.obj == obj #=> true, but not deeply
```

### Save link to objects instead of clone

If you want to save link to object instead of clone it, just add `clone: false` key to options:

``` coffeescript
obj = qwe: 1, asd: 2

echo obj, clone: false

echo.logs.first().body[0] == obj #=> true
```

### Write plugins for log process

```
TODO: Add examples
```

### Indeficate object

There 3 ways to indeficate object:

* namespacePrefix
* namespace
* id

On log namespacePrefix, namespace and id join with `.` and save as `cid`:

``` coffeescript
echo 'Qwerty', namespacePrefix: 'app', namespace: 'controller', id: 42
echo.logs.first().cid # => "app.controller.42"
```

### Basic functions to get logs

Get first record:

``` coffeescript
echo.logs.first()
```

To get all logs (array of log objects):

``` coffeescript
echo.logs.all()
```

### Access logs by shortcut

``` coffeescript
l = echo.logs
l.all()
l.first()
```

### Getters instead functions (works only in [...])

```
TODO: Add more examples
```

### Grep logs

To find logs with `'some'` in body:

```
echo.logs.grep 'some' # => [{ body: ['Something'] }, { body: ['I want some LSD.']}]
```

### Get logs by time

```
TODO: Add more examples
```

### Write plugins for logs

```
TODO: Add more examples
```

### Define custom levels

``` coffeescript
echo.shitHappened # => undefined
echo.define(shitHappened: 8)
echo.shitHappened # Log function with level of importance equal to 8
```

### Callbacks

```
TODO: Add examples
```

### Async

```
TODO: Add examples
```

### Add trace to log (limited support)

```
TODO: Add examples
```

### Output to browser console

```
TODO: Add examples
```

### Currying

You can create curried function with predefined options, like `level`, `namespacePrefix` etc

### Dump log

You can dump logs:

```
$.post \
  '/logs',
  log: echo.dump()
```

If you're using an older browser which doesn't have native JSON support (i.e. IE 7), you'll need to include [`json2.js`](https://github.com/douglascrockford/JSON-js/blob/master/json2.js) which adds legacy support.

### Dump level

By default dump level is `1`:

```
echo.dump(0)
# => [ { body: [1, 2, "[object Object]"], …

echo.dump()
# => [ { body: [1, 2, { 1, 2, "[object Object]" }], …

echo.dump(2)
# => [ { body: [1, 2, { 1, 2, { 1, 2, "[object Object]" } }], …

# etc
```

If you want to get deep dump to serialise objects with circular references you should include [`cycle.js extension to the JSON object`](https://github.com/douglascrockford/JSON-js/blob/master/cycle.js) and pass `-1` as level (be carefully, making dump may take a time).

``` coffeescript
echo.dump(-1)
```

### Restore dump

And restore dump with initializer:

``` coffeescript
e = Echo(dump)
```

… or via call restore:

``` coffeescript
echo.restore(dump)
```

### Store log dumps in local storage

```
TODO: Add examples
```

### Cleanup logs

```
TODO: Add examples
```

## Changelog

This project uses [Semantic Versioning](http://semver.org/) for release numbering.

Currently this project in active development but no any releases yet.

## Contributors and sponsorship

Idea and code by @kossnocorp and other [contributors](https://github.com/kossnocorp/echo/contributors).

Initialy sponsored by [Evil Martians](http://evilmartians.com/) special for [Wannafun](http://wannafun.ru/).

## License

The MIT License

Copyright (c) 2012 Sasha Koss

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.