_ = @_ or require('underscore')

Echo = (dump) ->

  # Empty logs array
  logs = []

  # Is passed object is options (compare with default options keys)
  isOptions = (object) ->
    _(object).isObject() and  _(object)
                                .chain()
                                .keys()
                                .difference(
                                  _(echo.defaultOptions).keys()
                                )
                                .value().length == 0

  # Extact body and options from possibleBody
  extractBodyAndOptions = (possibleBody) ->
    if isOptions(possibleOptions = _(possibleBody).last())
      [
        _(possibleBody).initial(),
        possibleOptions
      ]
    else
      [possibleBody, {}]

  # Main log function
  echo = (possibleBody...) ->
    [body, options] = extractBodyAndOptions(possibleBody)

    logs.push \
      _({}).extend \
        echo.defaultOptions,
        options,
        body:      body
        timestamp: (new Date()).getTime()

  # Logs API
  echo.logs =

    # Return first log
    first: -> logs[0]

    # Return all logs
    all: -> logs

  # Default options
  echo.defaultOptions =
    level:           0
    namespace:       ''
    namespacePrefix: ''

  # Returns carried function
  echo.curry = (possibleCurriedOptions...) ->
    [curriedBody, curriedOptions] =
      extractBodyAndOptions(possibleCurriedOptions)

    (possibleBody...) ->
      [body, options] = extractBodyAndOptions(possibleBody)
      echo.apply \
        echo,
        _(curriedBody).union \
          body,
          [_({}).extend(curriedOptions, options)]

  # Define new level
  echo.define = (possibleKey, possibleLevel) ->
    defineLevel = (key, level) ->
      echo[key] = echo.curry(level: level)

    if _(possibleKey).isString()
      defineLevel(possibleKey, possibleLevel)
    else
      _(possibleKey).each (level, key) ->
        defineLevel(key, level)

  # Define default levels (debug, info, warn, error)
  echo.defineDefaults = ->
    echo.define
      debug: 0
      info:  1
      warn:  2
      error: 3

  # Return main log function
  echo


# Craete echo, preinitialized logger
echo = Echo()
echo.defineDefaults()

# Export Echo and echo
if window?
  window.Echo = Echo
  window.echo = echo
else
  module.exports = { Echo, echo }
