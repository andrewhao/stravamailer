StravaUploader = require "../../services/StravaUploader"

describe "StravaUploader", ->
  beforeEach ->
    @gpxPath = "fixtures/test.gpx"
    @subject = new StravaUploader(@gpxPath)

  describe "#upload", ->
    xit "grabs the GPX and sends to the corresponding API", ->
      expect(stravaApi).to.receive(@gpxPath)
