-- Global data store

-- Gravity & camera angle at game start and after ball respawn
local default_angle = math.pi / 2 - 0.2
local default_y = 0

local Vec2 = require("generics.vec2")

Global = {
    pos = Vec2:new(0, default_y),
    angle = default_angle,
    default_angle = default_angle,
    parachute_deploys = 0,
}

function Global:reset_angle()
    self.angle = self.default_angle
end

function Global:reset_y()
    self.y = default_y
end

return Global