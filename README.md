# Echoes.js — comfort and elegance (while digging in logs)

Need something for logging in JavaScript? Want to powerful and simple solution?

Want to know what happened in module X between 9:00 and 10:00? You wish to see all logs of exact object for last 15 minutes?

Echo.js is your choose, bro!

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

### Log objects (with clone)

```
TODO: Add examples
```

### Log objects with deep clone

```
TODO: Add examples
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

### Currying

You can create curried function with predefined options, like `level`, `namespacePrefix` etc

### Dump log

```
TODO: Add examples
```

### Restore dump

```
TODO: Add examples
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