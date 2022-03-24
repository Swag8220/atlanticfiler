Config              = {}
Config.DrawDistance = 100
Config.Size         = {x = 1.5, y = 1.5, z = 1.5}
Config.Color        = {r = 277, g = 45, b = 45}
Config.Type         = 25
Config.Locale       = 'en'

-- Blip guide: https://docs.fivem.net/docs/game-references/blips/

Config.EnableBlips  = false -- Enable/disable blips
Config.BlipSprite   = 84 -- Blip icon
Config.BlipScale    = 0.7 -- Blip size (1.0 = default)
Config.BlipColor    = 1 -- Blip color

Config.Zones = {
	blackmarket = {
		Items = {},
		Pos = {
			-- Default location
			{x = 431.71, y = 6473.27, z = 27.778}
			-- Add locations under here
		}
	}
}
