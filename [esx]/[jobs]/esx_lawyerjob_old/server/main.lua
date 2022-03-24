ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'advokat', 'Kunde', true, true)
ESX.RegisterServerCallback('esx_lawyer:createCVR', function(source, cb, target, firmanavn)
	local xPlayer = ESX.GetPlayerFromId(target)
	local fixedFirmanavn 
	fixedFirmanavn = string.gsub(firmanavn, "\\","\\\\")
	fixedFirmanavn = string.gsub(fixedFirmanavn, ";","\\;")
	fixedFirmanavn = string.gsub(fixedFirmanavn, "\"","\\\"")
	local cpr = ""
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=\"'.. xPlayer.getIdentifier() .. '\"', {}, function(weapRow)
		for k,v in pairs(weapRow) do
			cpr = v.lastdigits
			for x in string.gmatch(v.dateofbirth,"[^-]+") do
				cpr = x .. cpr
			end
		end
	end)
	Citizen.Wait(250)
	local CVR = ""
	MySQL.Async.fetchAll('SELECT cvr FROM cvr_register', {}, function(weapRow)
		CVR = math.random(1000000,99999999)
		for k,v in pairs(weapRow) do
			while CVR == v.CVR do
				CVR = math.random(1000000,99999999)
			end
		end
	end)
	Citizen.Wait(250)
	MySQL.Async.execute("INSERT INTO cvr_register (CVR,navn,CPR,firmanavn) VALUES (\"" .. CVR .. "\",\"".. xPlayer.getRPname() .. "\",\"".. cpr .. "\",\"".. fixedFirmanavn .."\")", {}, function ()
	end)
	TriggerClientEvent("esx:showNotification",source, "Firma: " .. fixedFirmanavn .. " | CVR:" .. CVR .. " | er nu oprettet")
end)

ESX.RegisterServerCallback('esx_lawyer:getCVR', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM cvr_register', {}, function(weapRow)
		cb(weapRow)
	end)
end)