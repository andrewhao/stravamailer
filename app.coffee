nconf = require "nconf"
nodemailer = require "nodemailer"
express = require "express"
Mailer = require "./models/Mailer"
GpxDownloader = require "./services/GpxDownloader"
EmailParser = require "./services/EmailParser"
IncomingMessage = require "./models/IncomingMessage"

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
app.use("/uploads", express.static('uploads'))
app.use("/uploads", express.directory('uploads'))
app.use(express.logger())
app.use(express.bodyParser())

app.get('/', (request, response) ->
  response.send("We're coming soon!")
)
app.post("/incoming", (request, response) ->
  im = new IncomingMessage(request.body)
  console.log "from: #{im.from()}"
  console.log "body: #{im.body()}"
  parser = new EmailParser(im.body())

  # In the future, we should queue this bad boy up.
  gpx = new GpxDownloader(parser.gpxLink())
  gpx.download()
  response.send("OK")
)

port = nconf.get("PORT") || 5000

console.log "port is #{port}"


app.listen(port, ->
  console.log "listening on #{port}"
)


