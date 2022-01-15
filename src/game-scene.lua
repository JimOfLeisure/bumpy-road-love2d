local Game_scene = {}

-- optimization
local love = love

local Game_component = require("generics.game-component")
local Vec2 = require("generics.vec2")
local Sky = require("sky")
local Parachute = require("parachute")
local Ball = require("ball")
local Ground = require("ground")
local data = require("game-scene-data")

local camera_on = Game_component:new()
function camera_on:draw()
    love.graphics.push()
    love.graphics.translate(data.conf.x_offset(),data.conf.y_offset())
    love.graphics.rotate(-(data.angle - (math.pi / 2)))
    love.graphics.translate(-data.pos.x, -data.pos.y)
end

local camera_off = Game_component:new()
function camera_off:draw()
    love.graphics.pop()
end

function Game_scene:new()
    local gs = Game_component:new()

    -- want named reference to the ball
    gs.ball = Ball:new(data)
    gs.components = {}

    function gs:set_gravity()
        data.world.setGravity(data.world, math.cos(data.angle) * data.conf.gravity, math.sin(data.angle) * data.conf.gravity)
    end

    function gs:load()
        love.physics.setMeter(data.conf.meter_size)
        table.insert(self.components, Sky:new())
        table.insert(self.components, camera_on)
        table.insert(self.components, Parachute:new(data, self.ball))
        table.insert(self.components, self.ball)
        -- TODO: parameterize x/i and y
        for i=-300,800,100 do
            table.insert(self.components, Ground:new(data, Vec2:new(i, 500)))
        end
        table.insert(self.components, camera_off)
        for _, component in ipairs(self.components) do
            component:load()
        end
        self:set_gravity()
    end

    function gs:update(dt)
        data.world:update(dt)

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
