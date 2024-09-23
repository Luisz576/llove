local util = {}
util.__index = util

local cwd = (...):gsub('%.init$', '')

util.Axis = require(cwd .. ".axis")
util.Direction = require(cwd .. ".direction")

return util