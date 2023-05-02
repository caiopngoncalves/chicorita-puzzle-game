Score = Class:extend()

function Score:new()
    self.lifeSprite = love.graphics.newImage("resources/life.png")
    self.font = love.graphics.newFont("resources/font.ttf", 12)
    self.life = 3
    self.lifeX = 20
    self.lifeY = 20
    self.points = 0
    self.pointsX = 350
    self.pointsY = 25
end

function Score:update(dt)

end

function Score:draw()
    for i = 0, self.life - 1, 1 do
        love.graphics.draw(self.lifeSprite, self.lifeX + 30 * i, self.lifeY, 0, 0.05, 0.05)
    end
    love.graphics.setFont(self.font)
    love.graphics.print("SCORE: " .. self.points, self.pointsX, self.pointsY)
end
