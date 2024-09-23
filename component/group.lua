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

return Group