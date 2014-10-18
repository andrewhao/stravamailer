StravaUploader = require "../../services/StravaUploader"

describe "StravaUploader", ->
  beforeEach ->
    @gpxPath = "test/fixtures/test.gpx"
    @oauth = null
    @subject = new StravaUploader(@oauth)

  describe "#upload", ->
    it "uploads", (done) ->
      @subject.upload(@gpxPath, done)

    xit "grabs the GPX and sends to the corresponding API", ->
      expect(stravaApi).to.receive(@gpxPath)
