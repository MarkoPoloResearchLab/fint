/* Time between each scrolling frame */
$.fn.dataTableExt.oPagination.iTweenTime = 100;
 
$.fn.dataTableExt.oPagination.scrolling = {
    "fnInit": function ( oSettings, nPaging, fnCallbackDraw )
    {
        var oLang = oSettings.oLanguage.oPaginate;
        var oClasses = oSettings.oClasses;
        var fnClickHandler = function ( e ) {
            if ( oSettings.oApi._fnPageChange( oSettings, e.data.action ) )
            {
                fnCallbackDraw( oSettings );
            }
        };
 
        var sAppend = (!oSettings.bJUI) ?
            '<a class="'+oSettings.oClasses.sPagePrevDisabled+'" tabindex="'+oSettings.iTabIndex+'" role="button">'+oLang.sPrevious+'</a>'+
            '<a class="'+oSettings.oClasses.sPageNextDisabled+'" tabindex="'+oSettings.iTabIndex+'" role="button">'+oLang.sNext+'</a>'
            :
            '<a class="'+oSettings.oClasses.sPagePrevDisabled+'" tabindex="'+oSettings.iTabIndex+'" role="button"><span class="'+oSettings.oClasses.sPageJUIPrev+'"></span></a>'+
            '<a class="'+oSettings.oClasses.sPageNextDisabled+'" tabindex="'+oSettings.iTabIndex+'" role="button"><span class="'+oSettings.oClasses.sPageJUINext+'"></span></a>';
        $(nPaging).append( sAppend );
 
        var els = $('a', nPaging);
        var nPrevious = els[0],
            nNext = els[1];
 
        oSettings.oApi._fnBindAction( nPrevious, {action: "previous"}, function() {
            /* Disallow paging event during a current paging event */
            if ( typeof oSettings.iPagingLoopStart != 'undefined' && oSettings.iPagingLoopStart != -1 )
            {
                return;
            }
 
            oSettings.iPagingLoopStart = oSettings._iDisplayStart;
            oSettings.iPagingEnd = oSettings._iDisplayStart - oSettings._iDisplayLength;
 
            /* Correct for underrun */
            if ( oSettings.iPagingEnd < 0 )
            {
                oSettings.iPagingEnd = 0;
            }
 
            var iTween = $.fn.dataTableExt.oPagination.iTweenTime;
            var innerLoop = function () {
                if ( oSettings.iPagingLoopStart > oSettings.iPagingEnd ) {
                    oSettings.iPagingLoopStart--;
                    oSettings._iDisplayStart = oSettings.iPagingLoopStart;
                    fnCallbackDraw( oSettings );
                    setTimeout( function() { innerLoop(); }, iTween );
                } else {
                    oSettings.iPagingLoopStart = -1;
                }
            };
            innerLoop();
        } );
 
        oSettings.oApi._fnBindAction( nNext, {action: "next"}, function() {
            /* Disallow paging event during a current paging event */
            if ( typeof oSettings.iPagingLoopStart != 'undefined' && oSettings.iPagingLoopStart != -1 )
            {
                return;
            }
 
            oSettings.iPagingLoopStart = oSettings._iDisplayStart;
 
            /* Make sure we are not over running the display array */
            if ( oSettings._iDisplayStart + oSettings._iDisplayLength < oSettings.fnRecordsDisplay() )
            {
                oSettings.iPagingEnd = oSettings._iDisplayStart + oSettings._iDisplayLength;
            }
 
            var iTween = $.fn.dataTableExt.oPagination.iTweenTime;
            var innerLoop = function () {
                if ( oSettings.iPagingLoopStart < oSettings.iPagingEnd ) {
                    oSettings.iPagingLoopStart++;
                    oSettings._iDisplayStart = oSettings.iPagingLoopStart;
                    fnCallbackDraw( oSettings );
                    setTimeout( function() { innerLoop(); }, iTween );
                } else {
                    oSettings.iPagingLoopStart = -1;
                }
            };
            innerLoop();
        } );
    },
 
    "fnUpdate": function ( oSettings, fnCallbackDraw )
    {
        if ( !oSettings.aanFeatures.p )
        {
            return;
        }
 
        /* Loop over each instance of the pager */
        var an = oSettings.aanFeatures.p;
        for ( var i=0, iLen=an.length ; i<iLen ; i++ )
        {
            if ( an[i].childNodes.length !== 0 )
            {
                an[i].childNodes[0].className =
                    ( oSettings._iDisplayStart === 0 ) ?
                    oSettings.oClasses.sPagePrevDisabled : oSettings.oClasses.sPagePrevEnabled;
 
                an[i].childNodes[1].className =
                    ( oSettings.fnDisplayEnd() == oSettings.fnRecordsDisplay() ) ?
                    oSettings.oClasses.sPageNextDisabled : oSettings.oClasses.sPageNextEnabled;
            }
        }
    }
};

jQuery.fn.dataTableExt.oApi.fnReloadAjax = function ( oSettings, sNewSource, fnCallback, bStandingRedraw ) {
  if ( typeof sNewSource != 'undefined' && sNewSource != null )
  {
    oSettings.sAjaxSource = sNewSource;
  }
  this.oApi._fnProcessingDisplay( oSettings, true );
  var that = this;
  var iStart = oSettings._iDisplayStart;
  var aData = [];

  this.oApi._fnServerParams( oSettings, aData );

  oSettings.fnServerData( oSettings.sAjaxSource, aData, function(json) {
    /* Clear the old information from the table */
    that.oApi._fnClearTable( oSettings );

    /* Got the data - add it to the table */
    var aData =  (oSettings.sAjaxDataProp !== "") ?
      that.oApi._fnGetObjectDataFn( oSettings.sAjaxDataProp )( json ) : json;

    for ( var i=0 ; i<aData.length ; i++ )
    {
      that.oApi._fnAddData( oSettings, aData[i] );
    }

    oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
    that.fnDraw();

    if ( typeof bStandingRedraw != 'undefined' && bStandingRedraw === true )
    {
      oSettings._iDisplayStart = iStart;
      that.fnDraw( false );
    }

    that.oApi._fnProcessingDisplay( oSettings, false );

    /* Callback user function - for event handlers etc */
    if ( typeof fnCallback == 'function' && fnCallback != null )
    {
      fnCallback( oSettings );
    }
  }, oSettings );
};

jQuery.fn.dataTableExt.oApi.fnSetFilteringDelay = function ( oSettings, iDelay ) {
  var _that = this;

  if ( iDelay === undefined ) {
    iDelay = 500;
  }
    
  this.each( function ( i ) {
    $.fn.dataTableExt.iApiIndex = i;
    var
      $this = this,
      oTimerId = null,
      sPreviousSearch = null,
      anControl = $( 'input', _that.fnSettings().aanFeatures.f );
    
      anControl.unbind( 'keyup' ).bind( 'keyup', function() {
      var $$this = $this;

      if (sPreviousSearch === null || sPreviousSearch != anControl.val()) {
        window.clearTimeout(oTimerId);
        sPreviousSearch = anControl.val(); 
        oTimerId = window.setTimeout(function() {
          $.fn.dataTableExt.iApiIndex = i;
          _that.fnFilter( anControl.val() );
        }, iDelay);
      }
    });
      
    return this;
  } );
  return this;
};
