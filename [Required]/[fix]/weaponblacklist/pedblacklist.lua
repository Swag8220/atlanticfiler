-- CONFIG --

-- Blacklisted ped models
pedblacklist = {
--[[	"g_m_importexport_01",
	"g_m_m_armboss_01",
	"g_m_m_armgoon_01",
	"g_m_m_armlieut_01",
	"g_m_m_chemwork_01",
	"g_m_m_chiboss_01",
	"g_m_m_chicold_01",
	"g_m_m_chigoon_02",
	"g_m_m_korboss_01",
	"g_m_m_mexboss_01",
	"g_m_m_mexboss_02",
	"g_m_y_armgoon_02",
	"g_m_y_azteca_01",
	"g_m_y_ballaeast_01",
	"g_m_y_ballaorig_01",
	"g_m_y_ballasout_01",
	"g_m_y_famca_01",
	"g_m_y_famdnf_01",
	"g_m_y_famfor_01",
	"g_m_y_korean_01",
	"g_m_y_korean_02",
	"g_m_y_korlieut_01",
	"g_m_y_lost_01",
	"g_m_y_lost_02",
	"g_m_y_lost_03",
	"g_m_y_mexgang_01",
	"g_m_y_mexgoon_01",
	"g_m_y_mexgoon_02",
	"g_m_y_mexgoon_03",
	"g_m_y_pologoon_01",
	"g_m_y_pologoon_02",
	"g_m_y_salvaboss_01",
	"g_m_y_salvagoon_01",
	"g_m_y_salvagoon_02",
	"g_m_y_salvagoon_03",
	"g_m_y_strpunk_01",
	"g_m_y_strpunk_02",
	"g_m_m_casrn_01"]]
}

-- Defaults to this ped model if an error happened
defaultpedmodel = "a_m_y_skater_01"

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			playerModel = GetEntityModel(playerPed)

			if not prevPlayerModel then
				if isPedBlacklisted(prevPlayerModel) then
					SetPlayerModel(PlayerId(), GetHashKey(defaultpedmodel))
				else
					prevPlayerModel = playerModel
				end
			else
				if isPedBlacklisted(playerModel) then
					SetPlayerModel(PlayerId(), prevPlayerModel)
					sendForbiddenMessage("Denne PED model er blacklistet!")
				end

				prevPlayerModel = playerModel
			end
		end
	end
end)

function isPedBlacklisted(model)
	for _, blacklistedPed in pairs(pedblacklist) do
		if model == GetHashKey(blacklistedPed) then
			return true
		end
	end

	return false
end