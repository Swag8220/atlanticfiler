Config = {}
Config.Locale = 'en'

Config.Price = 40

Config.DrawDistance = 20.0
Config.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor  = {r = 255, g = 0, b = 0}
Config.MarkerType   = 25

Config.Zones = {}

Config.Shops = {
  {x=72.254,    y=-1399.102, z=28.376},
  {x=-703.776,  y=-152.258,  z=36.415},
  {x=-167.863,  y=-298.969,  z=38.733},
  {x=428.694,   y=-800.106,  z=28.491},
  {x=-829.413,  y=-1073.710, z=10.328},
  {x=-1447.797, y=-242.461,  z=48.820},
  {x=11.632,    y=6514.224,  z=30.877},
  {x=123.646,   y=-219.440,  z=53.557},
  {x=1696.291,  y=4829.312,  z=41.063},
  {x=618.093,   y=2759.629,  z=41.088},
  {x=1190.550,  y=2713.441,  z=37.222},
  {x=-1193.429, y=-772.262,  z=16.324},
  {x=-3172.496, y=1048.133,  z=19.863}, 
  {x=-1108.441, y=2708.923,  z=18.107},
  {x=-439.0065612793,  y=6008.0288085938, z=35.995643615723, blip = false}, --PaletoPD 
  {x=2517.1032714844,  y=-341.96139526367, z=100.89339447021, blip = false}, --PET 
  {x=458.34,  y=-999.08, z=29.72, blip = false}, --MRPD 
  {x=353.3714,  y=-1433.331, z=31.93624, blip = false},
  {x=336.54,  y=-571.35, z=42.47, blip = false} -- pillbox

}

Config.PEDModels = {
  --{label = "MrBrown#1999", hash = "brownballaeast_ped", identifier = "steam:11000010ab434bf"},
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
