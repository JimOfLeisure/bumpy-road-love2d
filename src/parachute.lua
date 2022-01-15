local Parachute = {}

local Game_component = require("generics.game-component")
local Vec2 = require("generics.vec2")

-- optimizations
local graphics = love.graphics

-- requires a love.physics.world reference from shared data table
function Parachute:new(data)
    local obj = Game_component:new()
    obj.data = data
    obj.image = graphics.newImage("Parachute-icon.png")
    function obj:load()
    end

    function obj:update(dt)
    end

    function obj:draw()
        if self.data.parachute_deployed then
            graphics.setColor(1, 1, 1)
            graphics.draw(self.image, data.pos.x, data.pos.y, data.parachute_angle, 0.8, nil, 20, 125)
        end
    end

    return obj
end

return Parachute
