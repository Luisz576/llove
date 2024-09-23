local math = {}
math.__index = math

local cwd = (...):gsub('%.init$', '')

math.Vector2d = require(cwd .. ".vector2d")

return math