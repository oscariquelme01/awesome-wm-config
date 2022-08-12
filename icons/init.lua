
--- Icons directory
local gfs = require("gears.filesystem")
local dir = gfs.get_configuration_dir() .. "icons/"

return {
    ghost = dir .. "ghost.svg",
    scared_ghost = dir .. "scared-ghost.svg",
    circle = dir .. "circle.svg"

}
