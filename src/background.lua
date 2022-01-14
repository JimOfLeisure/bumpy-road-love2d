local Background = {}

local Game_component = require("generics.game-component")

function Background:new()
    local bg = Game_component:new()

    function bg:load()
    end

    function bg:update(dt)
    end

    function bg:draw()
    end

    return bg
end

return Background
