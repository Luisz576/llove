local LLoveUtil = {}
LLoveUtil.__index = LLoveUtil



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



------ METHODS -------
-- clone a array
function LLoveUtil.cloneArray(arr)
    local copy = {}
    for i=1, #arr do
        copy[i] = arr[i]
    end
    return copy
end

-- Clone a table
function LLoveUtil.cloneTable(table)
    local copy = {}
    copy.__index = table.__index
    for k, v in pairs(table) do
        table[k] = v
    end
    return setmetatable(copy, getmetatable(table))
end

-- concatenate things
function LLoveUtil.concatAll(s, ...)
    return table.concat({...}, s or '')
end

-- Direction to point from a to b
---@param a Point2D
---@param b Point2D
---@return string
function LLoveUtil.directionToPoint(a, b)
    local disX, disY = a.x - b.x, a.y - b.y
    local absDisX, absDisY = math.abs(disX), math.abs(disY)
    if absDisX > absDisY then
        if disX > 0 then
            return Direction.left
        else
            return Direction.right
        end
    else
        if disY > 0 then
            return Direction.up
        else
            return Direction.down
        end
    end
end



--------
LLoveUtil.Axis = Axis
LLoveUtil.Direction = Direction

return LLoveUtil