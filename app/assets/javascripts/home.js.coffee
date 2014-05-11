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

resizeElement = ->
  $("span.fui-plus").click ->
    $( this )
      .removeClass "fui-plus"
      .addClass "fui-cross"
      .parent()
      .parent()
      .parent()
      .wrapAll "<div class='fullscreen' />"

    $('html, body').css({
      'overflow': 'hidden',
      'height': '100%'
    })

    $("span.fui-cross").click ->
      $( this )
        .removeClass "fui-cross"
        .addClass "fui-plus"
      $(".fullscreen").replaceWith -> 
        $(this).contents()
      $('html, body').css({
        'overflow': 'auto',
        'height': 'auto'
      })
      resizeElement()

$ ->
  # enableBSSwitch()
  changeIconOnCollapse()
  resizeElement()
