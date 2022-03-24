-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

local ESX = nil
TriggerEvent(Config.ESX_OBJECT, function(obj) ESX = obj end)

Citizen.CreateThread(function ()
    while GetResourceState('mysql-async') ~= 'started' do Citizen.Wait(0) end
    while GetResourceState(GetCurrentResourceName()) ~= 'started' do Citizen.Wait(0) end
    if GetResourceState(GetCurrentResourceName()) == 'started' then InitialDrugSystem() end
end)

local online_cops = 0
function FetchOnlineCops()
	local xPlayers = ESX.GetPlayers()
	local count = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		for k,v in pairs(Config.Police.Jobs) do
			if xPlayer.job.name == v then
				count = count + 1
			end
		end
	end
    if online_cops ~= count then
        TriggerClientEvent('t1ger_drugs:updateCopsCount', -1, count)
    end
	online_cops = count
	SetTimeout(Config.Police.Timer * 60000, FetchOnlineCops)
end
FetchOnlineCops()

function InitialDrugSystem()
	Citizen.Wait(1000)
    TriggerClientEvent('t1ger_drugs:intializeDrugs', -1)
end

local using_item = {}

AddEventHandler('esx:playerLoaded', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	while not xPlayer do Citizen.Wait(100) end
	TriggerClientEvent('t1ger_drugs:intializeDrugs', xPlayer.source)
	for i = 1, #Config.DrugLabs do
		TriggerClientEvent('t1ger_drugs:sendCacheCL', xPlayer.source, Config.DrugLabs[i].cache, i)
	end
	-- update using_item state:
	TriggerEvent('t1ger_drugs:notUsingItem', xPlayer.source)
	-- Get Sell State:
	Citizen.Wait(5000)
	local drug_inventory, has_drugs = GetDrugInventory(xPlayer.source)
	if has_drugs then
		TriggerClientEvent('t1ger_drugs:sellStateCL', xPlayer.source, true)
	end
end)

-- ## DRUG LABS ## --

ESX.RegisterServerCallback('t1ger_drugs:getLabCache',function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(Config.DrugLabs[id].cache)
end)

RegisterServerEvent('t1ger_drugs:sendCacheSV')
AddEventHandler('t1ger_drugs:sendCacheSV',function(id, data)
	Config.DrugLabs[id].cache = data
	TriggerClientEvent('t1ger_drugs:sendCacheCL', -1, Config.DrugLabs[id].cache, id)
end)

RegisterServerEvent('t1ger_drugs:updateInUseSV')
AddEventHandler('t1ger_drugs:updateInUseSV',function(cache, state)
	Config.DrugLabs[cache.id].cache.in_use = state
	TriggerClientEvent('t1ger_drugs:updateInUseCL', -1, cache.id, state)
end)

RegisterServerEvent('t1ger_drugs:creatingLab')
AddEventHandler('t1ger_drugs:creatingLab',function(id, state)
	Config.DrugLabs[id].creating = state
	TriggerClientEvent('t1ger_drugs:updateCreatingLab', -1, id, state)
end)

RegisterServerEvent('t1ger_drugs:sendProcessDataSV')
AddEventHandler('t1ger_drugs:sendProcessDataSV',function(cache, data)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items = data.input
	-- check if has items:
	for i = 1, #items do
		local item_count = xPlayer.getInventoryItem(items[i].item).count
		if item_count < items[i].amount then
			local missing_count = (items[i].amount - item_count)
			return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['missing_item']:format(missing_count, items[i].name, data.output.amount, data.output.name))
		end
	end
	-- check if table is empty:
	if next(Config.DrugLabs[cache.id].cache.process) == nil then
		local cache_data = {
			id = cache.id,
			identifier = xPlayer.identifier,
			input = data.input,
			output = data.output,
			time = (data.time * 1000 * 60),
			done = false,
			collected = false
		}
		Config.DrugLabs[cache.id].cache.process = cache_data
		TriggerClientEvent('t1ger_drugs:sendCacheCL', -1, Config.DrugLabs[cache.id].cache, cache.id)
		for i = 1, #items do xPlayer.removeInventoryItem(items[i].item, items[i].amount) end
	else
		return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['process_to_slow'])
	end
end)

ESX.RegisterServerCallback('t1ger_drugs:collectProcessedDrugs',function(source,cb,cache)
	local xPlayer = ESX.GetPlayerFromId(source)
	if next(Config.DrugLabs[cache.id].cache.process) ~= nil then
		if not Config.DrugLabs[cache.id].cache.process.collected then
			Config.DrugLabs[cache.id].cache.process.collected = true
			local output = Config.DrugLabs[cache.id].cache.process.output
			xPlayer.addInventoryItem(output.item, output.amount)
			TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['process_collected']:format(output.amount, output.name))
			Config.DrugLabs[cache.id].cache.process = {}
			TriggerClientEvent('t1ger_drugs:sendCacheCL', -1, Config.DrugLabs[cache.id].cache, cache.id)
			cb(true)
		else
			cb(false)
		end
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('t1ger_drugs:requestPackaging',function(source, cb, data, cache)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items = data.input
	-- check if has items:
	for i = 1, #items do
		local item_count = xPlayer.getInventoryItem(items[i].item).count
		if item_count < items[i].amount then
			local missing_count = (items[i].amount - item_count)
			return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['missing_item2']:format(missing_count, items[i].name, data.output.amount, data.output.name))
		end
	end
	-- check if in_use:
	if next(Config.DrugLabs[cache.id].cache.package) ~= nil then
		return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['package_to_slow'])
	else
		local cache_data = {in_use = true, identifier = xPlayer.identifier, input = data.input, output = data.output}
		Config.DrugLabs[cache.id].cache.package = cache_data
		TriggerClientEvent('t1ger_drugs:sendCacheCL', -1, Config.DrugLabs[cache.id].cache, cache.id)
		for i = 1, #items do xPlayer.removeInventoryItem(items[i].item, items[i].amount) end
	end
	cb(true)
end)

RegisterServerEvent('t1ger_drugs:getPackagedDrugs')
AddEventHandler('t1ger_drugs:getPackagedDrugs',function(cache)
	local xPlayer = ESX.GetPlayerFromId(source)
	local output = Config.DrugLabs[cache.id].cache.package.output
	if Config.DrugTypes[cache.type].package.output.scale.enable then
		local percent = ((Config.DrugTypes[cache.type].package.output.scale.percent/100) + 1)
		local scale_item = xPlayer.getInventoryItem(Config.DrugTypes[cache.type].package.output.scale.item)
		if scale_item and scale_item.count >= 1 then 
			output.amount = math.floor(output.amount * percent)
		end
	end
	xPlayer.addInventoryItem(output.item, output.amount)
	TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['packaging_done']:format(output.amount, output.name))
	Config.DrugLabs[cache.id].cache.package = {}
	TriggerClientEvent('t1ger_drugs:sendCacheCL', -1, Config.DrugLabs[cache.id].cache, cache.id)
end)

Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for i = 1, #Config.DrugLabs do
			if next(Config.DrugLabs[i].cache) ~= nil and next(Config.DrugLabs[i].cache.process) ~= nil then
				if not Config.DrugLabs[i].cache.process.done then
					if Config.DrugLabs[i].cache.process.time <= 0 then
						local xPlayer = ESX.GetPlayerFromIdentifier(Config.DrugLabs[i].cache.process.identifier)
						if xPlayer then
                            local sender, subject = Config.Blips[Config.DrugLabs[i].type].label, Lang['adv_noti_subject']
                            local msg = Lang['process_is_done']:format(Config.DrugLabs[i].cache.process.output.name)
                            local textureDict, iconType = 'CHAR_LESTER_DEATHWISH', 7
							TriggerClientEvent('t1ger_drugs:notifyAdvanced', xPlayer.source, sender, subject, msg, textureDict, iconType)
							Config.DrugLabs[i].cache.process.done = true
							TriggerClientEvent('t1ger_drugs:sendCacheCL', -1, Config.DrugLabs[i].cache, i)
						end
					else
						Config.DrugLabs[i].cache.process.time = Config.DrugLabs[i].cache.process.time - 1000
						--print("v.time: "..Config.DrugLabs[i].cache.process.time)
					end
				end
			end
		end
	end
end)

-- ## DRUG JOBS ## --

RegisterServerEvent('t1ger_drugs:requestDrugJob')
AddEventHandler('t1ger_drugs:requestDrugJob', function(data)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getMoney() >= data.fees then
            if online_cops >= data.minCops then
                if not HasCooldown(xPlayer.identifier) then
                    local can_start, num = GetAvailableJob(xPlayer.source)
                    if can_start and num ~= nil then
                        xPlayer.removeMoney(data.fees)
                        if Config.DrugJobs.Settings.cooldown.enable then
                            TriggerEvent('t1ger_drugs:addCooldown', xPlayer.source)
                        end
                        local vehicle = Config.DrugJobs.Vehicles[math.random(1, #Config.DrugJobs.Vehicles)]
                        TriggerClientEvent('t1ger_drugs:drugJobEvent', xPlayer.source, num, data, vehicle)
                    end
                else
					local seconds, timer = GetCooldownTime(xPlayer.identifier)
					if seconds then
						return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['job_cooldown_1']:format(timer))
					else
						return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['job_cooldown_2']:format(timer))
					end
                end
            else
                return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['not_enough_cops'])
            end
        else
            return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['not_enough_money'])
        end
    end
end)

function GetAvailableJob(source)  
	local xPlayer = ESX.GetPlayerFromId(source) 
    local can_start = false
    math.randomseed(GetGameTimer())
	local id = math.random(1, #Config.DrugJobs.Jobs)
    local i = 0
    while Config.DrugJobs.Jobs[id].inUse and i < 100 do
        i = i + 1
        math.randomseed(GetGameTimer())
        id = math.random(1, #Config.DrugJobs.Jobs)
    end
    if i == 100 then
        TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['no_jobs_available'])
        can_start = false
        id = nil
    else
        can_start = true
        Config.DrugJobs.Jobs[id].inUse = true
		Config.DrugJobs.Jobs[id].src = source
        TriggerClientEvent('t1ger_drugs:jobConfigCL', -1, Config.DrugJobs.Jobs)
    end
    return can_start, id
end

RegisterServerEvent('t1ger_drugs:giveJobReward')
AddEventHandler('t1ger_drugs:giveJobReward',function(drug_type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cfg = Config.DrugJobs.Reward[drug_type]
    for i = 1, #cfg do
        math.randomseed(GetGameTimer())
        if math.random(0,100) <= cfg[i].chance then
            local amount = math.random(cfg[i].amount.min, cfg[i].amount.max)
            xPlayer.addInventoryItem(cfg[i].item, amount)
        end
        Citizen.Wait(200)
    end
end)

RegisterServerEvent('t1ger_drugs:jobConfigSV')
AddEventHandler('t1ger_drugs:jobConfigSV',function(cfg)
    TriggerClientEvent('t1ger_drugs:jobConfigCL', -1, cfg)
end)

RegisterServerEvent('t1ger_drugs:sendPoliceAlert')
AddEventHandler('t1ger_drugs:sendPoliceAlert', function(coords, street_name, msg)
    local message = msg:format(street_name)
	TriggerClientEvent('t1ger_drugs:sendPoliceAlertCL', -1, coords, message)
end)

AddEventHandler('playerDropped', function()
	for k,v in pairs(Config.DrugJobs.Jobs) do
		if v.src == source then
			Config.DrugJobs.Jobs[k].inUse = false
			Config.DrugJobs.Jobs[k].goons_spawned = false
			Config.DrugJobs.Jobs[k].veh_spawned = false
			Config.DrugJobs.Jobs[k].player = false
			Config.DrugJobs.Jobs[k].src = 0
			TriggerEvent('t1ger_drugs:jobConfigSV', Config.DrugJobs.Jobs)
			break
		end
	end
end)

-- ## JOB COOLDOWN ## --

local job_cooldown = {}
RegisterServerEvent('t1ger_drugs:addCooldown')
AddEventHandler('t1ger_drugs:addCooldown',function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    table.insert(job_cooldown, {identifier = xPlayer.identifier, time = (Config.DrugJobs.Settings.cooldown.time * 60000)})
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1000)
		for k,v in pairs(job_cooldown) do if v.time <= 0 then table.remove(job_cooldown, k) else v.time = v.time - 1000 end end
	end
end)

function GetCooldownTime(identifier)
	for k,v in pairs(job_cooldown) do
		if v.identifier == identifier then
			local seconds, cooldown_time = false, (v.time/60000)
			if cooldown_time < 60000 then
				cooldown_time = v.time/1000
				seconds = true
			end
			return seconds, math.ceil(cooldown_time)
		end
	end
end

function HasCooldown(identifier)
	for k,v in pairs(job_cooldown) do if v.identifier == identifier then return true end end
	return false
end

-- ## DRUG SALE ## --
local sold_drugs = {}

-- Callback to get inventory drugs:
ESX.RegisterServerCallback('t1ger_drugs:getUserInventory',function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local drugInventory, hasDrugs = GetDrugInventory(xPlayer.source)
	cb(drugInventory, hasDrugs)
end)

-- Callback to get max cap:
ESX.RegisterServerCallback('t1ger_drugs:getPlayerMaxCap',function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if (CheckSoldDrugsAmount(xPlayer.identifier) < Config.DrugSale.max_cap) or (Config.DrugSale.max_cap == 0) then
		cb(false)
	else
		cb(true)
	end
end)

-- Check Sold Drugs Amount:
function CheckSoldDrugsAmount(identifier)	
	if #sold_drugs > 0 then
		for k,v in pairs(sold_drugs) do
			if v.identifier == identifier then 
				return v.amount
			else
				if k == #sold_drugs then 
					table.insert(sold_drugs, {identifier = identifier, amount = 0})
					return CheckSoldDrugsAmount(identifier)
				end
			end
		end
	else
		table.insert(sold_drugs, {identifier = identifier, amount = 0})
		return CheckSoldDrugsAmount(identifier)
	end
end

AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
    for k,v in pairs(Config.DrugTypes) do
		if v.sell.items[item.name] then
            TriggerClientEvent('t1ger_drugs:sellStateCL', source, true)
			break
		end
    end
end)

RegisterServerEvent('t1ger_drugs:sellDrugsToNPC')
AddEventHandler('t1ger_drugs:sellDrugsToNPC', function(drug)
	local xPlayer = ESX.GetPlayerFromId(source)
    local cfg = Config.DrugTypes[drug.type].sell
    math.randomseed(GetGameTimer())
    -- calculate drug price:
    local sell_price = math.random(cfg.items[drug.item].min, cfg.items[drug.item].max)
    if cfg.multiplier.enable and (online_cops >= cfg.multiplier.min_cops) then
        local multiplier = (cfg.multiplier.value/100 + 1.0)
        sell_price = (math.floor(sell_price * multiplier))
    end
    -- calculate sell amount:
    math.randomseed(GetGameTimer())
    local sell_amount = math.random(Config.DrugSale.amount.min, Config.DrugSale.amount.max)
    if sell_amount > drug.count then sell_amount = drug.count end
    -- execute sale:
    sell_price = (sell_price * sell_amount)
	AddToSoldAmount(xPlayer.identifier, sell_amount)
	xPlayer.removeInventoryItem(drug.item, sell_amount)
	if Config.DrugSale.dirty_cash then xPlayer.addAccountMoney('black_money', sell_price) else xPlayer.addMoney(sell_price) end
	TriggerClientEvent('t1ger_drugs:notify', source, Lang['you_sold_drugs']:format(sell_amount, drug.label, sell_price))
end)

function GetDrugInventory(plyID)
	local xPlayer = ESX.GetPlayerFromId(plyID)
	local inv_drugs = {}
    for k,v in pairs(Config.DrugTypes) do
		for name,qty in pairs(v.sell.items) do
			local inv_item = xPlayer.getInventoryItem(name)
			if inv_item and inv_item.count > 0 then 
				table.insert(inv_drugs, {type = k, item = inv_item.name, count = inv_item.count, label = inv_item.label})
			end
		end
    end
	if next(inv_drugs) ~= nil then return inv_drugs, true else return nil, false end
end

function AddToSoldAmount(identifier, amount)
	for k,v in pairs(sold_drugs) do if v.identifier == identifier then v.amount = v.amount + amount; return end end
end

-- ## DRUG EFFECTS ## --
Citizen.CreateThread(function()
	for item,data in pairs(Config.DrugEffects) do 
		ESX.RegisterUsableItem(item, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			if not usingItem(xPlayer.identifier) then
                table.insert(using_item, {identifier = xPlayer.identifier})
				xPlayer.removeInventoryItem(item, 1)
				TriggerClientEvent('t1ger_drugs:useDrugsCL', xPlayer.source, item, data)
            else
                TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['already_consuming_drug'])
			end	
		end)
	end
end)

RegisterServerEvent('t1ger_drugs:notUsingItem')
AddEventHandler('t1ger_drugs:notUsingItem',function(plyID)
	local src = source
	if plyID ~= nil then src = plyID end
    local xPlayer = ESX.GetPlayerFromId(src)
	if next(using_item) ~= nil then 
		for k,v in pairs(using_item) do
			if v.identifier == xPlayer.identifier then
				table.remove(using_item, k)
				break
			end
		end
	end
end)

-- Drug Item Conversions:
Citizen.CreateThread(function()
	for k,v in pairs(Config.DrugItemConverter) do 
		ESX.RegisterUsableItem(k, function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer then
				-- check if converting:
				if usingItem(xPlayer.identifier) then
					return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['already_converting'])
				end
				-- get num and scale:
				local num, scale = 'a', xPlayer.getInventoryItem(v.scale.item)
				if v.scale.enable and scale and scale.count >= 1 then num = 'b' end
				-- check required items:
				for i = 1, #v.requirements do
					local item = xPlayer.getInventoryItem(v.requirements[i].item)
					if item and item.count < v.requirements[i].amount[num] then 
						local missing_qty = (v.requirements[i].amount[num] - item.count)
						return TriggerClientEvent('t1ger_drugs:notify', xPlayer.source, Lang['missing_item3']:format(missing_qty, item.label))
					end
					Wait(10)
				end
				-- remove usable item:
				xPlayer.removeInventoryItem(k, 1)
				-- remove requirements:
				for i = 1, #v.requirements do
					local item = xPlayer.getInventoryItem(v.requirements[i].item)
					if item and item.count >= v.requirements[i].amount[num] then
						xPlayer.removeInventoryItem(item.name, v.requirements[i].amount[num])
					end
					Wait(10)
				end
				-- update using state:
				table.insert(using_item, {identifier = xPlayer.identifier})
				-- anim & progressBars:
				TriggerClientEvent('t1ger_drugs:drugConverting', xPlayer.source, v)
				Citizen.Wait(v.time)
				-- add Output:
				xPlayer.addInventoryItem(v.output.item, v.output.amount[num])
			end
		end)
	end
end)

function usingItem(identifier)
    local match = false
    for k,v in pairs(using_item) do
        if v.identifier == identifier then
            match = true
            break
        end
    end
    return match
end