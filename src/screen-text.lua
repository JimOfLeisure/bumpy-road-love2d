local Screen_text = {}

local Game_component = require("generics.game-component")
local Vec2 = require("generics.vec2")

-- optimizations
local love = love

function Screen_text:new(data, target)
    local obj = Game_component:new()
    obj.data = data
    obj.font = love.graphics.newFont(20)

    function obj:load()
    end

    function obj:update(dt)
    end

    function obj:draw()
        love.graphics.setFont(self.font)
        if data.instructions then
            love.graphics.setColor(0.8, 0.1, 0.1)
            love.graphics.print("Drag up/down to change angle", 100, 100)
        end
    end

    return obj
end

return Screen_text
