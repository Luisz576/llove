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

return Sprite