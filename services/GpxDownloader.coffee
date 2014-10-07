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

  # @param [Function] cb The callback called when finished that
  #   takes an argument to the file path of the newly downloaded file.
  download: (cb) ->
    file = fs.createWriteStream(@dest())
    request = http.get(@link, (response) =>
      response.pipe file
      file.on "finish", =>
        file.close =>
          cb(@dest())
    )

module.exports = GpxDownloader
