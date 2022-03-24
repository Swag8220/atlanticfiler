$(function() {
  moment.locale('da-DK');
  function iniciarHorario() {
    document.getElementById('horario').innerHTML = "<h3>" + moment().format(`DD/MM @ HH:mm`) +  "</h3>";
    t = setTimeout(function() {
      iniciarHorario()
    }, 500);
  }
  iniciarHorario();

window.addEventListener("message", function(event) {
  $("#playersText").text(event.data.players);
  if (event.data.showmark) $( ".horario-wrapper" ).show();
  else $( ".horario-wrapper" ).hide();
})
});
