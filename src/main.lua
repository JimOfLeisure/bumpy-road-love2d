-- global = require("global-data")

local Game_scene = require("game-scene")
local game_scene = Game_scene:new()

function love.load()
    game_scene:load()
end

function love.update(dt)
    game_scene:update(dt)
end

function love.draw()
    game_scene:draw()
end
