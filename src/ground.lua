local Ground = {}

-- optimization
local graphics = love.graphics
local global = global

local Game_component = require("generics.game-component")
local Vec2 = require("generics.vec2")

-- add to noise parameter to randomize the noise results between games
local NOISE_ORIGIN = (love.math.random() -0.5) * 3000
local NOISE_SCALE = 0.005
local BUMP_SCALE = 30
local ground_sections = {}
-- local world

function Ground:new(world, pos)
    local obj = Game_component:new()
    obj.world = world
    function obj:respawn(pos)
        self.pos = pos
        self.body = love.physics.newBody(self.world, self.pos.x, self.pos.y, "static")

        local coords = {}
        for i=-50,50,20 do
            table.insert(coords, i)
            table.insert(coords, -25 - (love.math.noise(NOISE_ORIGIN + ((self.pos.x + i) * NOISE_SCALE)) * BUMP_SCALE))
        end
        for _, e in ipairs({ 50, 450, -50, 450 }) do
            table.insert(coords, e)
        end
        
        obj.shape = love.physics.newPolygonShape(coords)
        obj.fixture = love.physics.newFixture(obj.body, obj.shape)
    end
    function obj:draw()
        graphics.setColor(0.28, 0.63, 0.05)
        graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
    end
    obj:respawn(pos)

    return obj
end
--[[
function Ground:load(physics_world)
    world = physics_world
    for i=0,1100,100 do
        table.insert(ground_sections, new_ground_section(i, 500))
    end
end

function Ground:update(float_x)
    local x = math.floor(float_x)
    for i, section in ipairs(ground_sections) do
        if x - section.body:getX() > 500 then
            -- hopefully releasing the memory this way; release() left the physics objects in place
            section.fixture:destroy()
            -- section.shape:destroy()
            section.body:destroy()
            ground_sections[i] = new_ground_section((math.floor(x / 100) * 100) + 700, 500)
        end
    end
end

end
]]
return Ground
