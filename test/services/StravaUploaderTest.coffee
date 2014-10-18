rewire = require "rewire"
StravaUploader = rewire "../../services/StravaUploader"
expect = require("chai").expect

describe "StravaUploader", ->
  beforeEach ->
    # Set up a mock Strava upload interface
    StravaUploader.__set__({
      strava: {
        uploads: {
          post: (options, cb) ->
            console.log("fake API called")
            cb()
        }
      }
    })

    @gpxPath = "test/fixtures/test.gpx"
    @oauth = "abcd"
    @subject = new StravaUploader(@oauth)

  describe "#oauth", ->
    it "takes the given oauth token if no ENV var.", ->
      expect(@subject.oauth).to.equal(@oauth)

  describe "#upload", ->
    it "uploads and calls finish callback", (done) ->
      @subject.upload(@gpxPath, done)

