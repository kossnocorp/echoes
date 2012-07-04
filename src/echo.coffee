_ = @_ or require('underscore')

Echo = (dump) ->

  # Empty logs array
  logs = []

  isOptions = ->

  # Main log function
  echo = (body...) ->
    logs.push \
      _(echo.defaultOptions).extend(body: body)

  # Logs API
  echo.logs =

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
