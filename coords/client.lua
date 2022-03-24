
RegisterCommand('coords', function(source, args, rawCommand)
	local coords = GetEntityCoords(PlayerPedId())
	SendNUIMessage({
		coords = ""..coords.x..","..coords.y..","..coords.z..""
	})
end)

RegisterCommand('heading', function(source, args, rawCommand)
	local heading = GetEntityHeading(PlayerPedId())
	print(heading)
end)


RegisterCommand('tpc', function(source, args, rawCommand)
	local x = tonumber(args[1])
	local y = tonumber(args[2])
	local z = tonumber(args[3])
	SetEntityCoords(GetPlayerPed(-1), x,y,z, false)
end)