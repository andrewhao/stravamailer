https = require "https"

class CartoDbUploader
  constructor: (@file, @link) ->

  upload: (cb) ->
    req = https.request({
      method: "POST"
      hostname: "velocitas.cartodb.com"
      path: "/api/v1/imports/?api_key=64aa46209fd4374742178748e6ec3f849e48b61f"
      headers: {"Content-Type": "application/json"}
    }, (response) ->
      response.setEncoding('utf8')
      response.on('data', (chunk) ->
        console.log('Response: ' + chunk)
      )
    )
    console.log("Writing payload: #{@payload().inspect}")
    req.write(@payload())
    req.end()
    cb()

  payload: ->
    { "url": @link }

module.exports = CartoDbUploader
