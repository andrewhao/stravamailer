https = require "https"

class CartoDbUploader
  constructor: ->
    @api_key = process.env.CARTO_DB_API_KEY || "test_key"
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
      path: "/api/v1/imports/?api_key=#{@api_key}"
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
