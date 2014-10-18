de = require 'dotenv'
de.load

StravaUploader = require "../services/StravaUploader"

su = new StravaUploader()
su.upload("test/fixtures/test.gpx", ->
  console.log("done!")
)
