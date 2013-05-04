window.App = {}

App.Router =  Backbone.Router.extend(
  routes:
    "*method": "methodChange"
)

app_router = new App.Router
app_router.on('route:methodChange', (method)->
  $("[role=io-view]").trigger("methodChange", [method])
)

Backbone.history.start()

MainView = Backbone.View.extend(
  inputField: null
  outputField: null
  method: null
  events:
    "input [role=input]": "renderOutput"
    "methodChange": "onMethodChange"
  initialize: ->
    @method = "decode"
    @input = $("[role=input]")
    @output = $("[role=output]")

  renderOutput: ->
    parsedValue = if @method is "decode" then Url.decode(@input.val()) else Url.encode(@input.val())
    @output.val(parsedValue)

  onMethodChange: (event, data)->
    @method = data
    console.log "New method:" + @method

)

main_view = new MainView(
  el: $("[role=io-view]")
)
