VelocitasApiUploader = require "../../services/VelocitasApiUploader"
expect = require("chai").expect
fakeweb = require("node-fakeweb")

describe "VelocitasApiUploader", ->
  beforeEach ->
    fakeweb.allowNetConnect = false
    console.log VelocitasApiUploader
    @subject = new VelocitasApiUploader
  afterEach ->
    fakeweb.tearDown()

  describe "#upload", ->
    beforeEach ->
      @file = "foo file"
      @link = "http://share.abvio.com/5e3ba2f14c227d4b/Runmeter-Run-20150122-1205.gpx"
    it "sends a POST to the uploads endpoint", (done) ->
      url = "http://velocitas.g9labs.com:80/api/v1/tracks"
      fakeweb.registerUri({
        uri: url
        method: "POST"
      })
      @subject.upload(@file, @link, done)


