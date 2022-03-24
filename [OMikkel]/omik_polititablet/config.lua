cfg = {}

cfg.hotkey = 166 -- Hotkey til at åbne menuen

cfg.group = "police" -- Permission for dem der kan åbne menuen

cfg.newKRUser = {
    profileLogo = "https://i.imgur.com/DGW6ZHZ.png", -- Et placeholder som start værdi
    clip = 0, -- Standard start værdi for klip i kørekortet
    disq = "Ingen aktiv frakendelse", -- Standard start værdi for frakendelse
}

-- Function til at lave en fødselsdag
function cfg:getYears(birth)
    local day, month, year = birth:match("([^/]+)/([^/]+)/([^/]+)")
    --return tonumber(tonumber(os.date("%Y")) - tonumber(year))
    return 24
end

-- Function til at omregne tommer til centimeter
function cfg:inchToCm(inches)
    return tonumber(inches) * 2.54
end

return cfg