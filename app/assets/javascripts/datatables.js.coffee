$.fn.bootstrapDataTable = (options = {}) ->
  options['sDom'] or= "<'row'<'col-xs-6'i><'col-xs-2'r><'col-xs-4'f>>t<'row'<'.col-xs-offset-6 col-xs-6'p>>"
  options['sPaginationType'] or= 'bootstrap'
  options['bProcessing'] or= true
  options['oLanguage'] or= {"sProcessing": '<span class="label label-info">Processing...</span>' }
  options['sAjaxSource'] or= (this.data('source') ? this.data('source'))
  # options['scrollX'] or= false

  this.dataTable(options).fnSetFilteringDelay()