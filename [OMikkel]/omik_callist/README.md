# omik_callist Lavet af OMikkel#3217
**______________________________**

## Installation

**Tutorial:** https://youtu.be/5ZCT-_DnqJo

- **#1** Start resourcen i din resources CFG (start omik_callist)

- **#2** Gå ned og find EVENTS

- **#3** Find det rette event (Server > Server eller Client > Server)

- **#4** Gå ind i den resource som skal trigger en afsending af et opkald til politiet eller ems og erstat functionen med det event du fandt i step #3

- **#5** Udfyld felterne i eventet det er VIGTIGT du får source med

- **#6** Tilpas config.lua til dine behov, husk det er vigtigt med en unik permission fx police.callist, ellers vil staff i nogle tilfælde blive spammet med notifikationer :D

- **#5** Genstart serveren

- **#6** Jeg kan kontaktes på Discord: OMikkel#3217 angående fejl og evt spørgsmål.

- **#7** Husk at sætte din licensekey i licensekey.lua


## Nødvendige snippets

gcphone > server > esxaddonsgcphone-s.lua i gcPhone:sendMessage eventet https://i.imgur.com/ZINfA6Q.png
```lua
    if number and message then
      TriggerEvent("omik_callist:addTable", tostring(sourcePlayer), message, number)
    end
```
s
## Events
- **#1** (Server > Server) TriggerEvent("omik_callist:addTable", tostring(source), message, number)

- **#2** (Client > Server) TriggerServerEvent("omik_callist:addTable", tostring(source), message, number)

## Logo
Logoet skal have en størrelse af `96x96` ellers ser det mærkeligt ud

### DET ER ABSOLUT FORBUDT OG STRAFBART AT VIDEREGIVE SCRIPTET: OMIK_CALLIST

## GOD FORNØJELSE MED SCRIPTET, KONTAKT MIG HER:
## Email: OMikkel@omikkel.com
## Discord: https://www.omikkel.com/discord
## Kontakt: OMikkel#3217