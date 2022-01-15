local Screen_text = {}

local Game_component = require("generics.game-component")
local Vec2 = require("generics.vec2")

-- optimizations
local love = love

local stats = {
    fastest_100m = 99999,
    fastest_1km = 99999,
    history_100m = {},
    history_1km = {},
    current_meter = 0,
    -- game_start = true,
    ready_100m = false,
    ready_1km = false,
}

function Screen_text:new(data)
    local obj = Game_component:new()
    obj.data = data
    obj.font = love.graphics.newFont(20)

    function obj:load()
        local timer = love.timer.getTime()
        stats.history_100m[0] = timer
        stats.history_1km[0] = timer
    end

    function obj:update(dt)
        if math.floor((data.pos.x) / data.conf.meter_size) ~= current_meter then
            local timer = love.timer.getTime()
            if stats.ready_100m or stats.current_meter > 100 then
                stats.ready_100m = true
                local dtime = timer - stats.history_100m[stats.current_meter % 100]
                if dtime < stats.fastest_100m then
                    stats.fastest_100m = dtime
                end
                if stats.ready_1km or stats.current_meter > 1000 then
                    stats.ready_1km = true
                    local dtime = timer - history_1km[current_meter % 1000]
                    if dtime < stats.fastest_1km then
                        stats.fastest_1km = dtime
                    end
                end
        
            end
            stats.history_100m[stats.current_meter % 100] = timer
            stats.history_1km[stats.current_meter % 1000] = timer
            stats.current_meter = stats.current_meter + 1
        end
    end

    function obj:draw()
        love.graphics.setFont(self.font)
        if data.instructions then
            love.graphics.setColor(0.8, 0.1, 0.1)
            love.graphics.print("Drag up/down to change angle", 100, 100)
        end
    end

    return obj
end

return Screen_text
