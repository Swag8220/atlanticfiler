PerformHttpRequest('https://discord.com/api/webhooks/883406860705738821/d5OLSuZb0EcCnfPEgUavkJb8hgEK_W_YqNFr4Mer-TtNsgZKPvv1UhKkiTgvilLiDQXM', function(err, text, headers) end, 'POST', json.encode(
    {
        username = "Atlantic - Drift",
        embeds = {
            {              
              title = "Serveren er lige blevet åbnet!";
              description = "Forbind til serveren med IP:**\n**```connect cfx.re/join/39dokb```";
              color = 359935;
              footer = {
                text = "Tak fordi du valgte Atlantic"
              }
            }
        }
    }), { ['Content-Type'] = 'application/json' })