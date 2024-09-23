local LLove = {
    _NAME = "LLove",
    _URL = "https://github.com/Luisz576/llove",
    -- _VERSION = "",
    _AUTHOR = "Luisz576"
}
LLove.__index = LLove

local cwd = (...):gsub('%.init$', '')

LLove.component = require(cwd .. ".component")
LLove.math = require(cwd .. ".math")
LLove.util = require(cwd .. ".util")
LLove.animation = require(cwd .. ".animation")

return setmetatable({}, LLove)