# Parse an email for its GPX link
class EmailParser
  constructor: (@message) ->
  regex: /http.*\.gpx/
  gpxLink: ->
    ma = @message.match(@regex)
    return null if ma is null
    ma[0]

module.exports = EmailParser
