###
   ______     ______     __  __     ______     ______     ______
  /\  ___\   /\  ___\   /\ \_\ \   /\  __ \   /\  ___\   /\  ___\
  \ \  __\   \ \ \____  \ \  __ \  \ \ \/\ \  \ \  __\   \ \___  \
   \ \_____\  \ \_____\  \ \_\ \_\  \ \_____\  \ \_____\  \/\_____\
    \/_____/   \/_____/   \/_/\/_/   \/_____/   \/_____/   \/_____/

  Echoes.js ~ v0.0.0 ~ https://github.com/kossnocorp/echoes

  Need something for logging in JavaScript?
  Want to powerful and simple solution? Echo.js is your choose, bro!

  The MIT License

  Copyright (c) 2012 Sasha Koss
###

_ = @_ or require('underscore')

Echo = (dump) ->

  # Internal: Logs storage
  logs = []

  # Internal: String levels
  stringLevels = {}

  ###
    Internal: Determine is passed variable is options object.

    options - Variable to be checked (could be any type).

    Examples

      isOptions(4)
      # => false

      isOptions(level: 4)
      # => true

    Returns boolean value.
  ###
  isOptions = (object) ->
    _(object).isObject() and  _(object)
                                .chain()
                                .keys()
                                .difference(
                                  _(echo.defaultOptions).keys()
                                )
                                .value().length == 0

  ###
    Internal: Clone array or object, other types will be passed by

    item - variable to be cloned (or passed by)

    Examples

      cloneModificator(5)
      # => 5

      a = example: true
      cloneModificator(a) == a # === for JavaScript
      # => false
  ###
  cloneModificator = (item) ->
    if _(item).isObject() or _(item).isArray()
      _(item).clone()
    else
      item

  ###
    Internal: Process body.

    body    - array of variables to be logged.
    options - options of log.

    Examples

      processBody([1, 2, 3])
      # => [1, 2, 3]

      processBody([1, 2, 3], level: 5)
      # => [1, 2, 3]

    Returns array, processed body.
  ###
  processBody = (body, options) ->
    modificators = []

    if options?
      modificators.push(cloneModificator) if options.clone

    _(body).map (item) ->
      _(modificators).reduce \
        (item, modificator) -> modificator(item, options),
        item

  ###
    Internal: Extact body and options from arguments.
  ###
  extractBodyAndOptions = (possibleBody) ->
    if isOptions(possibleOptions = _(possibleBody).last())
      [_(possibleBody).initial(), possibleOptions]
    else
      [possibleBody, {}]

  ###
    Internal: Craete options merged with default values.

    Returns options with default values.
  ###
  optionsWithDefaults = (options) ->
    _({}).extend(echo.defaultOptions, options)

  # Internal: Cut options: these options will be remove before save to log
  CUT_OPTIONS = 'namespacePrefix namespace id'.split(' ')


  ###
    Internal: Process options, remove unncessary, join cid etc

    Returns object, processed options
  ###
  processOptions = (options) ->
    cidArray = []

    cidArray.push(options.namespacePrefix) unless options.namespacePrefix == ''
    cidArray.push(options.namespace)       unless options.namespace == ''
    cidArray.push(options.id)              unless options.id == ''

    newOptions = _(options).clone()

    # Convert string level to numeric
    if _(newOptions.level).isString()
      newOptions.level = stringLevels[newOptions.level] || 0

    delete newOptions[key] for key in CUT_OPTIONS

    _({})
      .extend \
        newOptions,
        cid: cidArray.join('.')

  # Assemble options
  assembleOptions = (options) ->
    processOptions \
      optionsWithDefaults(options)

  ###
    Internal: Print to console if needed
  ###
  printIfNeeded = (body, options) ->
    if console?.log? and options.print
      console.log.apply(console, body)

  # Main log function
  echo = (possibleBody...) ->
    [body, options] = extractBodyAndOptions(possibleBody)

    finalOptions = assembleOptions(options)
    finalBody = processBody(body, finalOptions)

    printIfNeeded(finalBody, finalOptions)

    logs.push \
      _({}).extend \
        finalOptions,
        body:      finalBody
        timestamp: (new Date()).getTime()

  # Logs API
  echo.logs =

    # Return first log
    first: -> logs[0]

    # Return all logs
    all: -> logs

  # Default options
  echo.defaultOptions =
    print:           false
    clone:           true
    level:           0
    namespacePrefix: ''
    namespace:       ''
    id:              ''

  ###
    Internal: Clone with deep level
  ###
  cloneWithDeep = (obj, deep, level = 0) ->
    clonedObj = if _(obj).isArray() then [] else {}

    _(obj).each (value, key) ->
      clonedObj[key] = if _(value).isObject() or _(value).isArray()
        if deep > level
          cloneWithDeep(value, deep, level + 1)
        else if _(value).isArray()
          '[array]'
        else
          '[object]'
      else
        value

    clonedObj

  # Internal: Body deep level
  BODY_DEEP_LEVEL = 2

  # Returns dumped
  echo.dump = (deep = 1) ->
    JSON.stringify(cloneWithDeep(logs, deep + BODY_DEEP_LEVEL))

  ###
    Public: Restore dump

    Examples

      echo.restore(dump)
  ###
  echo.restore = (dump) ->
    logs = _.union(logs, if _(dump).isString() then JSON.parse(dump) else dump)

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

  ###
    Internal: Define level

    Examples

      defineLevel('warn', 2)
  ###
  defineLevel = (key, level) ->
    stringLevels[key] = level
    echo[key] = echo.curry(level: level)

  ###
    Public: Define new level(s)

    Examples

      echo.define(info: 1, warn: 2)

      echo.define('error', 3)
  ###
  echo.define = (possibleKey, possibleLevel) ->
    if _(possibleKey).isString()
      defineLevel(possibleKey, possibleLevel)
    else
      _(possibleKey).each (level, key) ->
        defineLevel(key, level)

  ###
    Public: Define default levels: debug (0), info (1), warn (2), error (3)

    Examples

      defineDefaults()
  ###
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
