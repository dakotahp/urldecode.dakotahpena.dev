$ ->
  window.App = {}

  Backbone.history.start()
  # Determine and preserve hash for later
  currentHash = if window.location.hash == "" then "decode" else window.location.hash
  # Restore hash or use default
  window.location.hash = currentHash
  # Set correct button to active
  $("[role=toggle-#{currentHash.substr(1)}]").addClass("active")

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
      @input.trigger("input")

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
  )
  button_view = new ButtonView(
    el: $(".method-select")
  )


  #
  # Routing
  #
  App.Router =  Backbone.Router.extend(
    routes:
      "*method": "methodChange"
  )
  app_router = new App.Router
  app_router.on('route:methodChange', (method)->
    $("[role=input]").trigger("methodChange", [method])
  )


  $("[role=output]").click((event)->
    $(event.target).select()
  )

  $('[role=copy-to-clipboard]').zclip(
    path: '/swfs/zero-clipboard.swf'
    copy:->
      $("[role=output]").val()
  )
