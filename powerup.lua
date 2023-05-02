Powerup = Class:extend()

function Powerup:new(x, y, resourceName)
    self.framesResources = 2
    self.resourceName = resourceName
    self.sprites = {}
    for i = 0, self.framesResources do
        table.insert(self.sprites, love.graphics.newImage("resources/" .. resourceName .. " (" .. i .. ").png"))
    end
    self.currentFrame = 1
    self.animTimer = 0
    self.x = x - (self.sprites[self.currentFrame]:getWidth() * 0.14)
    self.y = y - (self.sprites[self.currentFrame]:getHeight() * 0.14) + 3
    self.l = self.sprites[self.currentFrame]:getWidth() * 0.14
    self.a = self.sprites[self.currentFrame]:getHeight() * 0.14
end

function Powerup:update(dt)
    self.x = self.x - 150 * dt
    self:animation(dt)
end

function Powerup:draw()
    love.graphics.draw(self.sprites[self.currentFrame], self.x, self.y, 0, 0.14, 0.14)
end

function Powerup:animation(dt)
    self.animTimer = self.animTimer + dt
    if self.animTimer >= 0.1 then
        self.currentFrame = self.currentFrame + 1
        if self.currentFrame > #self.sprites then
            self.currentFrame = 1
        end
        self.animTimer = 0
    end
end
