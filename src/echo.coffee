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

  # Clone value
  cloneModificator = (item) ->
    if _(item).isObject() or _(item).isArray()
      _(item).clone()
    else
      item

  # Process body
  processBody = (body, options) ->
    modificators = []

    if options?
      modificators.push(cloneModificator) if options.clone

    _(body).map (item) ->
      _(modificators).reduce \
        (item, modificator) -> modificator(item, options),
        item

  # Extact body and options from possibleBody
  extractBodyAndOptions = (possibleBody) ->
    if isOptions(possibleOptions = _(possibleBody).last())
      [_(possibleBody).initial(), possibleOptions]
    else
      [possibleBody, {}]

  # Returns options with default values
  optionsWithDefaults = (options) ->
    _({}).extend(echo.defaultOptions, options)

  # Cut options: these options will be remove before save to log
  CUT_OPTIONS = 'namespacePrefix namespace id'.split(' ')

  # Process options: remove unncessary, join cid etc
  processOptions = (options) ->
    cidArray = []

    cidArray.push(options.namespacePrefix) unless options.namespacePrefix == ''
    cidArray.push(options.namespace)       unless options.namespace == ''
    cidArray.push(options.id)              unless options.id == ''

    newOptions = _(options).clone()

    delete newOptions[key] for key in CUT_OPTIONS

    _({})
      .extend \
        newOptions,
        cid: cidArray.join('.')

  # Assemble options
  assembleOptions = (options) ->
    processOptions \
      optionsWithDefaults(options)

  # Main log function
  echo = (possibleBody...) ->
    [body, options] = extractBodyAndOptions(possibleBody)

    finalOptions = assembleOptions(options)

    logs.push \
      _({}).extend \
        finalOptions,
        body:      processBody(body, finalOptions)
        timestamp: (new Date()).getTime()

  # Logs API
  echo.logs =

    # Return first log
    first: -> logs[0]

    # Return all logs
    all: -> logs

  # Default options
  echo.defaultOptions =
    clone:           true
    level:           0
    namespacePrefix: ''
    namespace:       ''
    id:              ''

  # Returns dumped
  echo.dump = ->
    JSON.stringify(logs)

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
