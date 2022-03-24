$('document').ready(function() {
    alerts = {};
    
    window.addEventListener('message', function (event) {
        ShowNotif(event.data);
    });

    function ShowNotif(data) {
        var $notification = CreateNotification(data);
        $('.notif-container').append($notification);
        setTimeout(function() {
            $.when($notification.fadeOut()).done(function() {
                $notification.remove()
            });
        }, data.length != null ? data.length : 2500);
    }

    function CreateNotification(data) {
        var $notification = $(document.createElement('div'));
        //$notification.addClass('notification').addClass(data.type);
        $notification.addClass('notification').addClass(data.style);
        //$notification.html(data.text);
        if(data.info["vehicle"] != undefined) {
            $notification.html('\
            <div class="content">\
            <div id="code">' + data.info["code"] + '</div>\
            <div id="alert-name">' + data.info["name"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            <div id="alert-model"><i class="fas fa-car-side"></i>' + data.info["vehicle"]["model"] + ' <i class="fas fa-closed-captioning"></i>' + data.info["vehicle"]["plate"] + '</div>\
            <div id="alert-color"><i class="fas fa-palette"></i>' + data.info["vehicle"]["primarycolor"] + ' med ' + data.info["vehicle"]["secondcolor"] + '</div>\
            </div>'
            );
        } else if(data.info["text"] != undefined) {
            $notification.html('\
            <div class="content">\
            <div id="code">' + data.info["code"] + '</div>\
            <div id="alert-name">' + data.info["name"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-user"></i>' + data.info["text"] + '</div>\
            <div id="alert-color"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            </div>'
            );
        } else {
            $notification.html('\
            <div class="content">\
            <div id="code">' + data.info["code"] + '</div>\
            <div id="alert-name">' + data.info["name"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            </div>');
        }

        $notification.fadeIn();
        if (data.style !== undefined) {
            Object.keys(data.style).forEach(function(css) {
                $notification.css(css, data.style[css])
            });
        }
        return $notification;
    }

    alerts.BaseAlert = function(style, info) {
        switch(style) {
            case 'ems':
               alerts.EMSAlert(info)
            break;
            case 'police':
                alerts.PoPo(info)
            break;
        }
    };

    alerts.PoPo = function(info) {
        if(data.vehicle != null) {
            $notification.html('\
            <div class="content">\
            <div id="code">' + info["code"] + '</div>\
            <div id="alert-name">' + info["name"] + '</div>\
            <div id="alert-model">' + info["vehicle"]["model"] + info["vehicle"]["plate"] + '</div>\
            <div id="alert-color">' + info["vehicle"]["primarycolor"] + info["vehicle"]["secondcolor"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + info["loc"] + '</div>\
            </div>').fadeIn(1000);
        } else {
            $notification.html('\
            <div class="content">\
            <div id="code">' + info["code"] + '</div>\
            <div id="alert-name">' + info["name"] + '</div>\
            <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + info["loc"] + '</div>\
            </div>').fadeIn(1000);
        }
        
        setTimeout(HideAlert, 4500);
    };

    alerts.EMSAlert = function(info) {
        //console.log(info["code"])
        $('.alerts-wrapper').html('\
        <div class="alerts ems">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-skull-crossbones"></i> ' + info["loc"] + '</div>\
        </div>').fadeIn(1000);
        
        setTimeout(HideAlert, 4500);
    };

    function HideAlert() {
        $('.alerts-wrapper').fadeOut(1000);
    };
});