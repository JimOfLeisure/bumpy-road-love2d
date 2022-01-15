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
        table.insert(self.components, Parachute:new(data))
        table.insert(self.components, self.ball)
        -- TODO: parameterize x/i and y
        for i=0,1100,100 do
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

        if data.pos.y > 750 then
            ball:reset()
            data:reset_angle()
        end

        if data.parachute_deployed and data.pos.y > 400 then
            data.parachute_deployed = false
            self.ball.body:setAngularDamping(0)
            --[[
            if data.game_start then
                data.game_start = false
                history_100m[0] = timer
                history_1km[0] = timer
            end
            ]]
        end
    
        for _, component in ipairs(self.components) do
            component:update(dt)
        end
        if data.parachute_deployed then
            local sx, sy = self.ball.body:getLinearVelocity()
            self.ball.body:applyForce(-sx * data.parachute_drag, -sy * data.parachute_drag)
            -- 1.37 is a quarter turn because 0 is to the right; 0.8 is because parachute image is diagonal
            data.parachute_angle = math.atan(sy / sx) -1.37 - 0.8
            if sx < 0 then
                data.parachute_angle = data.parachute_angle + math.pi
            end
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
