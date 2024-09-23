local llove_root = (...):gsub('%.component.rect$', '')
local Vector2D = require(llove_root .. ".math.vector2d")

--- @class Rect
--- @field x number
--- @field y number
--- @field width number
--- @field height number
local Rect = {}
Rect.__index = Rect

-- constructor
--- @param x number
--- @param y number
--- @param width number
--- @param height number
function Rect:new(x, y, width, height)
    local instance = {
        x = x,
        y = y,
        width = width,
        height = height
    }
    return setmetatable(instance, Rect)
end

-- constructor based on center
function Rect:newFromCenter(centerX, centerY, width, height)
    local x = centerX - (width / 2)
    local y = centerY - (height / 2)
    return Rect:new(x, y, width, height)
end

-- copy
function Rect:copy()
    return Rect:new(self.x, self.y, self.width, self.height)
end

-- left
function Rect:left()
    return self.x
end

-- right
function Rect:right()
    return self.x + self.width
end

-- top
function Rect:top()
    return self.y
end

-- bottom
function Rect:bottom()
    return self.y + self.height
end

-- left Top Point
function Rect:leftTop()
    return Vector2D:new(self.x, self.y)
end

-- left Top Point
function Rect:leftBottom()
    return Vector2D:new(self.x, self.y + self.height)
end

-- left Top Point
function Rect:rightTop()
    return Vector2D:new(self.x + self.width, self.y)
end

-- left Top Point
function Rect:rightBottom()
    return Vector2D:new(self.x + self.width, self.y + self.height)
end

-- center X
function Rect:centerX()
    return (self:left() + self:right()) / 2
end

-- center Y
function Rect:centerY()
    return (self:bottom() + self:top()) / 2
end

-- center
function Rect:center()
    return Vector2D:new(self:centerX(), self:centerY())
end

--- Collide Point
--- @param x number
--- @param y number
--- @return boolean
function Rect:collidePoint(x, y)
    local leftTop = self:leftTop()
    local rightBottom = self:rightBottom()
    return not (
        leftTop.x < x
        or rightBottom.x > x
        or leftTop.y < y
        or rightBottom.y > y
    )
end

--- Collide Some Point
--- @param points {x: number, y: number}[]
--- @return boolean
function Rect:collideSomePoint(points)
    local leftTop = self:leftTop()
    local rightBottom = self:rightBottom()
    for _, p in points do
        if not (leftTop.x < p.x or rightBottom.x > p.x or leftTop.y < p.y or rightBottom.y > p.y) then
            return true
        end
    end
    return false
end

--- Collide Rect
--- @param rect Rect
--- @return boolean
function Rect:collideRect(rect)
    local leftTop = self:leftTop()
    local rightBottom = self:rightBottom()
    return not (
        rightBottom.x < rect.x
        or rightBottom.y < rect.y
        or leftTop.x > rect:right()
        or leftTop.y > rect:bottom()
    )
end

--- Collide Some Rect
--- @param rects Rect[]
--- @return boolean
function Rect:collideSomeRect(rects)
    local leftTop = self:leftTop()
    local rightBottom = self:rightBottom()
    for _, r in rects do
        if not (rightBottom.x < r.x or rightBottom.y < r.y or leftTop.x > r:right() or leftTop.y > r:bottom()) then
            return true
        end
    end
    return false
end

return Rect