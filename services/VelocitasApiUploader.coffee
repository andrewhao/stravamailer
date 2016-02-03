request = require 'request'

class VelocitasApiUploader
  constructor: ->

  upload: (file, link, cb) ->
    options = {
      form: {
        url: link
      }
    }

    console.log "VelocitasApiUploader making request with args:"
    console.log options

    request.post(
      "https://velocitas.herokuapp.com/api/v1/tracks",
      options
    ).on("error", (error) ->
      console.log("VelocitasApiUploader encountered an error:")
      console.log(error)
      cb()
    ).on("response", (res) ->
      console.log("VelocitasApiUploader got a response baby. let's do this. Hitting callback:")
      console.log(res)
      cb()
    )
module.exports = VelocitasApiUploader
