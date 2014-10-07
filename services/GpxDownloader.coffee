http = require "http"
fs = require "fs"

# Takes a link to a GPX files and downloads it
class GpxDownloader
  constructor: (@link) ->

  basePath: "uploads"

  dest: ->
    parts = @link.split("/")
    filename = parts.pop()
    path = "#{@basePath}/#{filename}"
    path

  download: (cb) ->
    file = fs.createWriteStream(@dest())
    request = http.get(@link, (response) ->
      response.pipe file
      file.on "finish", ->
        file.close cb
    )

module.exports = GpxDownloader
