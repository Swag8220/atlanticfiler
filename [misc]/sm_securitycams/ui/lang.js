lang = {
	/*Commands*/
	["!help"] : "!help",
	["!helpjob"] : "!helpjob",
	["!changeowner"] : "!changeowner",
	["!changegroup"] : "!changegroup",
	["!changename"] : "!changename",
	["!changegroupowner"] : "!changegroupowner",
	["!movecam"] : "!movecam",
	["!installmod"] : "!installmod",
	["!removemod"] : "!removemod",
	["!info"]: "!info",
	["!find"]: "!find",
	["!destroycam"] : "!destroycam",
	["!grades"] : "!grades",
	["!mods"] : "!mods",
	["!viewcam"] : "!viewcam",
	["!money"] : "!money",
	["!withdrawmoney"] : "!withdrawmoney",
	["!depositmoney"] : "!depositmoney",
	["!clients"] : "!clients",
	["!jobs"] : "!jobs",
	["!employees"] : "!employees",
	["!hireplayer"] : "!hireplayer",
	["!invoice"] : "!faktura",
	["!promoteplayer"] : "!promoteplayer",
	["!kickplayer"] : "!kickplayer",
	["!openinvoices"] : "!openinvoices",
	["!exit"] : "!forlad",
	["!fixcam"] : "!fixcam",
	["!listbrokencams"] : "!listbrokencams",

	/* !help texts */

	["commandnotfound"] : "Ugyldig kommando! Mangler du hjælp? - Brug !help",

	["help"] : `
		<p>!changeowner kameraID job-navn kameragruppe kameranavn</p> 
		<p>!changegroup kameraID ny-gruppe</p> 
		<p>!changename kameraID ny-kamera-navn</p> 
		<p>!installmod kameraID mod-navn</p>
		<p>!movecam kameraID</p> 
		<p>!fixcam kameraID</p> 
		<p>!destroycam kameraID</p> 
		<p>!viewcam kameraID</p>
		<p>!listbrokencams</p> 
		<p>!info | Hvor mange kameraer er der i nærheden?</p> 
		<p>!find kameraID | GPS lokation på et bestemt kamera</p> 
		<p>!clients | Liste over kunder</p>
		<p>!mods | Liste over mods til kameraer</p>
		<p>!forlad</p>
	`,
	["helpjobworker"] : `
		<p>!faktura spillerID pengesum besked (Virker ikke pt.)</p>
		<p>!depositmoney antal</p>
	`,
	["mods"] : `
		<p> speed | Ligesom politi radar </p>
		<p> facereq | Ansigts genkendelse</p>
		<p> zoom | Zoom</p>
	`,
	
	
	/* Other */

	["fetchingdata"] : "Loader data...",
	["missingarguments"] : "Fejl! Mangler noget mere...",
	["cameraupdated"] : "Kameraet er blevet opdateret",
	["invalidid"] : "ugyldigt kameraID",
	["alreadyhavemod"] : "Kameraet har allerede denne mod",
	["nomod"] : `!`,
	["removedmod"] : "Fjerner mod",
	["invalidmod"] : "Ugyldigt mod navn",
	["modinstalled"] : "Mod installeret",
	["amountofcams"] : "Kameraer",
	["noconnections"] : "Ingen forbindelse",
	["newconnection"] : "Tilsluttet",
	["lostconnectionto"] : "Mistede forbindelsen",
	["destroying"] : "Ødelægger kameraet",
	["connecting"] : "Forbinder",
 
	["id"] : "kameraID",
	["owner"] : "ejer",
	["group"] : "gruppe",
	["name"] : "kamera-navn",
	["from"] : "fra",
	["modds"] : "mods",
	["status"] : "tilstand",
	["unbroken"] : "fin",
	["broken"] : "ødelagt",
	["destroyed"] : "ødelagt",
	["gpsSet"] : "Din GPS er sat",

}
