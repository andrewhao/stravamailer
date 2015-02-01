CartoDbUploader = require "../../services/CartoDbUploader"
expect = require("chai").expect
fakeweb = require("node-fakeweb")

describe "CartoDbUploader", ->
  beforeEach ->
    fakeweb.allowNetConnect = false
    @subject = new CartoDbUploader
  afterEach ->
    fakeweb.tearDown()

  describe "#upload", ->
    beforeEach ->
      @file = "foo file"
      @link = "http://share.abvio.com/5e3ba2f14c227d4b/Runmeter-Run-20150122-1205.gpx"
    it "sends a POST to the uploads endpoint", (done) ->
      api_key = process.env.CARTO_DB_API_KEY || "test_key"
      url = "https://velocitas.cartodb.com:443/api/v1/imports/?api_key=#{api_key}"
      fakeweb.registerUri({
        uri: url
        method: "POST"
      })
      @subject.upload(@file, @link, done)


