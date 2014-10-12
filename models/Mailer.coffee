class Mailer
  # @param {Transport} nodemailer Transport object
  constructor: (@transport) ->

  src: "andrewhao@gmail.com"
  dst: "upload@strava.com"

  sendMail: (subject="", message="", attachmentPath="sample.gpx") ->
    mailOptions =
      from: @src
      to: @dst
      subject: subject
      text: message
      attachments: [
        {
          filePath: attachmentPath
        }
      ]

    @transport.sendMail(mailOptions, (error, response) =>
      if (error)
        console.log(error)
      else
        console.log("message sent: #{response.message}")
        @transport.close()
    )
module.exports = Mailer
