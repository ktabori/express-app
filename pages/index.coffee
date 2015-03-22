module.exports = exports = (app, express) ->
  app.get "/", (req, res) ->
    res.render("index", title: "Home", pageName: "index")
