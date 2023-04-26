Game = Class:extend()

function Game:new()
    self.chicorita = Chicorita()
    self.initialTime = love.timer.getTime()
    self.currrentMob = -1
    self.cyndaquil = Mob(84, "cyndaquil", 600, love.graphics.getHeight() / 2)
    self.totodile = Mob(54, "totodile", 600, love.graphics.getHeight() / 4 * 3)
    math.randomseed(os.time())
    self.alreadyRaffle = false
end

function Game:update(dt)
    self.chicorita:update(dt)
    self.cyndaquil:update(dt)
    self.totodile:update(dt)
    local currentTime = love.timer.getTime()
    if (currentTime - self.initialTime >= 2) then
        self:round(dt)
        if (self.currrentMob == 1) then
            if self.totodile.moved then
                self:resetRound()
            end
        elseif (self.currrentMob == 0) then
            if self.cyndaquil.moved then
                self:resetRound()
            end
        end
    end
end

function Game:draw()
    self.chicorita:draw()
    self.cyndaquil:draw()
    self.totodile:draw()
end

function Game:round(dt)
    self:sorteio(0.6)
    if (self.currrentMob == 1) then
        self.totodile:move(dt)
    else
        self.cyndaquil:move(dt)
    end
end

function Game:sorteio(chanceUm)
    local valorSorteado = math.random()
    if (self.currrentMob == -1) then
        if valorSorteado <= chanceUm then
            self.currrentMob = 1
        else
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
