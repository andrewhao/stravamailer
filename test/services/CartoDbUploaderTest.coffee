CartoDbUploader = require "../../services/CartoDbUploader"
expect = require("chai").expect
fakeweb = require("node-fakeweb")

describe "CartoDbUploader", ->
  beforeEach ->
    fakeweb.allowNetConnect = false
    @file = "foo file"
    @link = "http://share.abvio.com/5e3ba2f14c227d4b/Runmeter-Run-20150122-1205.gpx"
    @subject = new CartoDbUploader(@file, @link)
  afterEach ->
    fakeweb.tearDown()

  it "sends a POST to the uploads endpoint", (done) ->
    api_key = "64aa46209fd4374742178748e6ec3f849e48b61f"
    url = "https://velocitas.cartodb.com/api/v1/imports/?api_key=#{api_key}"
    fakeweb.registerUri({
      headers: "Content-Type: application/json"
      uri: url
      method: "POST"
      body: 'FAKE RESPONSE: {"url": "' + @link + '"}'
    })
    @subject.upload(done)


