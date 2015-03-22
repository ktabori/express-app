express    = require("express")
bodyParser = require("body-parser")
assets     = require("connect-assets")
stylus     = require("stylus")
nib        = require("nib")
glob       = require("glob")

# App specific configs
app = express()
app.use(bodyParser.urlencoded(extended: false))
app.use(bodyParser.json())
app.set("views", "#{__dirname}/views")
app.set("view engine", "jade")
app.use(express.static("#{__dirname}/public"))

# Automatic assets
assets().environment.getEngines(".styl").configure (s) -> s.use(nib())
app.use assets(
  paths: ["vendor/assets/js/before", "assets/js", "assets/css", "vendor/assets/js/after", "vendor/assets/css"]
  buildDir: if process.env.NODE_ENV is "production" then "build/assets" else false
)

# Load pages -> Start listening
glob "#{__dirname}/pages/**/*.coffee", (error, files = []) ->
  for file in files
    require(file)(app, express)

  port = process.env.PORT || 3000
  app.listen(port)
  console.log "Listening on port #{port.toString()}"