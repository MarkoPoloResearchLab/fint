enableBSSwitch = ->
  $("[data-toggle='switch']")
    .wrap('<div class="switch" />')
    .parent()
    .bootstrapSwitch()

enableTooltips = ->
  $("[data-toggle='tooltip']")
    .tooltip()

changeIconOnCollapse = ->
  $(".panel-collapse.collapse.in").on 'hidden.bs.collapse', ->
    $(this)
      .parent()
      .find "span.fui-arrow-right"
      .removeClass "fui-arrow-right"
      .addClass "fui-arrow-left"
  $(".panel-collapse.collapse.in").on 'shown.bs.collapse', ->
    $(this)
      .parent()
      .find "span.fui-arrow-left"
      .removeClass "fui-arrow-left"
      .addClass "fui-arrow-right"

resizeElement = ->
  $("span.fui-plus").click ->
    panel = $(this)
      .removeClass "fui-plus"
      .addClass "fui-cross"
      .parents().eq(3)
    panel.before "<div class='placeholder' />"
    $(".dashboard").before panel
    $(".dashboard").hide()
    resizeElement()

  $("span.fui-cross").click ->
    panel = $(this)
      .removeClass "fui-cross"
      .addClass "fui-plus"
      .parents().eq(3)
    $(".placeholder").replaceWith ->
      panel
    $(".dashboard").show()
    resizeElement()

$ ->
  # enableBSSwitch()
  enableTooltips()
  changeIconOnCollapse()
  resizeElement()
