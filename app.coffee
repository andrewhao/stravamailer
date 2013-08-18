nconf = require "nconf"
nodemailer = require "nodemailer"
express = require "express"

# Pull arguments off the command line and the environment.
nconf.argv().env()

smtpTransport = nodemailer.createTransport("SMTP",
  service: nconf.get("EMAIL_SERVICE")
  auth:
    user: nconf.get("EMAIL_USERNAME")
    pass: nconf.get("EMAIL_PASSWORD")
)

console.log nconf.get("EMAIL_SERVICE")
console.log nconf.get("EMAIL_USERNAME")
console.log nconf.get("EMAIL_PASSWORD")

app = express()

app.use(express.logger())

app.get('/', (request, response) ->
  response.send("We're coming soon!")
)

port = nconf.get("PORT") || 5000

console.log "port is #{port}"
app.listen(port, ->
  console.log "listening on #{port}"
)

mailOptions =
  from: "andrewhao@gmail.com"
  to: "andrewhao@gmail.com"
  subject: "stravaizer test"
  text: "This is a test from: #{new Date().toISOString()}"
  attachments: [
    {
      filePath: "sample.gpx"
    }
  ]

sendMail = ->
  smtpTransport.sendMail(mailOptions, (error, response) ->
    if (error)
      console.log(error)
    else
      console.log("message sent: #{response.message}")
      smtpTransport.close()
  )


