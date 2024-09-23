local component = {}
component.__index = component

local cwd = (...):gsub('%.init$', '')

component.Group = require(cwd .. ".group")
component.Rect = require(cwd .. ".rect")
component.Sprite = require(cwd .. ".sprite")

return component