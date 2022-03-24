Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = true  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "Atlantic bot" 							-- Bot Username
Config.avatar = "https://via.placeholder.com/30x30"				-- Bot Avatar
Config.communtiyName = "Atlantic"					-- Icon top of the embed
Config.communtiyLogo = "https://via.placeholder.com/30x30"		-- Icon top of the embed
Config.FooterText = "2021 - 2022 © Atlantic"						-- Footer text for the embed
Config.FooterIcon = "https://via.placeholder.com/30x30"			-- Footer icon for the embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.InlineFields = true			-- set to false if you don't want the player details next to each other

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.license = true				-- set to false to disable license in the logs
Config.IP = true					-- set to false to disable IP in the logs

-- Change color of the default embeds here
-- It used Decimal or Hex color codes. They will both work.
Config.BaseColors ={		-- For more info have a look at the docs: https://docs.preffech.com
	chat = "#A1A1A1",				-- Chat Message
	joins = "#3AF241",				-- Player Connecting
	leaving = "#F23A3A",			-- Player Disconnected
	deaths = "#000000",				-- Shooting a weapon
	shooting = "#2E66F2",			-- Player Died
	resources = "#EBEE3F",			-- Resource Stopped/Started	
}


Config.webhooks = {		-- For more info have a look at the docs: https://docs.preffech.com
	all = "https://discord.com/api/webhooks/883408463336730674/j5U9ILgCHov2LevXsSYTtwXQ0nr2fvkl_wTFMPIOqRMe0-Sd-AKIUyYVQLkVHcNU_W52",		-- All logs will be send to this channel
	chat = "https://discord.com/api/webhooks/883408560124489748/_BhHfSuf968neb0xQVaxzricyPheNQhbXwJaYNNEDJ1St98cQmdsihfi7Ku03fZBRcq0",		-- Chat Message
	joins = "https://discord.com/api/webhooks/883408722309840916/8TT5lfbKy-0wFv7iUCYwZpONhb1LKbSaI7Bja9ZW2OufcBCHXM9dGEuAt6ovDcZ7rDlM",		-- Player Connecting
	leaving = "https://discord.com/api/webhooks/883408910558593166/NXuJe7PdIfZUbgQmOBWY6CAnjjTF_-cdkLEwG5pfucigenuYDFvNeF6zm8egapjNJJmk-",	-- Player Disconnected
	deaths = "https://discord.com/api/webhooks/883408988077711360/5hHbL72rfKMW_x-q60iP1g7IGtk18NhxMGL3TZdwGHrR82e_CoWrrjA7xid6NM_37aNV",		-- Shooting a weapon
	shooting = "https://discord.com/api/webhooks/883409063650672661/ttKztHI-EE4jAFh96jP1WFz-rLPAGU_VCGS0xNcFHRFCXEnffHyEIJkScGHM6-jc75cb",	-- Player Died
	resources = "https://discord.com/api/webhooks/883409157250760765/ZooLOtGZeMKSkNqi3MTCxBE-4obtUEh2NRqcJ5gQWAtMzvtZkVcNDUvtmKamUN41mL2V",	-- Resource Stopped/Started	
}

Config.TitleIcon = {		-- For more info have a look at the docs: https://docs.preffech.com
	chat = "💬",				-- Chat Message
	joins = "📥",				-- Player Connecting
	leaving = "📤",			-- Player Disconnected
	deaths = "💀",				-- Shooting a weapon
	shooting = "🔫",			-- Player Died
	resources = "🔧",			-- Resource Stopped/Started	
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.2.0"
