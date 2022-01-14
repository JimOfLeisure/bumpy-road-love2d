local Ball = {}

local Game_component = require("generics.game-component")
local Vec2 = require("generics.vec2")

-- optimizations
local graphics = love.graphics

function Ball:new()
    local obj = Game_component:new()
    obj.pos = Vec2:new()

    function obj:load()
    end

    function obj:update(dt)
    end

    function obj:draw()

    end

    return obj
end

return Ball
