# omik_polititablet Lavet af OMikkel#3217
**______________________________**

## Dependencies

- **#1** esx_extended

- **#2** esx_identity

- **#3** esx_policejob

- **#4** pNotify

## Installation

**Tutorial:** https://youtu.be/Rv2HHK0TmZs

- **#1** Start resourcen i din resources CFG (start omik_polititablet)

- **#2** Kør alle sql filerne i din database

- **#3** Opret bøder mm i databasen

- **#4** Tilpas configgen til dine behov

- **#5** Lav din første account ved at smide det her ind i SQL under omik_polititabletan og ændre selvfølgelig i de forskellige ting så de passer 

```sql
INSERT INTO `omik_polititabletan` (`id`, `identifier`, `name`, `phone`, `profileLogo`, `rank`, `extraRank`, `badgeNumber`, `password`, `ranks`, `certs`) VALUES (NULL, 'steam:110000143260808', 'Andreas Andersen', '39643859', 'https://i.imgur.com/DGW6ZHZ.png', 'Ledelse', 'Ingen', '10-01', PASSWORD("1234"), "[]", "[]")
```

- **#6** Genstart serveren

- **#7** Jeg kan kontaktes på Discord: OMikkel#3217 angående fejl og evt spørgsmål.

### DET ER ABSOLUT FORBUDT OG STRAFBART AT VIDEREGIVE SCRIPTET: OMIK_POLITITABLET

## GOD FORNØJELSE MED SCRIPTET, KONTAKT MIG HER:
## Email: OMikkel@omikkel.com
## Discord: https://www.omikkel.com/discord
## Kontakt: OMikkel#3217