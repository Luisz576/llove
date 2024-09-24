local LLove = {
    _NAME = "LLove",
    _URL = "https://github.com/Luisz576/llove",
    -- _VERSION = "",
    _AUTHOR = "Luisz576"
}
LLove.__index = LLove

local cwd = (...):gsub('%.init$', '')

LLove.animation = require(cwd .. ".animation")
LLove.color = require(cwd .. ".color")
LLove.component = require(cwd .. ".component")
LLove.math = require(cwd .. ".math")
LLove.util = require(cwd .. ".util")

return setmetatable({}, LLove)