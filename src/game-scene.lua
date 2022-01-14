local Game_scene = {}

local Game_component = require("generics.game-component")
local Sky = require("Sky")
local Ball = require("Ball")

function Game_scene:new()
    local gs = Game_component:new()
    gs.world = love.physics.newWorld()

    gs.components = {}

    function gs:load()
        table.insert(self.components, Sky:new())
        table.insert(self.components, Ball:new(self.world))
        for _, component in ipairs(self.components) do
            component:load()
        end
    end

    function gs:update(dt)
        for _, component in ipairs(self.components) do
            component:update(dt)
        end
    end

    function gs:draw()
        for _, component in ipairs(self.components) do
            component:draw()
        end
    end

    return gs
end

return Game_scene
