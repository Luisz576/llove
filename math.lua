local LLoveMath = {}
LLoveMath.__index = LLoveMath

-------- DEFINITIONS --------
--- @class Point2D
--- @field x number
--- @field y number

--- @class Vector2D
--- @field x number
--- @field y number
local Vector2D = {}
Vector2D.__index = Vector2D

------ METHODS -------
--- Return FPS
---@param dt number
---@return number
function LLoveMath.fps(dt)
    return 1 / dt
end
-- Return FPS rounded
---@param dt number
---@return number
function LLoveMath.ffps(dt)
    return math.floor(1 / dt)
end

-- Distance between two points
---@param a Point2D
---@param b Point2D
---@return number
function LLoveMath.pointsDis(a, b)
    return math.sqrt(((a.x - b.x) ^ 2) + ((a.y - b.y) ^ 2))
end

------ VECTOR2D ------
--- constructor
--- @param x number?
--- @param y number?
function Vector2D:new(x, y)
    local instance = {
        x = x or 0,
        y = y or 0
    }
    return setmetatable(instance, self)
end

-- explicit zero constructor
function Vector2D:zero()
    return Vector2D:new(0, 0)
end

-- say if it's zero
function Vector2D:isZero()
    return self.x == 0 and self.y == 0
end

-- set values
---@param x number
---@param y number
function Vector2D:set(x, y)
    self.x = x or 0
    self.y = y or 0
    return self
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

-- operator add
Vector2D.__add = function (a, b)
    if type(a) == "table" and type(b) == "number" then
        return Vector2D:new(a.x + b, a.y + b)
    elseif type(a) == "table" and type(b) == "table" then
        return Vector2D:new(a.x + b.x, a.y + b.y)
    elseif type(a) == "number" and type(b) == "table" then
        return Vector2D:new(b.x + a, b.y + a)
    else
        error("Invalid Add Operation: '" .. type(a) .. "' + '" .. type(b) .. "'")
    end
end

-- operator sub
Vector2D.__sub = function (a, b)
    if type(a) == "table" and type(b) == "number" then
        return Vector2D:new(a.x - b, a.y - b)
    elseif type(a) == "table" and type(b) == "table" then
        return Vector2D:new(a.x - b.x, a.y - b.y)
    elseif type(a) == "number" and type(b) == "table" then
        return Vector2D:new(b.x - a, b.y - a)
    else
        error("Invalid Sub Operation: '" .. type(a) .. "' - '" .. type(b) .. "'")
    end
end

-- operator mul
Vector2D.__mul = function (a, b)
    if type(a) == "table" and type(b) == "number" then
        return Vector2D:new(a.x * b, a.y * b)
    elseif type(a) == "table" and type(b) == "table" then
        return Vector2D:new(a.x * b.x, a.y * b.y)
    elseif type(a) == "number" and type(b) == "table" then
        return Vector2D:new(b.x * a, b.y * a)
    else
        error("Invalid Mul Operation: '" .. type(a) .. "' * '" .. type(b) .. "'")
    end
end

-- operator div
Vector2D.__div = function (a, b)
    if type(a) == "table" and type(b) == "number" then
        return Vector2D:new(a.x / b, a.y / b)
    elseif type(a) == "table" and type(b) == "table" then
        return Vector2D:new(a.x / b.x, a.y / b.y)
    elseif type(a) == "number" and type(b) == "table" then
        return Vector2D:new(b.x / a, b.y / a)
    else
        error("Invalid Div Operation: '" .. type(a) .. "' / '" .. type(b) .. "'")
    end
end

-- operator mod
Vector2D.__mod = function (a, b)
    if type(a) == "table" and type(b) == "number" then
        return Vector2D:new(a.x % b, a.y % b)
    elseif type(a) == "table" and type(b) == "table" then
        return Vector2D:new(a.x % b.x, a.y % b.y)
    elseif type(a) == "number" and type(b) == "table" then
        return Vector2D:new(b.x % a, b.y % a)
    else
        error("Invalid Mod Operation: '" .. type(a) .. "' % '" .. type(b) .. "'")
    end
end

-- operator pow
Vector2D.__pow = function (a, b)
    if type(a) == "table" and type(b) == "number" then
        return Vector2D:new(a.x ^ b, a.y ^ b)
    elseif type(a) == "table" and type(b) == "table" then
        return Vector2D:new(a.x ^ b.x, a.y ^ b.y)
    elseif type(a) == "number" and type(b) == "table" then
        return Vector2D:new(b.x ^ a, b.y ^ a)
    else
        error("Invalid Pow Operation: '" .. type(a) .. "' ^ '" .. type(b) .. "'")
    end
end

-- operator unm
Vector2D.__unm = function (a)
    return Vector2D:new(a.x * -1, a.y * -1)
end

-- to string
Vector2D.__tostring = function (a)
    return "x: " .. a.x .. " y: " .. a.y
end



-----------
LLoveMath.Vector2D = Vector2D

return LLoveMath