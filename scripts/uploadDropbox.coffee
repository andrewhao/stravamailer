DropboxUploader = require "../services/DropboxUploader"
uploader = new DropboxUploader(process.env.DROPBOX_KEY, process.env.DROPBOX_SECRET)
uploader.upload("test/fixtures/test.gpx", ->
  console.log("woot done!")
)

