strava = require 'strava-v3'

# Takes a link to a GPX files and downloads it
class StravaUploader
  # @param [String] oauth The OAuth token of the authenticated user.
  constructor: (oauth) ->
    @oauth = oauth || process.env.STRAVA_PRIVATE_TOKEN

  # @param [String] gpxPath The string path to the GPX file.
  # @param [Function] cb The callback called when finished.
  upload: (gpxPath, cb) =>
    strava.uploads.post({
      "access_token": @oauth
      "data_type": "gpx",
      "file": gpxPath,
      "statusCallback": (err, payload) ->
        if err
          console.log "Error found: #{err}, #{payload}"
        else
          console.log "Still uploading: #{payload}"
    }, (err, payload) ->
      if err
        console.log "Error posting to the Strava API: #{err}, #{payload}"
      else
        console.log "Successful upload! #{payload}"
        cb()
    )

module.exports = StravaUploader
