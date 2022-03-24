-- Rescripted af luwi#0787
-- Twitch: Luwi_kuwi1

K9Config = {}
K9Config = setmetatable(K9Config, {})

-- Din license key
K9Config.OpenMenuIdentifierRestriction = true -- Skal alle kunne? false = nej true = ja
K9Config.OpenMenuPedRestriction = false 

-- Lisence key
K9Config.LicenseIdentifiers = {
	"" -- fx license:c06fbf1faaf995c7b9e207ef77712971a3ed4dc3
}
-- Steam IDs der kan bruge hvis true
K9Config.SteamIdentifiers = {
	"steam:110000142aa8472", -- Zinzes Steam ID
	"steam:11000013280dd7c",
	"steam:110000110b5a14c",
	"steam:1100001421bafff",
	"steam:1100001363e74e2",
	"steam:11000013f6770ab",
	"steam:1100001473b4929"
}

-- Specielle Ped Models som kan bruge hunde menu'en
K9Config.PedsList = {
--	"s_m_y_cop_01",
--	"s_m_y_sheriff_01"
}

-- Hvis nogle køretøjer ikke skal kunne gemmemsøges
K9Config.VehicleRestriction = false
K9Config.VehiclesList = {

}


K9Config.SearchType = "Random" -- Hold fingrende væk

K9Config.OpenDoorsOnSearch = false -- Skal døren på bilen åbnes?

-- Her skal du skrive de items ind som er ulovlige eller hunden skal kunne finde i køretøjer
K9Config.Items = {
	{item = "OsteMis", illegal = true}, -- true hvis ulovlig false hvis lovlig
	{item = "OsteMis", illegal = true},
	{item = "OsteMis", illegal = false},
	{item = "OsteMis", illegal = false},
	{item = "OsteMis", illegal = false},
	{item = "OsteMis", illegal = false},
	{item = "OsteMis", illegal = false},
	{item = "OsteMis", illegal = false},
}


K9Config.LanguageChoice = "Danish"
K9Config.Languages = {
	["Danish"] = {
		follow = "Kom",
		stop = "Bliv",
		attack = "Pus!",
		enter = "Ind",
		exit = "Ud"
	}
}