local Background = {}

local Game_component = require("generics.game-component")

-- optimizations
local graphics = love.graphics

local sky_shader = graphics.newShader([[
    extern vec2 u_screen_size;

    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
        float dist = distance(screen_coords, vec2(u_screen_size.x, 0)) / max(u_screen_size.x, u_screen_size.y);
        dist = dist * 1.5;
        dist = 1.0 - clamp(dist, 0.0, 0.4);
        return vec4(dist, dist, dist, 1.0) * color;
    }
]])

function Background:new()
    local bg = Game_component:new()

    function bg:load()
    end

    function bg:update(dt)
    end

    function bg:draw()
        graphics.setShader(sky_shader)
        sky_shader:send("u_screen_size", { graphics.getWidth(), graphics.getHeight()})
        graphics.setColor(0.529, 0.808, 0.922)
        graphics.rectangle("fill", 0, 0, graphics.getWidth(), graphics.getHeight())
        graphics.setShader()
    end

    return bg
end

return Background