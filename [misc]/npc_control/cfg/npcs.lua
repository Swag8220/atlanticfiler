cfg = {}

cfg.density = {
	peds = 1.05,
	vehicles = 1.00
}

cfg.peds = { -- these peds wont show up anywhere, they will be removed and their vehicles deleted
  "s_m_y_cop_01",
  "s_m_y_cop_01_p",
  "s_f_y_Cop_01",
  "s_f_y_Cop_01_p",
  "s_f_y_sheriff_01",
  "s_m_y_sheriff_01",
  "s_m_y_hwaycop_01",
  "s_m_y_swat_01",
  "s_m_m_snowcop_01",
  "s_m_m_paramedic_01",
  "g_m_y_lost_01",
  "g_m_y_lost_02",
  "g_m_y_lost_03",
  "g_f_y_lost_01",
  "s_m_y_blackops_01",
  "s_m_y_blackops_02"
}

cfg.noguns = { -- these peds wont have any weapons
}

cfg.nodrops = { -- these peds wont drop their weapons when killed
}


-- WORK IN PROGRESS // DOES NOT WORK
cfg.vehs = { -- these vehicles wont show up anywhere, they will be removed unless a player is in the driver seat
  "police",
  "policet",
  "sheriff",
  "fbi",
  "pranger",
  "riot",
  "pbus",
  "police3",
  "policeb",
  "blimp",
  "ambulance",
--  "mule"
}
