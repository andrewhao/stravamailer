https = require "https"
request = require "request"

class CartoDbUploader
  constructor: ->
    @api_key = process.env.CARTO_DB_API_KEY || "test_key"
  upload: (file, link, cb) ->
    console.log("CartoDbUploader initializing")
    payload = { "url": link }

    options = {
      json: true
      body: payload
    }

    console.log "CartoDbUploader making request with args:"
    console.log options

    request.post(
      "https://velocitas.cartodb.com/api/v1/imports/?api_key=#{@api_key}",
      options
    ).on("error", (error) ->
      console.log("CartoDbUploader encountered an error:")
      console.log(error)
    ).on("response", (res) ->
      console.log("CartoDbUploader got a response baby. let's do this. Hitting callback:")
      console.log(res)
      cb()
    )

module.exports = CartoDbUploader
