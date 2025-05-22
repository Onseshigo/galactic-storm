local affected_planets = {}
local affected_planets_setting = settings.startup["galactic-storm-affected-planets"].value
if affected_planets_setting ~= "" then
    for planet in affected_planets_setting:gmatch("([^,]+)") do
        table.insert(affected_planets, planet:match("^%s*(.-)%s*$"))
    end
else
    for _, planet in ipairs(data.raw["planet"]) do
        table.insert(affected_planets, planet.name)
    end
end

local planet_to_copy = settings.startup["galactic-storm-planet-to-copy"].value
local lightning_properties = {}
if data.raw["planet"][planet_to_copy] then
    lightning_properties = data.raw["planet"][planet_to_copy]["lightning_properties"]
else
    log("planet not found: \"" .. planet_to_copy .. "\"")
end

for _, planet in ipairs(affected_planets) do
    if data.raw["planet"][planet] then
        data.raw["planet"][planet]["lightning_properties"] = lightning_properties
    else
        log("planet not found: \"" .. planet .. "\"")
    end
end