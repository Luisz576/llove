local LLoveParticles = {}
LLoveParticles.__index = LLoveParticles

------ IMPORTS ------
local love = require "love"



------ DEFINITIONS ------
local ParticlesManager = {}
ParticlesManager.__index = ParticlesManager

local ParticlesMeta = {}
ParticlesMeta.__index = ParticlesMeta

---@enum AreaSpreadDistribution
local AreaSpreadDistribution = {
    NONE = "none",
    UNIFORM = "uniform",
    NORMAL = "normal",
    -- avaliable after Love2D 0.10.2
    ELLIPSE = "ellipse",
    -- avaliable after Love2D 11.0
    BORDERELLIPSE = "borderellipse",
    BORDERRECTANGLE= "borderrectangle"
}

---@class ParticlesMeta
---@field image any
---@field imagePath string
---@field particleLifeTime {min:number, max: number} | nil
---@field sizeVariation any | nil
---@field sizes number[] | nil
---@field speed {min:number, max: number} | nil
---@field spread any | nil
---@field direction any | nil
---@field emissionRate any | nil
---@field emissionArea {distribution: AreaSpreadDistribution, width: number, height: number, rotation: number} | nil
---@field offset {x: number, y: number} | nil

---@class ParticlesMetaProps
---@field particleLifeTime {min:number, max: number} | nil
---@field sizeVariation any | nil
---@field sizes number[] | nil
---@field speed {min:number, max: number} | nil
---@field spread any | nil
---@field direction any | nil
---@field emissionRate any | nil
---@field emissionArea {distribution: AreaSpreadDistribution, width: number, height: number, rotation: number} | nil
---@field offset {x: number, y: number} | nil



------ PARTICLES META --------
-- constructor
---@param imagePath string
---@param meta ParticlesMetaProps
---@return ParticlesMeta
function ParticlesMeta:new(imagePath, meta)
    local instance = {
        imagePath = imagePath,
        image = love.graphics.newImage(imagePath),
        particleLifeTime = meta.particleLifeTime,
        sizeVariation = meta.sizeVariation,
        sizes = meta.sizes,
        speed = meta.speed,
        spread = meta.spread,
        direction = meta.direction,
        emissionRate = meta.emissionRate,
        emissionArea = meta.emissionArea,
        offset = meta.offset
    }
    return setmetatable(instance, self)
end

-- clone with properties
---@param newMeta ParticlesMetaProps
---@return ParticlesMeta
function ParticlesMeta:clone(newMeta)
    local copy = {}
    for k, v in pairs(self) do
        if newMeta[k] ~= nil then
            copy[k] = newMeta[k]
        else
            copy[k] = v
        end
    end
    return copy
end


------- PARTICLES MANAGER --------
--constructor
function ParticlesManager:new()
    local instance = {
        _particles = {}
    }
    return setmetatable(instance, self)
end

-- register particles
---@param particleName string
---@param particleMeta ParticlesMeta
function ParticlesManager:register(particleName, particleMeta)
    -- create
    particleMeta.particles = love.graphics.newParticleSystem(particleMeta.image)
    -- set properties
    if particleMeta.particleLifeTime ~= nil then
        particleMeta.particles:setParticleLifetime(particleMeta.particleLifeTime.min, particleMeta.particleLifeTime.max)
    end
    if particleMeta.sizeVariation ~= nil then
        particleMeta.particles:setSizeVariation(particleMeta.sizeVariation)
    end
    if particleMeta.sizes ~= nil then
        particleMeta.particles:setSizes(unpack(particleMeta.sizes))
    end
    if particleMeta.speed ~= nil then
        particleMeta.particles:setSpeed(particleMeta.speed.min, particleMeta.speed.max)
    end
    if particleMeta.spread ~= nil then
        particleMeta.particles:setSpread(particleMeta.spread)
    end
    if particleMeta.direction ~= nil then
        particleMeta.particles:setDirection(particleMeta.direction)
    end
    if particleMeta.emissionRate ~= nil then
        particleMeta.particles:setEmissionRate(particleMeta.emissionRate)
    end
    if particleMeta.emissionArea ~= nil then
        particleMeta.particles:setEmissionArea(particleMeta.emissionArea.distribution, particleMeta.emissionArea.width, particleMeta.emissionArea.height, particleMeta.emissionArea.rotation)
    end
    if particleMeta.offset ~= nil then
        particleMeta.particles:setOffset(particleMeta.offset.x, particleMeta.offset.y)
    end
    -- register
    self._particles[particleName] = particleMeta
end

-- get the particles
function ParticlesManager:getParticles(particleName)
    local particlesMeta = self._particles[particleName]
    if particlesMeta ~= nil then
        return particlesMeta.particles
    end
    return nil
end
-- get the particles
function ParticlesManager:getParticlesMeta(particleName)
    return self._particles[particleName]
end

--------
LLoveParticles.ParticlesManager = ParticlesManager
LLoveParticles.ParticlesMeta = ParticlesMeta

return LLoveParticles