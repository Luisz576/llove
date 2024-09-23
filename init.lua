local llove = {
    _NAME = "LLove",
    _URL = "https://github.com/Luisz576/llove",
    _AUTHOR = "Luisz576"
}
llove.__index = llove

local cwd = (...):gsub('%.init$', '')

llove.component = require(cwd .. ".component")
llove.math = require(cwd .. ".math")
llove.util = require(cwd .. ".util")

return setmetatable({}, llove)