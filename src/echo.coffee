echo = ->


if window?
  window.echo = echo
else
  module.exports = echo
