local ShaderManager = {}
ShaderManager.__index = ShaderManager

-- constructor
function ShaderManager:new()
    local instance = {
        _shaders = {}
    }
    return setmetatable(instance, ShaderManager)
end

-- add a shader
function ShaderManager:add(shaderName, shaderPath)
    self._shaders[shaderName] = love.graphics.newShader(shaderPath)
end

-- get the shader
function ShaderManager:get(shaderName)
    return self._shaders[shaderName]
end

-- remove shader
function ShaderManager:remove(shaderName)
    return table.remove(self._shaders, shaderName)
end

return ShaderManager