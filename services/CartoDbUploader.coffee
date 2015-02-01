https = require "https"

class CartoDbUploader
  upload: (file, link, cb) ->
    payload = { "url": link }
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
    console.log("Writing payload: #{payload.inspect}")
    req.write(payload)
    req.end()
    cb()

  payload: ->

module.exports = CartoDbUploader
