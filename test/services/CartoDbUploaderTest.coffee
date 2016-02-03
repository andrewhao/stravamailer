CartoDbUploader = require "../../services/CartoDbUploader"
expect = require("chai").expect
nock = require('nock')

describe "CartoDbUploader", ->
  beforeEach ->
    @subject = new CartoDbUploader('testkey')
  afterEach ->

  describe "#upload", ->
    beforeEach ->
      @file = "foo file"
      @link = "http://share.abvio.com/5e3ba2f14c227d4b/Runmeter-Run-20150122-1205.gpx"
    it "sends a POST to the uploads endpoint", (done) ->
      nock("https://velocitas.cartodb.com")
        .post("/api/v1/imports/?api_key=testkey")
        .reply(200)
      @subject.upload(@file, @link, done)

