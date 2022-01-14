local Game_scene = {}

local Game_component = require("generics.game-component")

function Game_scene:new()
    local gs = Game_component:new()

    function gs:load()
    end

    function gs:update(dt)
    end

    function gs:draw()
    end

    return gs
end

return Game_scene
