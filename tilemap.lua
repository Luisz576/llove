local LLoveTilemap = {}
LLoveTilemap.__index = LLoveTilemap

------ DEFINITIONS -------
local Tilemap = {}
Tilemap.__index = Tilemap

local Layer = {}
Layer.__index = Layer

local Tileset = {}
Tileset.__index = Tileset


------ Tilemap
function Tilemap:new(map)
    if type(map) == "table" then
        map = setmetatable(map, Tilemap)
    else
        -- TODO
    end
    return map
end



-----------

return LLoveTilemap