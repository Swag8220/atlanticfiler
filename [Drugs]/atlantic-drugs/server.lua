-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- START TEST
local JobCooldown 		= {}
local ConvertTimer		= {}
local DrugEffectTimer	= {}
local soldAmount 		= {}

RegisterServerEvent("t1ger_drugs:syncJobsData")
AddEventHandler("t1ger_drugs:syncJobsData",function(data)
	TriggerClientEvent("t1ger_drugs:syncJobsData",-1,data)
end)

-- Server side table, to store cooldown for players:
RegisterServerEvent("t1ger_drugs:addCooldownToSource")
AddEventHandler("t1ger_drugs:addCooldownToSource",function(source)
	table.insert(JobCooldown,{cooldown = GetPlayerIdentifier(source), time = (Config.CooldownTime * 60000)})
end)

-- Server side table, to store convert timer for players:
RegisterServerEvent("t1ger_drugs:addConvertingTimer")
AddEventHandler("t1ger_drugs:addConvertingTimer",function(source,timer)
	table.insert(ConvertTimer,{convertWait = GetPlayerIdentifier(source), timeB = timer})
end)

-- Server side table, to store drug effect timer for players:
RegisterServerEvent("t1ger_drugs:addDrugEffectTimer")
AddEventHandler("t1ger_drugs:addDrugEffectTimer",function(source,timer)
	table.insert(DrugEffectTimer,{effectWait = GetPlayerIdentifier(source), timeC = timer})
end)

-- CreateThread Function for timer:
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(JobCooldown) do
			if v.time <= 0 then
				RemoveCooldown(v.cooldown)
			else
				v.time = v.time - 1000
			end
		end
		for k,v in pairs(ConvertTimer) do
			if v.timeB <= 0 then
				RemoveConvertTimer(v.convertWait)
			else
				v.timeB = v.timeB - 1000
			end
		end
		for k,v in pairs(DrugEffectTimer) do
			if v.timeC <= 0 then
				RemoveDrugEffectTimer(v.effectWait)
			else
				v.timeC = v.timeC - 1000
			end
		end
	end
end)

-- Usable item to start drugs jobs:
ESX.RegisterUsableItem('drugItem', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not HasCooldown(GetPlayerIdentifier(source)) then
		if xPlayer.getInventoryItem(Config.HackerDevice).count >= 1 then
			TriggerClientEvent("t1ger_drugs:UsableItem",source)
		else
			TriggerClientEvent('esx:showNotification', source, "Du har brug for en ~r~Hacking Device~s~ for at bruge ~y~USB'en~s~")
		end
 	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("~y~USB'en~s~ er brugbar om: ~b~%s minutter~s~",GetCooldownTime(GetPlayerIdentifier(source))))
  	end
end)

-- Server Event for Buying Drug Job:
RegisterServerEvent("t1ger_drugs:GetSelectedJob")
AddEventHandler("t1ger_drugs:GetSelectedJob", function(drugType,BuyPrice,minReward,maxReward)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getAllMoney() >= BuyPrice then 
		xPlayer.removeAllMoney(BuyPrice)
		TriggerEvent("t1ger_drugs:addCooldownToSource",source)
		TriggerClientEvent("t1ger_drugs:BrowseAvailableJobs",source, 0, drugType, minReward, maxReward)
		if drugType == "coke" then
			label = "Coke"
		elseif drugType == "meth" then
			label = "Meth"
		elseif drugType == "weed" then
			label = "Weed"
		elseif drugType == "heroin" then
			label = "heroin"
		elseif drugType == "lsd" then
			label = "LSD"
		end	
		TriggerClientEvent("esx:showNotification",source,"Du betalte ~g~DKK"..BuyPrice.."~s~ for et ~r~"..label.."~s~ job")
	else
		TriggerClientEvent("esx:showNotification",source,"Du har ikke nok penge")
	end
end)

-- Server Event for Job Reward:
RegisterServerEvent("t1ger_drugs:JobReward")
AddEventHandler("t1ger_drugs:JobReward",function(minReward,maxReward,typeDrug)
	local minDrugReward = minReward
	local maxDrugReward = maxReward
	local xPlayer = ESX.GetPlayerFromId(source)
	drugAmount = math.random(minDrugReward,maxDrugReward)
	xPlayer.addInventoryItem(typeDrug.."brick",math.ceil(drugAmount))
end)

-- Usable item for drug effects:
Citizen.CreateThread(function()
	for k,v in pairs(Config.DrugEffects) do 
		ESX.RegisterUsableItem(v.UsableItem, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			local itemLabel = ESX.GetItemLabel(v.UsableItem)
			
			if not DrugEffect(GetPlayerIdentifier(source)) then
				TriggerEvent("t1ger_drugs:addDrugEffectTimer",source,v.UsableTime)
				xPlayer.removeInventoryItem(v.UsableItem,1)
				TriggerClientEvent("t1ger_drugs:DrugEffects",source,k,v)
			else
				TriggerClientEvent("esx:showNotification",source,string.format("Du tager ~b~allerede~s~ en anden form af narkotika",GetDrugEffectTime(GetPlayerIdentifier(source))))	
			end	
		end)
	end
end)

-- Usable item to convert drugs:
Citizen.CreateThread(function()
	for k,v in pairs(Config.DrugConversion) do 
		ESX.RegisterUsableItem(v.UsableItem, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			local itemLabel = ESX.GetItemLabel(v.UsableItem)
			local drugOutput
			local requiredItems
			
			local scale = xPlayer.getInventoryItem(v.hqscale).count >= 1
			if v.HighQualityScale then
				if scale then
					drugOutput = v.RewardAmount.b
					requiredItems = v.RequiredItemAmount.d
				else
					drugOutput = v.RewardAmount.a
					requiredItems = v.RequiredItemAmount.c
				end
			else
				drugOutput = v.RewardAmount
				requiredItems = v.RequiredItemAmount
			end
				
			local reqItems = xPlayer.getInventoryItem(v.RequiredItem).count >= requiredItems
			if not reqItems then
				local reqItemLabel = ESX.GetItemLabel(v.RequiredItem)
				TriggerClientEvent("esx:showNotification",source,"Du ~r~har ikke~s~ nok ~y~"..reqItemLabel.."~s~")
				return
			end
			
			if xPlayer.getInventoryItem(v.RewardItem).count <= v.MaxRewardItemInv.f or (not scale and xPlayer.getInventoryItem(v.RewardItem).count <= v.MaxRewardItemInv.e) then
				if not Converting(GetPlayerIdentifier(source)) then
					TriggerEvent("t1ger_drugs:addConvertingTimer",source,v.ConversionTime)
					xPlayer.removeInventoryItem(v.UsableItem,1)
					xPlayer.removeInventoryItem(v.RequiredItem,requiredItems)
					TriggerClientEvent("t1ger_drugs:ConvertProcess",source,k,v)
					Citizen.Wait(v.ConversionTime)
					xPlayer.addInventoryItem(v.RewardItem,drugOutput)
				else
					TriggerClientEvent("esx:showNotification",source,string.format("Du er ~b~allerede i gang~s~ med at konvertere",GetConvertTime(GetPlayerIdentifier(source))))	
				end	
			else
				TriggerClientEvent("esx:showNotification",source,"Du ~r~har ikke~s~ nok ~b~plads~s~ i din rygsæk ~y~"..itemLabel.."~s~")
			end
		end)
	end
end)

RegisterServerEvent('t1ger_drugs:DrugJobInProgress')
AddEventHandler('t1ger_drugs:DrugJobInProgress', function(targetCoords, streetName)
	TriggerClientEvent('t1ger_drugs:outlawNotify', -1,string.format("Skud affyret ved %s",streetName))
	TriggerClientEvent('t1ger_drugs:OutlawBlipEvent', -1, targetCoords)
end)

RegisterServerEvent('t1ger_drugs:DrugSaleInProgress')
AddEventHandler('t1ger_drugs:DrugSaleInProgress', function(targetCoords, streetName)
	local player = source
	local ped = GetPlayerPed(player)
	local playerCoords = GetEntityCoords(ped)
	TriggerClientEvent('t1ger_drugs:outlawNotify', -1,string.format("~r~En~w~ person ~r~prøvede at sælge narkotika tæt på~w~ ~w~%s",streetName))
   -- TriggerEvent("omik_callist:addTable", nil, "En person prøvede at sælge narkotika tæt på "..streetName, "police", targetCoords.x, targetCoords.y, targetCoords.z)

--	TriggerEvent("mdt:newCall", "Mulig narkotika salg", "Ukendt", vector3(playerCoords.x, playerCoords.y, playerCoords.z))
	TriggerClientEvent('t1ger_drugs:OutlawBlipEvent', -1, targetCoords)
end)

RegisterServerEvent("t1ger_drugs:sellDrugs")
AddEventHandler("t1ger_drugs:sellDrugs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local weed = xPlayer.getInventoryItem(Config.WeedDrug).count
	local meth = xPlayer.getInventoryItem(Config.MethDrug).count
	local coke = xPlayer.getInventoryItem(Config.CokeDrug).count
	local lsd = xPlayer.getInventoryItem(Config.LSDDrug).count
	local heroin = xPlayer.getInventoryItem(Config.heroinDrug).count
	local drugamount = 0
	local price = 0
	local drugType = nil
	
	if weed > 0 then
		drugType = Config.WeedDrug
		if weed == 1 then
			drugamount = 1
		elseif weed == 2 then
			drugamount = math.random(1,1)
		elseif weed == 10 then	
			drugamount = math.random(1,4)
		elseif weed >= 25 then	
			drugamount = math.random(1,5)
		end
		
	elseif meth > 0 then
		drugType = Config.MethDrug
		if meth == 1 then
			drugamount = 1
		elseif meth == 10 then
			drugamount = math.random(1,4)
		elseif meth >= 25 then	
			drugamount = math.random(1,5)
		end

	elseif lsd > 0 then
		drugType = Config.LSDDrug
		if lsd == 1 then
			drugamount = 1
		elseif lsd == 10 then
			drugamount = math.random(1,4)
		elseif lsd >= 25 then	
			drugamount = math.random(1,5)
		end
		
	elseif coke > 0 then
		drugType = Config.CokeDrug
		if coke == 1 then
			drugamount = 5
		elseif coke == 9 then
			drugamount = math.random(1,6)
		elseif coke >= 25 then	
			drugamount = math.random(1,10)
		end

	elseif heroin >= 5 then
		drugType = Config.heroinDrug
		if heroin >= 5 and heroin < 9 then
			drugamount = 5
		elseif heroin >= 9 and heroin < 25 then
			drugamount = math.random(1,6)
		elseif heroin >= 25 then	
			drugamount = math.random(1,10)
		end
	
	else
		TriggerClientEvent('esx:showNotification', source, "Du har ~r~ikke mere~r~ ~y~narkotika~s~ på dig")
		return
	end
	
	if drugType==Config.WeedDrug then
		price = math.random(Config.WeedSale.min,Config.WeedSale.max) * 10 * drugamount
	elseif drugType==Config.MethDrug then
		price = math.random(Config.MethSale.min,Config.MethSale.max) * 10 * drugamount
	elseif drugType==Config.CokeDrug then
		price = math.random(Config.CokeSale.min,Config.CokeSale.max) * 10 * drugamount
	elseif drugType==Config.LSDDrug then
		price = math.random(Config.LSDSale.min,Config.LSDSale.max) * 10 * drugamount
	elseif drugType==Config.heroinDrug then
		price = math.random(Config.HeroinSale.min,Config.HeroinSale.max) * 10 * drugamount
	end
	
	if drugType ~= nil then
		local drugLabel = ESX.GetItemLabel(drugType)
		AddToSoldAmount(xPlayer.getIdentifier(),drugamount)
		xPlayer.removeInventoryItem(drugType, drugamount)
		if Config.ReceiveDirtyCash then
--			xPlayer.addMoney(price)
            xPlayer.addAccountMoney('black_money', price)
		else
--			xPlayer.addMoney(price)
            xPlayer.addAccountMoney('black_money', price)
		end

		Ph1ll1pLog7(source, "Solgte ".. drugamount .. " ".. drugType .. " For "..price,"okay")
		TriggerClientEvent('esx:showNotification', source, "Du solgte ~b~"..drugamount.."~s~ ~y~"..drugLabel.."~s~ for ~r~"..price.. "~s~,-")
	end		
end)

RegisterServerEvent("t1ger_drugs:canSellDrugs")
AddEventHandler("t1ger_drugs:canSellDrugs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local soldAmount = (xPlayer.getInventoryItem("coke1g").count > 0 or xPlayer.getInventoryItem("meth1g").count > 0 or xPlayer.getInventoryItem("weed4g").count > 0 or xPlayer.getInventoryItem("lsd").count > 0 or xPlayer.getInventoryItem("heroin").count > 0) and CheckSoldAmount(xPlayer.getIdentifier()) < Config.maxCap
		TriggerClientEvent("t1ger_drugs:canSellDrugs",source,soldAmount)
	end
end)

function AddToSoldAmount(source,amount)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			v.amount = v.amount + amount
			return
		end
	end
end
function CheckSoldAmount(source)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			return v.amount
		end
	end
	table.insert(soldAmount,{id = source, amount = 0})
	return CheckSoldAmount(source)
end

-- Do not touch these 6 functions!
function RemoveCooldown(source)
	for k,v in pairs(JobCooldown) do
		if v.cooldown == source then
			table.remove(JobCooldown,k)
		end
	end
end
function GetCooldownTime(source)
	for k,v in pairs(JobCooldown) do
		if v.cooldown == source then
			return math.ceil(v.time/60000)
		end
	end
end
function HasCooldown(source)
	for k,v in pairs(JobCooldown) do
		if v.cooldown == source then
			return true
		end
	end
	return false
end
function RemoveDrugEffectTimer(source)
	for k,v in pairs(DrugEffectTimer) do
		if v.effectWait == source then
			table.remove(DrugEffectTimer,k)
		end
	end
end
function GetDrugEffectTime(source)
	for k,v in pairs(DrugEffectTimer) do
		if v.effectWait == source then
			return math.ceil(v.timeC/1000)
		end
	end
end
function DrugEffect(source)
	for k,v in pairs(DrugEffectTimer) do
		if v.effectWait == source then
			return true
		end
	end
	return false
end
function RemoveConvertTimer(source)
	for k,v in pairs(ConvertTimer) do
		if v.convertWait == source then
			table.remove(ConvertTimer,k)
		end
	end
end
function GetConvertTime(source)
	for k,v in pairs(ConvertTimer) do
		if v.convertWait == source then
			return math.ceil(v.timeB/1000)
		end
	end
end
function Converting(source)
	for k,v in pairs(ConvertTimer) do
		if v.convertWait == source then
			return true
		end
	end
	return false
end

Ph1ll1pLog7 = function(playerId, reason, typee)
    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    if playerId == 0 then
        local name = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
        local reason = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
    else
    end
    local steamid = "Unknown"
    local license = "Unknown"
    local discord = "Unknown"
    local xbl = "Unknown"
    local liveid = "Unknown"
    local dato = os.date("%d-%m-%Y kl. %X")
    if name == nil then
        name = "Unknown"
    end

    for k, v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    local discordInfo2 = {
        ["color"] = "16745963",
        ["type"] = "rich",
        ["title"] = "Logs",
        ["description"] = "**Name : **" ..
            name ..
                "\n **Reason : **" ..
                    reason ..
                        "\n **ID : **" ..
                            playerId ..
                                "\n **IP : **" ..
                                    ip ..
                                        "\n **Steam Hex : **" ..
                                            steamid .. "\n **License : **" .. license .. "\n **Discord : **" .. discord,
        ["footer"] = {
            ["text"] = " PhillipAC " .. "5.0" .. dato
        }
    }
    local discordInfo = {
        ["color"] = "16745963",
        ["type"] = "rich",
        ["title"] = "Banned",
        ["description"] = "**Name : **" ..
            name ..
                "\n **Reason : **" ..
                    reason ..
                        "\n **ID : **" ..
                            playerId ..
                                "\n **IP : **" ..
                                    ip ..
                                        "\n **Steam Hex : **" ..
                                            steamid .. "\n **License : **" .. license .. "\n **Discord : **" .. discord,
        ["footer"] = {
			["text"] = " PhillipAC " .. "5.0" .. dato
        }
    }


    if name ~= "Unknown" then
        if typee == "basic" then
            PerformHttpRequest(
                "https://discord.com/api/webhooks/883406507155292200/CU95uQI0QFmBLWLtIwbZTMQTNC7Q3YAp9DAQqVYT-Skcr3OMpIR2C6ibswReCvzUv8xZ",
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " PhillipAC ", embeds = {discordInfo}}),
                {["Content-Type"] = "application/json"}
            )
        elseif typee == "okay" then
            PerformHttpRequest(
                "https://discord.com/api/webhooks/883406507155292200/CU95uQI0QFmBLWLtIwbZTMQTNC7Q3YAp9DAQqVYT-Skcr3OMpIR2C6ibswReCvzUv8xZ",
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " Chemical ", embeds = {discordInfo2}}),
                {["Content-Type"] = "application/json"}
            )
        elseif typee == "explosion" then
            PerformHttpRequest(
                "https://discord.com/api/webhooks/883406507155292200/CU95uQI0QFmBLWLtIwbZTMQTNC7Q3YAp9DAQqVYT-Skcr3OMpIR2C6ibswReCvzUv8xZ",
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " PhillipAC ", embeds = {discordInfo}}),
                {["Content-Type"] = "application/json"}
            )
        end
    end
end
