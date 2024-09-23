local llove = {}
llove.__index = llove

local cwd = (...):gsub('%.init$', '')

llove.component = require(cwd .. ".component")
llove.math = require(cwd .. ".math")

return setmetatable({}, llove)