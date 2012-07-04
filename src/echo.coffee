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

  # Main log function
  echo = (possibleBody...) ->
    [options, body] = if isOptions(possibleOptions = _(possibleBody).last())
      [possibleOptions, _(possibleBody).first(possibleBody.length - 1)]
    else
      [{}, possibleBody]

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
  echo.curry = ->
    echo

  # Define new level
  echo.define = ->

  # Define default levels (debug, info, warn, error)
  echo.defineDefaults = ->

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
