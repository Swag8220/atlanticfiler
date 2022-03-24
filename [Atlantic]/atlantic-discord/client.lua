local DiscordAppId = tonumber(GetConvar("RichAppId", "872521313305108565"))
local DiscordAppAsset = GetConvar("RichAssetId", "logo")


local UpdateTime = 1500

Citizen.CreateThread(function()
	while true do
		local playerName = GetPlayerName(PlayerId())
		local onlinePlayers = 0
		
		for i = 0, 255 do
			if NetworkIsPlayerActive(i) then
				onlinePlayers = onlinePlayers+1
			end
		end
	
		SetDiscordAppId(DiscordAppId)
		
		SetDiscordRichPresenceAsset(DiscordAppAsset)
		
		SetDiscordRichPresenceAction(0, "Join Atlantic  - Discorden", "https://discord.gg/6mbQQudStj")
        SetDiscordRichPresenceAction(1, "Join Atlantic  - Serveren", "fivem://connect/dz8mkj ")

		SetDiscordRichPresenceAssetText(playerName)
		
		SetDiscordRichPresenceAssetSmall(DiscordAppAssetSmall)
		
		SetDiscordRichPresenceAssetSmallText("Atlantic  [https://discord.gg/6mbQQudStj]")

		SetRichPresence("Online: "..onlinePlayers.."/64 ")
		
		Citizen.Wait(UpdateTime)
	end
end)
