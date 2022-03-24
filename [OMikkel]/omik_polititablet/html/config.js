var config = {
    employeeRanks: {
        "Ledelse": [], // Vigtigt den her er øverste rank // ADMIN RANK // Alle admin ting
        "Chefpolitiinspektør": [], // Vigtigt den her er anden øverste rank // SEMI-ADMIN RANK // Rediger opslag, Administrer Efterlysninger, Administrer Efterlystekøretøjer
        "Afdelingschef": [],
        "Politiinspektør": [],
        "Vicepolitiinspektør": [],
        "Politiassistent 1. grad": [],
        "Politiassistent": [],
        "Politibetjent": [],
        "Politikadet": [],
    },
    extraRanks: [
        "Rigspolitichef",
        "Politidirektør",
        "Politimester",
        "Stabschef",
        "Politikommisær",
        "AKS-Leder",
        "Romeo-leder",
        "MC-leder",
        "Civil-leder",
        "Indsatsleder",
        "Uddannelsesvejleder",
        "Certifikat Hundepatrulje"
    ],
    boderCategories: {
        "Færdselsloven": [],
        "Straffeloven": [],
        "Bek. euf. stoffer": [],
        "Våben og Knivlov": [],
        "Ordensbekendtgørelsen": [],
    },
    efterlysName: {
        "Efterlysninger": [] // DU KAN IKKE ADDE FLERE END EN, SÅ FUCKER DET OP
    },
    efterlysKName: {
        "Efterlysninger På Køretøjer": [] // DU KAN IKKE ADDE FLERE END EN, SÅ FUCKER DET OP
    },
    ansogninger: {
        "Romeo": [],
        "Civil": [],
        "MC": [],
        "Helikopter": [],
        "Våben certifikat #1": []
    },
    ansogningerConfig: {
     // Tilføj flere ting, husk kommalogo er fontawesome logos https://fontawesome.com/icons/fighter-jet?style=solid
     // type:"rank eller cert" cert = så kommer den under certifikater / rank = så kommer den under udannelser
     // giverank:true eller false / true = så får man den group og grade der står / false = så får man ingen rank
     // "ANSØGNINGSNAVN" : {logo:"LOGO FRA Font Awesome", group:"esx job man får", grade: "jobgrade man får", type:"rank eller cert", giverank:true eller false}
        "Romeo": {logo:"fas fa-fighter-jet", group:"police", grade:"1", type:"police", giverank:true},
        "Civil": {logo:"fas fa-user-secret", group:"police", grade:"2", type:"police", giverank:true},
        "MC": {logo:"fas fa-motorcycle", group:"police", grade:"3", type:"police", giverank:true},
        "Helikopter": {logo:"fas fa-helicopter", group:"police", grade:"4", type:"police", giverank:true},
        "Våben certifikat #1": {logo:"fas fa-id-badge", group:"xxxx", grade:"0", type:"police", giverank:false},
    },
    emptyCommentKR: "Ingen kommentar"
}