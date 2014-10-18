rewire = require "rewire"
DropboxUploader = rewire "../../services/DropboxUploader"
expect = require("chai").expect

describe "DropboxUploader", ->
  beforeEach ->

    DropboxUploader.__set__({
      Dropbox: {
        Client: {}
      }
    })

    @key = "abcd"
    @secret = "1234"
    @subject = new DropboxUploader(@key, @secret)
    @filePath = "test/fixtures/test.gpx"

  describe "#upload", ->
    # I can't mock Dropbox API that easily...
    xit "uploads to Dropbox, then calls complete callback", (done) ->
      @subject.upload(@filePath, done)

