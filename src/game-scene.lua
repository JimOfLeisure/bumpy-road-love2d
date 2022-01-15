local Game_scene = {}

-- optimization
local love = love
local global = global

local Game_component = require("generics.game-component")
local Vec2 = require("generics.vec2")
local Sky = require("Sky")
local Ball = require("Ball")
local Ground = require("Ground")

local conf = {}
conf.meter_size = 64
conf.gravity = 9.81 * conf.meter_size
conf.x_offset = love.graphics.getWidth() / 2 - 100
conf.y_offset = love.graphics.getHeight() / 2

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

    function gs:set_gravity()
        self.world.setGravity(self.world, math.cos(global.angle) * conf.gravity, math.sin(global.angle) * conf.gravity)
    end

    function gs:load()
        love.physics.setMeter(conf.meter_size)
        table.insert(self.components, Sky:new())
        table.insert(self.components, camera_on)
        table.insert(self.components, self.ball)
        -- TODO: parameterize x/i and y
        for i=0,1100,100 do
            table.insert(self.components, Ground:new(self.world, Vec2:new(i, 500)))
        end
        table.insert(self.components, camera_off)
        for _, component in ipairs(self.components) do
            component:load()
        end
        -- TEMP ?? probably needs x & y calculated
        -- self.world:setGravity(0, conf.gravity)
        self:set_gravity()
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
