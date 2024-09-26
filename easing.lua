------- IMPORTS -------
local _ratio = require "libraries.llove.math".ratio

------- DEFINITIONS --------
local EasingFunction = {
    ratio = _ratio
}
EasingFunction.__index = EasingFunction

local Easings = {}
Easings.__index = Easings



------ EasingFunction ------
-- constructor
--- @param f function
function EasingFunction:new(f, name)
    local instance = setmetatable({
        f = f,
        name = name
    }, self)
    instance.__call = instance.f
    return instance
end

-- clone
function EasingFunction:clone()
    return EasingFunction:new(self._f, self.name)
end


------- Easing Functions --------
local function EaseInSine(x)
    return 1 - math.cos((x * math.pi) / 2)
end

local function EaseOutSine(x)
    return math.sin((x * math.pi) / 2)
end

local function EaseInOutSine(x)
    return -(math.cos(math.pi * x) - 1) / 2
end

local function EaseInQuad(x)
    return x * x
end

local function EaseOutQuad(x)
    return 1 - (1 - x) * (1 - x)
end

local function EaseInOutQuad(x)
    if x < 0.5 then
        return 2 *x * x
    else
        return 1 - ((-2 * x + 2)^2) / 2
    end
end

local function EaseInCubic(x)
    return x * x * x
end

local function EaseOutCubic(x)
    return 1 - (1 - x)^3
end

local function EaseInOutCubic(x)
    if x < 0.5 then
        return 4 *x * x * x
    else
        return 1 - ((-2 * x + 2)^3) / 2
    end
end

local function EaseInQuart(x)
    return x * x * x * x
end

local function EaseOutQuart(x)
    return 1 - (1 - x)^4
end

local function EaseInOutQuart(x)
    if x < 0.5 then
        return 8 * x * x * x * x
    else
        return 1 - ((-2 * x + 2)^4) / 2
    end
end

local function EaseInQuint(x)
    return x * x * x * x * x
end

local function EaseOutQuint(x)
    return 1 - (1 - x)^5
end

local function EaseInOutQuint(x)
    if x < 0.5 then
        return 16 * x * x * x * x * x
    else
        return 1 - ((-2 * x + 2)^5) / 2
    end
end

local function EaseInExpo(x)
    if x == 0 then
        return 0
    else
        return 2 ^ (10 * x - 10)
    end
end

local function EaseOutExpo(x)
    if x == 1 then
        return 1
    else
        return 1 - (2 ^ (-10 * x))
    end
end

local function EaseInOutExpo(x)
    if x == 0 then
        return 0
    elseif x == 1 then
        return 1
    elseif x < 0.5 then
        return (2 ^ (20 * x - 10)) / 2
    else
        return (2 - (2 ^ (-20 * x + 10))) / 2
    end
end

local function EaseInCirc(x)
    return 1 - math.sqrt(1 - (x ^ 2))
end

local function EaseOutCirc(x)
    return math.sqrt(1 - ((x - 1) ^ 2))
end

local function EaseInOutCirc(x)
    if x < 0.5 then
        return (1 - math.sqrt(1 - ((2 * x) ^ 2))) / 2
    else
        return (math.sqrt(1 - ((-2 * x + 2) ^ 2)) + 1) / 2
    end
end

local cBack = 1.70158
local cBack2 = cBack + 1
local cBack3 = cBack * 1.525
local function EaseInBack(x)
    return cBack2 * (x ^ 3) - cBack * (x ^ 2);
end

local function EaseOutBack(x)
    return 1 + cBack2 * ((x - 1) ^ 3) + cBack * ((x - 1) ^ 2)
end

local function EaseInOutBack(x)
    if x < 0.5 then
        return ((2 * x) ^ 2 * ((cBack3 + 1) * 2 * x - cBack3)) / 2
    else
        return (((2 * x - 2) ^ 2) * ((cBack3 + 1) * (x * 2 - 2) + cBack3) + 2) / 2
    end
end

local cElastic = (2 * math.pi) / 3
local cElastic2 = (2 * math.pi) / 4.5
local function EaseInElastic(x)
    if x == 0 then
        return 0
    elseif x == 1 then
        return 1
    else
        return (-(2 ^ (10 * x - 10))) * math.sin((x * 10 - 10.75) * cElastic)
    end
end

local function EaseOutElastic(x)
    if x == 0 then
        return 0
    elseif x == 1 then
        return 1
    else
        return (2 ^ (-10 * x)) * math.sin((x * 10 - 0.75) * cElastic) + 1
    end
end

local function EaseInOutElastic(x)
    if x == 0 then
        return 0
    elseif x == 1 then
        return 1
    elseif x < 0.5 then
        return -((2 ^ (20 * x - 10))) * math.sin((20 * x - 11.125) * cElastic2) / 2
    else
        return (2 ^ (-20 * x + 10)) * math.sin((20 * x - 11.125) * cElastic2) / 2 + 1
    end
end

local nBounce = 7.5625
local dBounce = 2.75
local function EaseOutBounce(x)
    local x2
    if x < 1 / dBounce then
        return nBounce * (x ^ 2)
    elseif x < 2 / dBounce then
        x2 = x - 1.5 / dBounce
        return nBounce * x2 * x2 + 0.75
    elseif x < 2.5 / dBounce then
        x2 = x - 2.25 / dBounce
        return nBounce * x2 * x2 + 0.9375
    else
        x2 = x - 2.625 / dBounce
        return nBounce * x2 * x2 + 0.984375
    end
end

local function EaseInBounce(x)
    return 1 - EaseOutBounce(1 - x)
end

local function EaseInOutBounce(x)
    if x < 0.5 then
        return (1 - EaseOutBounce(1 - 2 * x)) / 2
    else
        return (1 + EaseInBounce(2 * x - 1)) / 2
    end
end



------- Easings -------
Easings.EaseInSine = EasingFunction:new(EaseInSine, "ease_in_sine")
Easings.EaseOutSine = EasingFunction:new(EaseOutSine, "ease_out_sine")
Easings.EaseInOutSine = EasingFunction:new(EaseInOutSine, "ease_in_out_sine")

Easings.EaseInQuad = EasingFunction:new(EaseInQuad, "ease_in_quad")
Easings.EaseOutQuad = EasingFunction:new(EaseOutQuad, "ease_out_quad")
Easings.EaseInOutQuad = EasingFunction:new(EaseInOutQuad, "ease_in_out_quad")

Easings.EaseInCubic = EasingFunction:new(EaseInCubic, "ease_in_cubic")
Easings.EaseOutCubic = EasingFunction:new(EaseOutCubic, "ease_out_cubic")
Easings.EaseInOutCubic = EasingFunction:new(EaseInOutCubic, "ease_in_out_cubic")

Easings.EaseInQuart = EasingFunction:new(EaseInQuart, "ease_in_quart")
Easings.EaseOutQuart = EasingFunction:new(EaseOutQuart, "ease_out_quart")
Easings.EaseInOutQuart = EasingFunction:new(EaseInOutQuart, "ease_in_out_quart")

Easings.EaseInQuint = EasingFunction:new(EaseInQuint, "ease_in_quint")
Easings.EaseOutQuint = EasingFunction:new(EaseOutQuint, "ease_out_quint")
Easings.EaseInOutQuint = EasingFunction:new(EaseInOutQuint, "ease_in_out_quint")

Easings.EaseInExpo = EasingFunction:new(EaseInExpo, "ease_in_expo")
Easings.EaseOutExpo = EasingFunction:new(EaseOutExpo, "ease_out_expo")
Easings.EaseInOutExpo = EasingFunction:new(EaseInOutExpo, "ease_in_out_expo")

Easings.EaseInCirc = EasingFunction:new(EaseInCirc, "ease_in_circ")
Easings.EaseOutCirc = EasingFunction:new(EaseOutCirc, "ease_out_circ")
Easings.EaseInOutCirc = EasingFunction:new(EaseInOutCirc, "ease_in_out_circ")

Easings.EaseInBack = EasingFunction:new(EaseInBack, "ease_in_back")
Easings.EaseOutBack = EasingFunction:new(EaseOutBack, "ease_out_back")
Easings.EaseInOutBack = EasingFunction:new(EaseInOutBack, "ease_in_out_back")

Easings.EaseInElastic = EasingFunction:new(EaseInElastic, "ease_in_elastic")
Easings.EaseOutElastic = EasingFunction:new(EaseOutElastic, "ease_out_elastic")
Easings.EaseInOutElastic = EasingFunction:new(EaseInOutElastic, "ease_in_out_elastic")

Easings.EaseInBounce = EasingFunction:new(EaseInBounce, "ease_in_bounce")
Easings.EaseOutBounce = EasingFunction:new(EaseOutBounce, "ease_out_bounce")
Easings.EaseInOutBounce = EasingFunction:new(EaseInOutBounce, "ease_in_out_bounce")



---------
return {
    EasingFunction = EasingFunction,
    Easings = Easings,
}