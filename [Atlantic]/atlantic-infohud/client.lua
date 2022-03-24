local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local isTalking = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	
	TriggerEvent('es:setMoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	for k,v in pairs(accounts) do
		local account = v
		if account.name == "bank" then
			SendNUIMessage({action = "setValue", key = "bankmoney", value = ""..format_thousand(account.money)..' DKK'})
		elseif account.name == "black_money" then
			SendNUIMessage({action = "setValue", key = "dirtymoney", value = ""..format_thousand(account.money)..' DKK'})
		end
	end

	-- Job
	local job = data.job
    local jobTxt = job.label.." - "..job.grade_label
    if string.lower(job.grade_label) == 'ansat' then jobTxt = job.label end
	SendNUIMessage({action = "setValue", key = "job", value = jobTxt, icon = job.name})

	-- Money
	SendNUIMessage({action = "setValue", key = "money", value = ""..format_thousand(data.money)..' DKK'})
end)

RegisterNetEvent('ui:toggle')
AddEventHandler('ui:toggle', function(show)
	SendNUIMessage({action = "toggle", show = show})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "bank" then
		SendNUIMessage({action = "setValue", key = "bankmoney", value = ""..format_thousand(account.money)..' DKK'})
	elseif account.name == "black_money" then
		SendNUIMessage({action = "setValue", key = "dirtymoney", value = ""..format_thousand(account.money)..' DKK'})
	end
end)

RegisterNetEvent('ui_hud:remSociety')
AddEventHandler('ui_hud:remSociety', function()
	SendNUIMessage({action= "remValue", key = "societymoney"})
end)

RegisterNetEvent('ui_hud:setSocietyMoney')
AddEventHandler('ui_hud:setSocietyMoney', function(money)
	SendNUIMessage({action= "setValue", key = "societymoney", value = ""..format_thousand(money)..' DKK'})
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    local jobTxt = job.label.." - "..job.grade_label
    if string.lower(job.grade_label) == 'ansat' then jobTxt = job.label end
	SendNUIMessage({action = "setValue", key = "job", value = jobTxt, icon = job.name})
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({action = "setValue", key = "money", value = ""..format_thousand(e)..' DKK'})
end)

local hud = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(0, Keys['.']) then
			if hud then
				TriggerEvent('ui:toggle',false)
			else
				TriggerEvent('ui:toggle',true)
			end
			hud = not hud
		end
	end
end)

Citizen.CreateThread(function()
    TriggerEvent('ui:toggle',false)
end)

function format_thousand(v)
    if not v then v = 0 end
    v = tonumber(v)
    if v > 999 then
        local s = string.format("%d", math.floor(v))
        local pos = string.len(s) % 3
        if pos == 0 then pos = 3 end
        return string.sub(s, 1, pos)
        .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
    else
        return v
    end
end
