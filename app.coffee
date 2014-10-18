nconf = require "nconf"
nodemailer = require "nodemailer"
express = require "express"
strava = require "strava-v3"

# Load app files and settings.
Mailer = require "./models/Mailer"
GpxDownloader = require "./services/GpxDownloader"
EmailParser = require "./services/EmailParser"
IncomingMessage = require "./models/IncomingMessage"
StravaUploader = require "./services/StravaUploader"
DropboxUploader = require "./services/DropboxUploader"

# Load environment vars from .env file.
dotenv = require 'dotenv'
dotenv.load()

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

mailer = new Mailer(smtpTransport)

app = express()
app.use(express.logger())
app.use(express.bodyParser())

app.get('/', (request, response) ->
  url = strava.oauth.getRequestAccessURL({scope:"view_private write"})
  response.send("<a href='#{url}'>Log in with Strava</a>")
)

# OAuth callback endpoint for Strava.
app.get("/strava_oauth", (request, response) ->
  code = request.param('code')
  strava.oauth.getToken(code, (err,payload) ->
    console.log(payload)
    response.send(payload)
  )
)

app.post("/incoming", (request, response) ->
  im = new IncomingMessage(request.body)
  console.log "from: #{im.from()}"
  console.log "body: #{im.body()}"
  parser = new EmailParser(im.body())

  # In the future, we should queue this bad boy up.
  gpx = new GpxDownloader(parser.gpxLink())
  key = process.env.DROPBOX_KEY
  secret = process.env.DROPBOX_SECRET
  token = process.env.DROPBOX_SECRET_TOKEN
  dropboxUploader = new DropboxUploader(key, secret, token)
  stravaUploader = new StravaUploader
  gpx.download((filePath) ->
    dropboxUploader.upload(filePath, ->
      stravaUploader.upload(filePath, ->
        mailer.sendMail("hello", "gpx file attached", filePath)
      )
    )
  )
  response.send("OK")
)

port = nconf.get("PORT") || 5000

console.log "port is #{port}"


app.listen(port, ->
  console.log "listening on #{port}"
)

