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

)
main_view = new MainView(
  el: $("[role=io-view]")
)

ButtonView = Backbone.View.extend(
  elements: null
  events:
    "click .button": "onClick"
  initialize: ->
    @elements = @$(".button")

  onClick: (event)->
    @elements.removeClass("active")
    $(event.target).addClass("active")
    $("[role=input]").trigger("input")
)
button_view = new ButtonView(
  el: $(".method-select")
)

$("[role=output]").click((event)->
  $(event.target).select()
)

$('[role=copy-to-clipboard]').zclip(
  path: '/swfs/zero-clipboard.swf'
  copy:->
    $('input#dynamic').val()
)
