https = require "https"

class CartoDbUploader
  constructor: ->
  upload: (file, link, cb) ->
    console.log("CartoDbUploader initializing")
    console.log file
    console.log link
    console.log cb
    payload = { "url": link }
    console.log payload
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
    console.log("Writing payload:")
    console.log payload
    req.write(payload)
    req.end()
    cb()

module.exports = CartoDbUploader
