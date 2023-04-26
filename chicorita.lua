Chicorita = Class:extend()

function Chicorita:new()
    self.sprites = {}
    for i = 1, 36 do
        table.insert(self.sprites, love.graphics.newImage("resources/chicorita (" .. i .. ").png"))
    end
    self.currentFrame = 1
    self.animTimer = 0
    self.l = self.sprites[self.currentFrame]:getWidth()
    self.a = self.sprites[self.currentFrame]:getHeight()
    self.x = 50 - self.l
    self.y = love.graphics.getHeight() / 2
end

function Chicorita:update(dt)
    self:animation(dt)
    self:mechanics()
end

function Chicorita:draw()
    love.graphics.draw(self.sprites[self.currentFrame], self.x + self.a, self.y, 0, -1, 1)
end

function Chicorita:animation(dt)
    self.animTimer = self.animTimer + dt
    if self.animTimer >= 0.1 then
        self.currentFrame = self.currentFrame + 1
        if self.currentFrame > #self.sprites then
            self.currentFrame = 1
        end
        self.animTimer = 0
    end
end

function Chicorita:mechanics()
    if love.keyboard.isDown("s") then
        self.y = ((love.graphics.getHeight() / 4) * 3) - self.a
    elseif love.keyboard.isDown("w") then
        self.y = (love.graphics.getHeight() / 4) - self.a
    else
        self.y = love.graphics.getHeight() / 2 - self.a
    end
end
