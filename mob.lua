Mob = Class:extend()

function Mob:new(framesResources, resourceName, atkResourceName, x, y)
    self.sprites = {}
    self.framesResources = framesResources
    self.resourceName = resourceName
    self.atkResourceName = atkResourceName
    for i = 1, self.framesResources do
        table.insert(self.sprites, love.graphics.newImage("resources/" .. resourceName .. " (" .. i .. ").png"))
    end
    self.currentFrame = 1
    self.animTimer = 0
    self.x = x - self.sprites[self.currentFrame]:getWidth()
    self.y = y - self.sprites[self.currentFrame]:getHeight()
    self.moveTimer = 0
    self.xDirectionIsLeft = true
    self.isMoving = true
    self.moved = false;
    self.powerUp = {}
end

function Mob:update(dt)
    self:animation(dt)

    for i, powerUp in ipairs(self.powerUp) do
        powerUp:update(dt)
        if (powerUp.x <= -50) then
            table.remove(self.powerUp, i)
        end
    end
end

function Mob:draw()
    love.graphics.draw(self.sprites[self.currentFrame], self.x, self.y)
    for i, powerUp in ipairs(self.powerUp) do
        powerUp:draw()
    end
end

function Mob:animation(dt)
    self.animTimer = self.animTimer + dt
    if self.animTimer >= 0.1 then
        self.currentFrame = self.currentFrame + 1
        if self.currentFrame > #self.sprites then
            self.currentFrame = 1
        end
        self.animTimer = 0
    end
end

function Mob:move(dt)
    if self.isMoving then
        if self.xDirectionIsLeft then
            self.x = self.x - 150 * dt
            if self:attackMoment(self.x) then
                self.xDirectionIsLeft = false
                self:attack()
            end
        else
            self.x = self.x + 150 * dt
            if self:wait(self.x) then
                self.x = 550
                self.moved = true
                self.xDirectionIsLeft = true
            end
        end
    end
end

function Mob:attackMoment(x)
    if x >= 450 then
        return false
    else
        return true
    end
end

function Mob:wait(x)
    if x <= 550 then
        return false
    else
        return true
    end
end

function Mob:raffleYPostion()
    local value = math.random()
    if value <= 0.33 then
        self.y = (love.graphics.getHeight() / 4) - self.sprites[self.currentFrame]:getHeight()
    elseif value > 0.33 and value <= 0.66 then
        self.y = (love.graphics.getHeight() / 2) - self.sprites[self.currentFrame]:getHeight()
    else
        self.y = (love.graphics.getHeight() / 4 * 3) - self.sprites[self.currentFrame]:getHeight()
    end
end

function Mob:attack()
    table.insert(self.powerUp,
        Powerup(self.x, self.y + self.sprites[self.currentFrame]:getHeight() - 25, self.atkResourceName))
end
