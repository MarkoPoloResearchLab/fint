enableBSSwitch = ->
  $("[data-toggle='switch']")
    .wrap('<div class="switch" />')
    .parent()
    .bootstrapSwitch()

enableBSDataTable = ->
  $('.data-tabled').bootstrapDataTable()
  largeTable = $('.large-data-tabled').bootstrapDataTable
    sDom: "<'row'<'col-xs-5'l><'col-xs-2'r><'col-xs-5'f>>t<'row'<'col-xs-6'i><'col-xs-6'p>>"
    scrollX: true
    sPaginationType: "bootstrap"
    # sPaginationType: "bootstrap"
    pagingType: "scrolling"
    # pagingType: "bootstrap"

enableTooltips = ->
  $("[data-toggle='tooltip']")
    .tooltip()

# moveFilter = ->
#   $('.dataTables_filter').append

selectSubMenu = ->
  $('.horizontal-menu .column-and-a-half').click ->
    $('.horizontal-menu .column-and-a-half').removeClass 'selected'
    $(this).addClass "selected"

changePaginationStyle = ->
  $('.data-tabled, .large-data-tabled').on 'draw.dt', ->
    $('.dataTables_paginate ul')
      .addClass 'pagination-plain'
      .parent().removeClass 'pagination'

enableFixedHeaders = ->
  $('table.fixed-headers')
    .prepFixedHeader()
    .fixedHeader()

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

changeViewMenuCaret = ->
  $('table .dropdown').on 'hide.bs.dropdown show.bs.dropdown',  (e)-> 
    $( e.relatedTarget ).toggleClass('fui-play').toggleClass('caret');

$(document).on "ajax:complete page:change load", ->
  selectSubMenu()
  enableTooltips()
  changeIconOnCollapse()
  resizeElement()
  changePaginationStyle()
  enableBSDataTable()
  # enableFixedHeaders()
  changeViewMenuCaret()
