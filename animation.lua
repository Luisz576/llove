local love = require "love"

local LLoveAnimation = {}
LLoveAnimation.__index = LLoveAnimation

------ DEFINITIONS --------
local Animation = {}
Animation.__index = Animation

local AnimationController = {}
AnimationController.__index = AnimationController

local AnimationGrid = {}
AnimationGrid.__index = AnimationGrid



------ ANIMATION ------
-- constructor
function Animation:new(frames, speed, loop)
    local instance = {
        index = 1,
        frames = frames or {},
        speed = speed or 8,
        loop = loop ~= false,
        flippedX = false,
        flippedY = false,
        _deltaFrame = 0
    }
    return setmetatable(instance, Animation)
end

-- next frame
function Animation:next()
    self.index = self.index + 1
    if self.index > Animation.size(self) then
        if self.loop then
            self.index = 1
        else
            self.index = self.index - 1
        end
    end
end

-- previous frame
function Animation:previous()
    self.index = self.index - 1
    local animationSize = Animation.size(self)
    if self.index < 1 then
        if self.loop then
            self.index = animationSize
        else
            self.index = 1
        end
    end
end

-- reset animation
function Animation:reset()
    self.index = 1
    self._deltaFrame = 0
end

-- reset just the delta frame
function Animation:resetDeltaFrame()
    self._deltaFrame = 0
end

-- size of animation
function Animation:size()
    return #self.frames
end

-- get current frame
function Animation:frame()
    return self.frames[self.index]
end

-- insert frame
--- @param frame any
--- @param pos integer nil to insert at end
function Animation:insertFrame(frame, pos)
    if pos == nil then
        table.insert(self.frames, frame)
    else
        table.insert(self.frames, pos, frame)
    end
end

-- remove first occurrence of frame
--- @param frame any
--- @return any
function Animation:removeFrame(frame)
    local animationSize = Animation.size(self)
    for i = 1, animationSize, 1 do
        if self.frame[i] == frame then
            return table.remove(self.frames, i)
        end
    end
    return nil
end

-- remove frame at position
--- @param pos integer
function Animation:removeFrameAt(pos)
    return table.remove(self.frames, pos)
end

-- update animation
function Animation:update(dt)
    self._deltaFrame = self._deltaFrame + self.speed * dt
    if self._deltaFrame > 1 then
        self._deltaFrame = 0
        self:next()
    end
end

-- draw animation
function Animation:draw(sprite, x, y, r, sx, sy, ox, oy, kx, ky)
    love.graphics.draw(sprite, self:getDrawInfo(x, y, r, sx, sy, ox, oy, kx, ky))
end

-- return the draw info
function Animation:getDrawInfo(x, y, r, sx, sy, ox, oy, kx, ky)
    local frame = self:frame()
    if self.flippedX or self.flippedY then
        r, sx, sy, ox, oy, kx, ky = r or 0, sx or 1, sy or 1, ox or 0, oy or 0, kx or 0, ky or 0
        local _ ,_ , w, h = frame:getViewport()
        if self.flippedX then
            sx = sx * -1
            ox = w - ox
            kx = kx * -1
            ky = ky * -1
        end
        if self.flippedY then
            sy = sy * -1
            oy = h - oy
            kx = kx * -1
            ky = ky * -1
        end
    end
    return frame, x, y, r, sx, sy, ox, oy, kx, ky
end



------ ANIMATION GRID ------



------ ANIMATION CONTROLLER --------
function AnimationController:new(animations, startAnimation, playing)
    local instance = {
        currentAnimation = startAnimation or 1,
        playing=playing == true
    }
    -- build animations
    if animations == nil then
        -- no animations
        instance.animations = {}
    else
        if type(animations) == "table" then
            for key, _ in pairs(animations) do
                if type(key) == "number" then
                    -- is array
                    instance.animations = animations
                elseif type(key) == "string" then
                    -- animations[animation-name] = animation
                    instance.animations = {}
                    for k, v in pairs(animations) do
                        instance.animations[k] = v
                    end
                else
                    error("Invalid animations pairs")
                end
            end
        end
    end
    return setmetatable(instance, AnimationController)
end

-- play or resume current animation or other animation
function AnimationController:play(animation)
    self.playing = true
    if animation ~= nil then
        self:change(animation)
    end
end

-- stop animation
function AnimationController:stop()
    self.playing = false
end

-- reset animation
function AnimationController:reset()
    self.animations[self.currentAnimation]:reset()
end

-- return current animation
function AnimationController:animation()
    return self.animations[self.currentAnimation]
end

-- return current frame of current animation
function AnimationController:frame()
    return self.animations[self.currentAnimation]:frame()
end

-- next frame of current animation
function AnimationController:nextFrame()
    self.animations[self.currentAnimation]:next()
end

-- previous frame of current animation
function AnimationController:previousFrame()
    self.animations[self.currentAnimation]:previous()
end

-- change animation
function AnimationController:change(animation, resetAnimation)
    if self.currentAnimation ~= animation then
        self.currentAnimation = animation
        if resetAnimation == nil or resetAnimation then
            AnimationController.reset(self)
        end
    end
end

-- update current animation
function AnimationController:update(dt)
    if self.playing then
        self.animations[self.currentAnimation]:update(dt)
    end
end

-- draw current animation
function AnimationController:draw(sprite, x, y, r, sx, sy, ox, oy, kx, ky)
    self.animations[self.currentAnimation]:draw(sprite, x, y, r, sx, sy, ox, oy, kx, ky)
end



-------------
LLoveAnimation.Animation = Animation
LLoveAnimation.AnimationController = AnimationController

return LLoveAnimation