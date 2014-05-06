enableBSSwitch = ->
  $("[data-toggle='switch']")
    .wrap('<div class="switch" />')
    .parent()
    .bootstrapSwitch()

$ ->
 enableBSSwitch()
