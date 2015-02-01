GpxDownloader = require "../../services/GpxDownloader"
chai = require "chai"
expect = chai.expect
fs = require "fs"

describe "GpxDownloader", ->
  before ->
    @downloadPath = "uploads/sample.gpx"
    @linkUrl = "http://github.com/andrewhao/stravamailer/blame/master/sample.gpx"
    @subject = new GpxDownloader(@linkUrl)

  beforeEach ->
    fs.unlinkSync(@downloadPath) if fs.existsSync(@downloadPath)

  # Afterwards, clear out our fixture download
  afterEach ->
    fs.unlinkSync(@downloadPath) if fs.existsSync(@downloadPath)

  describe "#download", ->
    it "downloads to the uploads/ directory", (done) ->
      expect(fs.existsSync(@downloadPath)).to.be.false
      @subject.download(=>
        fs.exists(@downloadPath, (exists) ->
          expect(exists).to.be.true
        )
        done()
      )

    it "calls the finish callback with the downloaded file and original link", (done) ->
      @subject.download((uploadFile, link) =>
        expect(uploadFile).to.equal(@downloadPath)
        expect(link).to.equal(@linkUrl)
        done()
      )
