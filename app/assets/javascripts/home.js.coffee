enableBSSwitch = ->
  $("[data-toggle='switch']")
    .wrap('<div class="switch" />')
    .parent()
    .bootstrapSwitch()

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

$ ->
  # enableBSSwitch()
  changeIconOnCollapse()
