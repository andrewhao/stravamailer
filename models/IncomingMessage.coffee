# Lightweight wrapper around CloudMailIn's JSON
# message POST
class IncomingMessage
  constructor: (@json) ->
  body: ->
    @json.plain
  from: ->
    @json.headers.From

module.exports = IncomingMessage
