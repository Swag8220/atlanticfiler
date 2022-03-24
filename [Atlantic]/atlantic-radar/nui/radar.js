/*-------------------------------------------------------------------------

    Wraith Radar System - v1.01
    Created by WolfKnight
    
-------------------------------------------------------------------------*/

var resourceName = ""; 
var radarEnabled = false; 
var targets = []; 

$( function() {
    radarInit();

    var radarContainer = $( "#policeradar" );

    var fwdArrowFront = radarContainer.find( ".fwdarrowfront" );
    var fwdArrowBack = radarContainer.find( ".fwdarrowback" );
    var bwdArrowFront = radarContainer.find( ".bwdarrowfront" );
    var bwdArrowBack = radarContainer.find( ".bwdarrowback" );

    var fwdSame = radarContainer.find( ".fwdsame" );
    var fwdOpp = radarContainer.find( ".fwdopp" );
    var fwdXmit = radarContainer.find( ".fwdxmit" );

    var bwdSame = radarContainer.find( ".bwdsame" );
    var bwdOpp = radarContainer.find( ".bwdopp" );
    var bwdXmit = radarContainer.find( ".bwdxmit" );

    var radarRCContainer = $( "#policeradarrc" ); 

    window.addEventListener( 'message', function( event ) {
        var item = event.data;

        if ( item.resourcename ) {
            resourceName = item.resourcename;
        }

        if ( item.toggleradar ) {
            radarEnabled = !radarEnabled; 
            radarContainer.fadeToggle();
        }

        if ( item.hideradar ) {
            radarContainer.fadeOut();
        } else if ( item.hideradar == false ) {
            radarContainer.fadeIn();
        }

        if ( item.patrolspeed ) {
            updateSpeed( "patrolspeed", item.patrolspeed );
        }

        if ( item.fwdspeed ) {
            updateSpeed( "fwdspeed", item.fwdspeed ); 
        }

        if ( item.fwdfast ) {
            updateSpeed( "fwdfast", item.fwdfast ); 
        }

        if ( item.lockfwdfast == true || item.lockfwdfast == false ) {
            lockSpeed( "fwdfast", item.lockfwdfast )
        }

        if ( item.bwdspeed ) {
            updateSpeed( "bwdspeed", item.bwdspeed );  
        }

        if ( item.bwdfast ) {
            updateSpeed( "bwdfast", item.bwdfast );    
        }

        if ( item.lockbwdfast == true || item.lockbwdfast == false ) {
            lockSpeed( "bwdfast", item.lockbwdfast )
        }
		
		if ( item.lockbwdfast == true ) {
			$( ".pause-icon" ).last().removeClass( "hide" );
        }
		
		if ( item.lockbwdfast == false ) {
            $( ".pause-icon" ).last().addClass( "hide" );
        }

        if ( item.fwddir || item.fwddir == false || item.fwddir == null ) {
            updateArrowDir( fwdArrowFront, fwdArrowBack, item.fwddir )
        }

        if ( item.bwddir || item.bwddir == false || item.bwddir == null ) {
            updateArrowDir( bwdArrowFront, bwdArrowBack, item.bwddir )
        }

        if ( item.fwdxmit ) {
            fwdXmit.addClass( "active" );
        } else if ( item.fwdxmit == false ) {
            fwdXmit.removeClass( "active" );
        }

        if ( item.bwdxmit ) {
            bwdXmit.addClass( "active" );   
        } else if ( item.bwdxmit == false ) {
            bwdXmit.removeClass( "active" );   
        }

        if ( item.fwdmode ) {
            modeSwitch( fwdSame, fwdOpp, item.fwdmode );
        }

        if ( item.bwdmode ) {
            modeSwitch( bwdSame, bwdOpp, item.bwdmode );
        }

        if ( item.toggleradarrc ) {
            radarRCContainer.toggle();
        }
		
		if ( item.fwdcarmodel ) {
			var fwdcarm = $(".fwdcarmodel").html();
			if( fwdcarm !== item.fwdcarmodel ) {
				$( ".fwdcarmodel" ).html( item.fwdcarmodel );
			}
		}
		
		if ( item.fwdfastcarmodel ) {
			var fwdcarfm = $(".fwdfastcarmodel").html();
			if( fwdcarfm !== item.fwdfastcarmodel ) {
				$( ".fwdfastcarmodel" ).html( item.fwdfastcarmodel );
			}
		}
		
		if ( item.fwdfastcarnumberplate ) {
			var fwdcarfm = $(".fwdfastcarnumberplate").html();
			if( fwdcarfm !== item.fwdfastcarnumberplate ) {
				$( ".fwdfastcarnumberplate" ).html( item.fwdfastcarnumberplate );
			}
        }

        if ( item.fwdcarnumberplate ) {
			var fwdcarnm = $(".fwdcarnumberplate").html();
			if( fwdcarnm !== item.fwdcarnumberplate ) {
				$( ".fwdcarnumberplate" ).html( item.fwdcarnumberplate );
			}
        }
        
        if ( item.bwdcarnumberplate ) {
			var bwdcarnm = $(".fwdcarnumberplate").html();
			if( bwdcarnm !== item.bwdcarnumberplate ) {
				$( ".bwdcarnumberplate" ).html( item.bwdcarnumberplate );
			}
        }
        
		
		if ( item.bwdcarmodel ) {
			var bwdcarm = $(".bwdcarmodel").html();
			if( bwdcarm !== item.bwdcarmodel ) {
				$( ".bwdcarmodel" ).html( item.bwdcarmodel );
			}
		}
		
		if ( item.bwdfastcarmodel ) {
			var bwdcarfm = $(".bwdfastcarmodel").html();
			if( bwdcarfm !== item.bwdfastcarmodel ) {
				$( ".bwdfastcarmodel" ).html( item.bwdfastcarmodel );
			}
		}
		
		if ( item.bwdfastcarnumberplate ) {
			var fwdcarfm = $(".bwdfastcarnumberplate").html();
			if( fwdcarfm !== item.bwdfastcarnumberplate ) {
				$( ".bwdfastcarnumberplate" ).html( item.bwdfastcarnumberplate );
			}
		}

        if ( item.changeLimit ) {
            if(item.changeLimit == "55") {
                $( ".limit1" ).last().addClass( "current" );
                $( ".limit2" ).last().removeClass( "current" );
                $( ".limit3" ).last().removeClass( "current" );
            }
            if(item.changeLimit == "85") {
                $( ".limit2" ).last().addClass( "current" );
                $( ".limit1" ).last().removeClass( "current" );
                $( ".limit3" ).last().removeClass( "current" );
            }
            if(item.changeLimit == "135") {
                $( ".limit3" ).last().addClass( "current" );
                $( ".limit2" ).last().removeClass( "current" );
                $( ".limit1" ).last().removeClass( "current" );
            }
        }
    } );
} )

function radarInit() {
    $( '.dashboard' ).each( function( i, obj ) {
        $( this ).find( '[data-target]' ).each( function( subi, subobj ) {
            targets[ $( this ).attr( "data-target" ) ] = $( this )
        } )
     } );

    $( "#policeradarrc" ).find( "button" ).each( function( i, obj ) {
        if ( $( this ).attr( "data-action" ) ) {
            $( this ).click( function() { 
                var data = $( this ).data( "action" ); 

                sendData( "RadarRC", data ); 
            } )
        }
    } );
}

function updateSpeed( attr, data ) {
    targets[ attr ].find( ".speednumber" ).each( function( i, obj ) {
        $( obj ).html( data ); 
    } ); 
}

function lockSpeed( attr, state ) {
    targets[ attr ].find( ".speednumber" ).each( function( i, obj ) {
        if ( state == true ) {
            $( obj ).addClass( "locked" ); 
        } else {
            $( obj ).removeClass( "locked" );
        }
    } ); 
}

function modeSwitch( sameEle, oppEle, state ) {
    if ( state == "same" ) {
        sameEle.addClass( "active" );
        oppEle.removeClass( "active" ); 
    } else if ( state == "opp" ) {
        oppEle.addClass( "active" );
        sameEle.removeClass( "active" ); 
    } else if ( state == "none" ) {
        oppEle.removeClass( "active" ); 
        sameEle.removeClass( "active" ); 
    }
}

function updateArrowDir( fwdEle, bwdEle, state ) {
    if ( state == true ) {
        fwdEle.addClass( "active" ); 
        bwdEle.removeClass( "active" ); 
    } else if ( state == false ) {
        bwdEle.addClass( "active" ); 
        fwdEle.removeClass( "active" ); 
    } else if ( state == null ) {
        fwdEle.removeClass( "active" ); 
        bwdEle.removeClass( "active" ); 
    }
}

function sendData( name, data ) {
    $.post( "http://" + resourceName + "/" + name, JSON.stringify( data ), function( datab ) {
        if ( datab != "ok" ) {
            console.log( datab );
        }            
    } );
}