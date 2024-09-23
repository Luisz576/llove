local Component = {}
Component.__index = Component



------ IMPORTS ------
local llove_root = (...):gsub('%.component$', '')
local Vector2D = require(llove_root .. ".math").Vector2D
local Axis = require(llove_root .. ".util").Axis



------ RECT --------
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
--- @param centerX number
--- @param centerY number
--- @param width number
--- @param height number
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
    for _, p in ipairs(points) do
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

--- Collide Rect In Axis
--- @param rect Rect
--- @param axis string
--- @return boolean
function Rect:collideRectInAxis(rect, axis)
    local leftTop = self:leftTop()
    local rightBottom = self:rightBottom()
    if axis == Axis.horizontal then
        return not (
            rightBottom.x < rect.x
            or leftTop.x > rect:right()
        )
    else
        return not (
            rightBottom.y < rect.y
            or leftTop.y > rect:bottom()
        )
    end
end

--- Collide Some Rect
--- @param rects Rect[]
--- @return boolean
function Rect:collideSomeRect(rects)
    local leftTop = self:leftTop()
    local rightBottom = self:rightBottom()
    for _, r in ipairs(rects) do
        if not (rightBottom.x < r.x or rightBottom.y < r.y or leftTop.x > r:right() or leftTop.y > r:bottom()) then
            return true
        end
    end
    return false
end



------ SPRITE ------
local Sprite = {}
Sprite.__index = Sprite

-- constructor
function Sprite:new(groups)
    local instance = {
        _groups = groups or {}
    }
    return setmetatable(instance, Sprite)
end

-- add group
function Sprite:addGroup(group)
    table.insert(self._groups, group)
end

-- groups
function Sprite:groups()
    return self._groups
end

-- remove group
--- @return boolean
function Sprite:removeGroup(group)
    for i = #self._groups, 1, -1 do
        if self._groups[i] == group then
            table.remove(group, i)
            return true
        end
    end
    return false
end

-- is in some group
--- @return boolean
function Sprite:hasGroup()
    return #self._groups > 0
end

-- draw
function Sprite:update(dt) end
function Sprite:draw() end



------ GROUP ------
local Group = {}
Group.__index = Group

-- constructor
function Group:new(sprites)
    local instance = {
        _sprites = sprites or {}
    }
    return setmetatable(instance, Group)
end

-- add sprite
function Group:add(sprite)
    table.insert(self._sprites, sprite)
end

-- sprites
function Group:sprites()
    return self._sprites
end

-- has no sprite
--- @return boolean
function Group:empty()
    return #self._sprites > 0
end

-- remove sprite
--- @return boolean
function Group:remove(sprite)
    for i = #self._sprites, 1, -1 do
        if self._sprites[i] == sprite then
            table.remove(sprite, i)
            return true
        end
    end
    return false
end

-- has sprite in group
--- @return boolean
function Group:has(sprite)
    for i = #self._sprites, 1, -1 do
        if self._sprites[i] == sprite then
            return true
        end
    end
    return false
end

-- Clear
function Group:clear()
    for key, _ in pairs(self._sprites) do
        self._sprites[key] = nil
    end
end



------ ------
Component.Rect = Rect
Component.Sprite = Sprite
Component.CollidableSprite = CollidableSprite
Component.Group = Group

return Component