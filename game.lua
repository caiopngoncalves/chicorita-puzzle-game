Game = Class:extend()

function Game:new()
    self.chicorita = Chicorita()
    self.score = Score()
    self.initialTime = love.timer.getTime()
    self.currrentMob = -1
    self.cyndaquil = Mob(84, "cyndaquil", "fire", 600, love.graphics.getHeight() / 2)
    self.totodile = Mob(54, "totodile", "water", 600, love.graphics.getHeight() / 4 * 3)
    self.background = love.graphics.newImage("resources/background.jpg")
end

function Game:update(dt)
    if (not self:gameOver()) then
        self.chicorita:update(dt)
        self.cyndaquil:update(dt)
        self.totodile:update(dt)

        for i, powerUp in ipairs(self.cyndaquil.powerUp) do
            if (self:hitbox(self.chicorita, powerUp)) then
                self.score.life = self.score.life - 1
                table.remove(self.cyndaquil.powerUp, i)
            end
        end

        for i, powerUp in ipairs(self.totodile.powerUp) do
            if (self:hitbox(self.chicorita, powerUp)) then
                self.score.points = self.score.points + 1
                table.remove(self.totodile.powerUp, i)
            end
        end

        self:round(dt)
        if (self.currrentMob == 0) then
            if self.cyndaquil.moved then
                self:resetRound()
            end
        elseif (self.currrentMob == 1) then
            if self.totodile.moved then
                self:resetRound()
            end
        end
    end
end

function Game:draw()
    love.graphics.draw(self.background, 0, 0, 0, 0.6, 0.755)
    self.chicorita:draw()
    self.cyndaquil:draw()
    self.totodile:draw()
    self.score:draw()
    if self:gameOver() then
        love.graphics.print("Game Over", 207, 200)
    end
end

function Game:round(dt)
    self:raffle(0.6)
    if (self.currrentMob == 1) then
        self.totodile:move(dt)
    else
        self.cyndaquil:move(dt)
    end
end

function Game:raffle(chanceUm)
    local value = math.random()
    if (self.currrentMob == -1) then
        if value <= chanceUm then
            self.totodile:raffleYPostion()
            self.currrentMob = 1
        else
            self.cyndaquil:raffleYPostion()
            self.currrentMob = 0
        end
    end
end

function Game:resetRound()
    self.initialTime = love.timer.getTime()
    self.currrentMob = -1
    self.cyndaquil.moved = false
    self.totodile.moved = false
end

function Game:hitbox(A, B)
    if A.x < B.x + B.l and
        A.x + A.l > B.x and
        A.y < B.y + B.a and
        A.y + A.a > B.y then
        return true
    end
end

function Game:gameOver()
    if self.score.life <= 0 then
        return true
    end
    return false
end
