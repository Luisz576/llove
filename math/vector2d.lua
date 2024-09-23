--- @class Vector2D
--- @field x number
--- @field y number
local Vector2D = {}
Vector2D.__index = Vector2D

--- constructor
--- @param x number?
--- @param y number?
function Vector2D:new(x, y)
    local instance = {
        x = x or 0,
        y = y or 0
    }
    return setmetatable(instance, Vector2D)
end

-- explicit zero constructor
function Vector2D:zero()
    return Vector2D:new(0, 0)
end

-- copy
function Vector2D:copy()
    return Vector2D:new(self.x, self.y)
end

-- magnitude
--- @param x number?
--- @param y number?
--- @return number
function Vector2D:magnitude(x, y)
    x = x or self.x
    y = y or self.y
    return math.sqrt(x^2 + y^2)
end

-- normalize
--- @param x number?
--- @param y number?
--- @return Vector2D
function Vector2D:normalize(x, y)
    x = x or self.x
    y = y or self.y
    -- Calculate the magnitude
    local magnitude = Vector2D.magnitude(self)
    -- Handle the case of a zero vector
    if magnitude == 0 then
        return Vector2D:zero()
    end
    return Vector2D:new(x / magnitude, y / magnitude)
end

return Vector2D