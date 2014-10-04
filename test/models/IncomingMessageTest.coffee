IncomingMessage = require "../../models/IncomingMessage"
chai = require "chai"
expect = chai.expect

describe "IncomingMessage", ->
  beforeEach ->
    json = {
      envelope: ""
      headers: {
        "From": "source@gmail.com"
      }
      plain: "message body"
      attachments: ""
    }
    @subject = new IncomingMessage(json)
  describe "#body", ->
    it "returns the body", ->
      console.log @subject

      expect(@subject.body()).to.equal("message body")
  describe "#from", ->
    it "returns the sender email", ->
      expect(@subject.from()).to.equal("source@gmail.com")

