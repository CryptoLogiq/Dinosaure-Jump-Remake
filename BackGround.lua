local BackGround = {debug=false}

local lg = love.graphics

local Lst_bgs = {}

local refSpeed = {0.15, 0.20, 0.5, 0.5, 0.5, 1}


local drawImg = function(self)
  if self.id == 5 then -- ombre cactus
    love.graphics.setColor(1,1,1,CycleJourNuit.alpha)
  else
    love.graphics.setColor(1,1,1,1)
  end
  love.graphics.draw(self.imgdata, self.x, self.y)
  love.graphics.draw(self.imgdata, self.x-self.w, self.y)
  --
  love.graphics.setColor(1,1,1,1)
end
--

local updateImg = function(self, dt)
  self.speed=(0-Game.speed) * self.speedRef
  self.x = ( self.x + (self.speed * dt) ) % love.graphics.getWidth()
end
--

function BackGround.addImages()
  local dir = "Ressources/Desert/"
  for n=1, 6 do
    local file = dir..n..".png"
    local imgdata = lg.newImage(file)
    local bg = {imgdata=imgdata, id=n, x=0, y=0, alpha=1, speedRef=refSpeed[n], speed=(0-Game.speed)*refSpeed[n], w=imgdata:getWidth(), h=imgdata:getHeight(), draw=drawImg, update=updateImg}
    table.insert(Lst_bgs, bg)
  end
end
--

function BackGround.reset()
  for n=1, #Lst_bgs do
    local bg = Lst_bgs[n]
    bg.x = 0
  end
end
--

function BackGround.load()
  BackGround.addImages()
end
--

function BackGround.update(dt)
  if Game.start and DinoGame.live then
    for n=1, #Lst_bgs do
      local bg = Lst_bgs[n]
      bg:update(dt)
    end
  elseif Game.start == false then
    BackGround.reset()
  end
end
--

function BackGround.draw()
  for n=1, #Lst_bgs do
    local bg = Lst_bgs[n]
    bg:draw()
  end
end
--

return BackGround