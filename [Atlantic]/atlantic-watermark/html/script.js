window.addEventListener('message', (event) => {
  switch (event.data.type) {
    case 'update':
      $('.server-dato').text(moment().format(`DD/MM/YYYY HH:mm:ss`))

      $('.server-maxCount').text(event.data.serverMaxCount)
      $('.server-playerCount').text(event.data.serverPlayerCount)
      $('.player-id').text(event.data.playerId)
    break;

    case 'toggle':
      if (event.data.toggle) {
        $('body').show()
      } else {
        $('body').hide()
      }
    break;
  }
});