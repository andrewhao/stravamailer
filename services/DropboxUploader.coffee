Dropbox = require "dropbox"
util = require "util"
fs = require "fs"

class DropboxUploader
  constructor: (@key, @secret, @token)->
    @token = token || process.env.DROPBOX_SECRET_TOKEN
    console.log "Dropbox Uploader initialized with token #{@token}"

  authDriver: ->
    @authDriver ||= new Dropbox.AuthDriver.NodeServer(8191)

  client: ->
    client = new Dropbox.Client(
      key: @key
      secret: @secret
      token: @token
    )
    client.authDriver(@authDriver())
    client

  # List all files in user's "/Velocitas GPX" directory
  listFiles: ->
    console.log "Authenticated: #{@client().isAuthenticated()}"
    @client().readdir("/", (err, entries) =>
      return @showError(err) if err

      console.log(entries.join(', '))
    )

  # Send a file up to Dropbox.
  upload: (filePath, doneCb) ->
    nameParts = filePath.split("/")
    fileName = nameParts[nameParts.length - 1]
    fs.readFile(filePath, (err, data) =>
      return @showError(err) if err

      @client().writeFile(fileName, data, (err, stat) =>
        return @showError(err) if err
        console.log(util.inspect(stat))
        doneCb()
      )
    )

  showError: (error) ->
    console.log(util.inspect(error))
    return false

  performAuthentication: ->
    @client().authenticate((error, client) ->
        if (error)
          # Replace with a call to your own error-handling code.
          #
          # Don't forget to return from the callback, so you don't execute the code
          # that assumes everything went well.
          console.log "Unable to authenticate Dropbox"
          console.log util.inspect(error)
          console.log util.inspect(client)
          return false
        else
          # Replace with a call to your own application code.
          #
          # The user authorized your app, and everything went well.
          # client is a Dropbox.Client instance that you can use to make API calls.
          console.log "Successfully authenticated with Dropbox! #{util.inspect(client)}"
    )


module.exports = DropboxUploader
