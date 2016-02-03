VelocitasApiUploader = require "../../services/VelocitasApiUploader"
expect = require("chai").expect
nock = require('nock')

describe "VelocitasApiUploader", ->
  beforeEach ->
    @subject = new VelocitasApiUploader

  describe "#upload", ->
    beforeEach ->
      @file = "foo file"
      @link = "http://share.abvio.com/5e3ba2f14c227d4b/Runmeter-Run-20150122-1205.gpx"
    it "sends a POST to the uploads endpoint", (done) ->
      nock("https://velocitas.herokuapp.com")
        .post("/api/v1/tracks")
        .reply(200)
      @subject.upload(@file, @link, done)


