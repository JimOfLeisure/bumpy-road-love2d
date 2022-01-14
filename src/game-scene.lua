local Game_scene = {}

-- optimization
local love = love
local global = global

local conf = {}
conf.meter_size = 64
conf.gravity = 9.81 * conf.meter_size
conf.x_offset = love.graphics.getWidth() / 2 - 100
conf.y_offset = love.graphics.getHeight() / 2

local Game_component = require("generics.game-component")
local Sky = require("Sky")
local Ball = require("Ball")

local camera_on = Game_component:new()
function camera_on:draw()
    love.graphics.push()
    love.graphics.translate(conf.x_offset,conf.y_offset)
    love.graphics.rotate(-(global.angle - (math.pi / 2)))
    love.graphics.translate(-global.pos.x, -global.pos.y)
end

local camera_off = Game_component:new()
function camera_off:draw()
    love.graphics.pop()
end

function Game_scene:new()
    local gs = Game_component:new()
    gs.world = love.physics.newWorld()

    -- want named reference to the ball
    gs.ball = Ball:new(gs.world)
    gs.components = {}

    function gs:load()
        love.physics.setMeter(conf.meter_size)
        table.insert(self.components, Sky:new())
        table.insert(self.components, camera_on)
        table.insert(self.components, self.ball)
        table.insert(self.components, camera_off)
        for _, component in ipairs(self.components) do
            component:load()
        end
    end

    function gs:update(dt)
        self.world:update(dt)
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
