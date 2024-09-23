local Util = {}
Util.__index = Util



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
Util.Axis = Axis
Util.Direction = Direction

return Util