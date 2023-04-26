Class = require "classic"
anim8 = require('anim8')
require "game"
require "chicorita"
require "score"
require "mob"
require "powerup"


function love.load()
    love.window.setMode(600, 400)
    math.randomseed(os.time())
    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end
