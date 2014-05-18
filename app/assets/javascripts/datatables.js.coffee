$.fn.bootstrapDataTable = (options = {}) ->
  options['sDom'] or= "<'row'<'col-xs-6'l><'col-xs-6'f>r>t<'row'<'col-xs-6'i><'col-xs-6'p>>"
  options['sPaginationType'] or= 'bootstrap'
  options['bProcessing'] or= true
  options['oLanguage'] or= {"sProcessing": '<span class="label label-info">Processing...</span>' }
  options['sAjaxSource'] or= (this.data('source') ? this.data('source'))

  this.dataTable(options).fnSetFilteringDelay()