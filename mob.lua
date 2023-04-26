Mob = Class:extend()

function Mob:new(framesResources, resourceName, x, y)
    self.sprites = {}
    self.framesResources = framesResources
    self.resourceName = resourceName
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
end

function Mob:update(dt)
    self:animation(dt)
end

function Mob:draw()
    love.graphics.draw(self.sprites[self.currentFrame], self.x, self.y)
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
            if self:attack(self.x) then
                self.xDirectionIsLeft = false
                --solta poder
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

function Mob:attack(x)
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
