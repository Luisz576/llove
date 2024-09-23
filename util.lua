local LLoveUtil = {}
LLoveUtil.__index = LLoveUtil


------ Methods -------
function LLoveUtil.cloneArray(arr)
    local copy = {}
    for i=1, #arr do
        copy[i] = arr[i]
    end
    return copy
end

function LLoveUtil.cloneTable(table)
    local copy = {}
    copy.__index = table.__index
    for k, v in pairs(table) do
        table[k] = v
    end
    return setmetatable(copy, getmetatable(table))
end


------ AXIS ------
--- @class Axis
--- @field horizontal string
--- @field vertical string
local Axis = {
    horizontal = "horizontal",
    vertical = "vertical"
}



------ DIRECTION ------
--- @class Direction
--- @field down string
--- @field left string
--- @field right string
--- @field up string
local Direction = {
    down = "down",
    left = "left",
    right = "right",
    up = "up"
}



--------
LLoveUtil.Axis = Axis
LLoveUtil.Direction = Direction

return LLoveUtil