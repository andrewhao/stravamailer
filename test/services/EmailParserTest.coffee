chai = require "chai"
expect = chai.expect
EmailParser = require "../../services/EmailParser"

describe "EmailParser", ->
  beforeEach ->
    @expectedGpx = "http://runmeter.com/123abc/gpxFile.gpx"
    message = """
    Nice run!
    GPX File: #{@expectedGpx}
    """
    @subject = new EmailParser(message)

  describe "#gpxLink", ->
    it "extracts the GPX link from the email body", ->
      console.log "gpx link: #{@subject.gpxLink()}"
      expect(@subject.gpxLink()).to.equal(@expectedGpx)
    it "returns null for a email message with no link", ->
      p = new EmailParser("no link here")
      console.log "gpx link: #{p.gpxLink()}"
      expect(p.gpxLink()).to.be.null
