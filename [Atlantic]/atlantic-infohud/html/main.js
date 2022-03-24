
var rgbStart = [139,195,74]
var rgbEnd = [183,28,28]

$(function(){
	window.addEventListener('message', function(event) {
		if (event.data.action == "setValue"){
			if (event.data.key == "job"){
				setJobIcon(event.data.icon)
			}
			setValue(event.data.key, event.data.value)
		}else if (event.data.action == "toggle"){
			if (event.data.show){
				$('#ui').show();
			} else{
				$('#ui').hide();
			}
		}else if (event.data.action == 'remValue'){
			remValue(event.data.key)
		}
	});

});

function setValue(key, value){
	if (key == 'societymoney') {
		$('#'+key).html('<div class="stat"><div class="icon"><img src="img/dollar.png"></div><span style="color: #fbd734;">'+ value +'</span></div>')
	}else{
		$('#'+key+' span').html(value)
	}
}

function remValue(key){
	$('#'+key).html('')
}

function setJobIcon(value){
	$('#job img').attr('src', 'img/jobs/'+value+'.png')
}

function setProximity(value){
	var color;
	var speaker;
	if (value == "whisper"){
		color = "#FFEB3B";
		speaker = 1;
	}else if (value == "normal"){
		color = "#039BE5"
		speaker = 2;
	}else if (value == "shout"){
		color = "#e53935"
		speaker = 3;

	}
	$('#voice .bg').css('background-color', color);
	$('#voice img').attr('src', 'img/speaker'+speaker+'.png');
}	

function setTalking(value){
	if (value){
		//#64B5F6
		$('#voice').css('border', '3px solid #03A9F4')
	}else{
		//#81C784
		$('#voice').css('border', 'none')
	}
}

//API Shit
function colourGradient(p, rgb_beginning, rgb_end){
    var w = p * 2 - 1;

    var w1 = (w + 1) / 2.0;
    var w2 = 1 - w1;

    var rgb = [parseInt(rgb_beginning[0] * w1 + rgb_end[0] * w2),
        parseInt(rgb_beginning[1] * w1 + rgb_end[1] * w2),
            parseInt(rgb_beginning[2] * w1 + rgb_end[2] * w2)];
    return rgb;
};