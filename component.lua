local LLoveComponent = {}
LLoveComponent.__index = LLoveComponent


-------- REGISTER ---------
--- @class Rect
--- @field x number
--- @field y number
--- @field width number
--- @field height number

local Group = {}
Group.__index = Group

local Rect = {}
Rect.__index = Rect

local Sprite = {}
Sprite.__index = Sprite


------ IMPORTS ------
local llove_root = (...):gsub('%.component$', '')
local Vector2D = require(llove_root .. ".math").Vector2D



------ RECT --------
-- constructor
--- @param x number
--- @param y number
--- @param width number
--- @param height number
--- @param angle number | nil In radians
function Rect:new(x, y, width, height, angle)
    local instance = {
        x = x,
        y = y,
        width = width,
        height = height,
        angle = angle
    }
    return setmetatable(instance, self)
end

-- constructor based on center
--- @param centerX number
--- @param centerY number
--- @param width number
--- @param height number
--- @param angle number | nil In radians
function Rect:newFromCenter(centerX, centerY, width, height, angle)
    local x = centerX - (width / 2)
    local y = centerY - (height / 2)
    return Rect:new(x, y, width, height, angle)
end

-- copy
function Rect:copy()
    return Rect:new(self.x, self.y, self.width, self.height, self.angle)
end

-- return a new rect with width and height inflated
function Rect:inflate(x, y)
    return Rect:new(self.x + math.floor(x / 2), self.y + math.floor(y / 2), self.width + x, self.height + y)
end

-- return the size
---@return { width: number, height: number }
function Rect:size()
    return {
        width = self.width,
        height = self.height
    }
end

-- set new rect size
function Rect:setSize(width, height)
    self.width = width
    self.height = height
end

-- set angle from degrees
function Rect:setAngleFromDegrees(degrees)
    self.angle = math.rad(degrees)
    return self
end

-- get angle in degrees
function Rect:angleInDregrees()
    return math.deg(self.angle)
end

-- update x and y
--- @param x number
--- @param y number
function Rect:setXY(x, y)
    self.x = x
    self.y = y
    return self
end

-- update x and y
--- @param pos {x: number, y:number}
function Rect:set(pos)
    self.x = pos.x
    self.y = pos.y
    return self
end

-- update values based on center
--- @param center {x: number, y:number}
function Rect:setCenter(center)
    self.x = center.x - (self.width / 2)
    self.y = center.y - (self.height / 2)
    return self
end

-- update values based on center
--- @param centerX number
--- @param centerY number
function Rect:setCenterXY(centerX, centerY)
    self.x = centerX - (self.width / 2)
    self.y = centerY - (self.height / 2)
    return self
end

-- update values based on center
--- @param centerX number
function Rect:setCenterX(centerX)
    self.x = centerX - (self.width / 2)
    return self
end

-- update values based on center
--- @param centerY number
function Rect:setCenterY(centerY)
    self.y = centerY - (self.height / 2)
    return self
end

-- update values based on left
--- @param left number
function Rect:setLeft(left)
    self.x = left
    return self
end

-- update values based on right
--- @param right number
function Rect:setRight(right)
    self.x = right - self.width
    return self
end

-- update values based on top
--- @param top number
function Rect:setTop(top)
    self.y = top
    return self
end

-- update values based on bottom
--- @param bottom number
function Rect:setBottom(bottom)
    self.y = bottom - self.height
    return self
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
function Rect:collideRect(rect)
    local leftTop = self:leftTop()
    local rightBottom = self:rightBottom()
    return rightBottom.x > rect.x and rightBottom.y > rect.y and leftTop.x < rect:right() and leftTop.y < rect:bottom()
end

--- Collide Some Rect
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
-- constructor
function Sprite:new(groups, z)
    local instance = {
        z = z or 0,
        _groups = {}
    }
    instance = setmetatable(instance, self)
    -- register groups
    for _, group in ipairs(groups) do
        Sprite.addGroup(instance, group)
    end
    return instance
end

-- add group
--- @return boolean
function Sprite:addGroup(group)
    if Sprite.isInGroup(self, group) then
        return false
    end
    return Group.add(group, self)
end
function Sprite:_justAddToGroup(group)
    table.insert(self._groups, group)
end

-- is in group
--- @return boolean
function Sprite:isInGroup(group)
    for i = #self._groups, 1, -1 do
        if self._groups[i] == group then
            return true
        end
    end
    return false
end

-- groups
function Sprite:groups()
    return self._groups
end

-- get group
--- @param name string
function Sprite:getGroup(name)
    for i = #self._groups, 1, -1 do
        if self._groups[i].name == name then
            return self._groups[i]
        end
    end
    return nil
end

-- remove group
--- @return boolean
function Sprite:removeGroup(group)
    for i = #self._groups, 1, -1 do
        if self._groups[i] == group then
            return Group.remove(group, self)
        end
    end
    return false
end
-- remove all groups
function Sprite:removeFromGroups()
    for i = #self._groups, 1, -1 do
        Group.remove(self._groups[i], self)
    end
end
-- handler to just remove in self
function Sprite:_justRemoveFromGroup(group)
    for i = #self._groups, 1, -1 do
        if self._groups[i] == group then
            table.remove(self._groups, i)
            return
        end
    end
end

-- is in some group
--- @return boolean
function Sprite:hasGroup()
    return #self._groups > 0
end

-- update
function Sprite:update(dt) end
-- draw
function Sprite:draw() end



------ GROUP ------
-- constructor
function Group:new(name)
    local instance = {
        name = name,
        _sprites = {}
    }
    return setmetatable(instance, self)
end

-- add sprite
--- @return boolean
function Group:add(sprite)
    if getmetatable(sprite) == Sprite and not Group.has(self, sprite) then
        Sprite._justAddToGroup(sprite, self)
        table.insert(self._sprites, sprite)
        return true
    end
    return false
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
            Sprite._justRemoveFromGroup(sprite, self)
            table.remove(self._sprites, i)
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
LLoveComponent.Rect = Rect
LLoveComponent.Sprite = Sprite
LLoveComponent.Group = Group

return LLoveComponent