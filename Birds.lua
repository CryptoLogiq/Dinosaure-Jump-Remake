local Birds = {debug=false}

local list_img = {}

local Lst_Birds = {}

local timer = {current=0, delai=40, speed=10}

function timer.reset()
  timer.current=0
  timer.delai=60
  timer.speed=10
end
--

function timer.update(dt)
  timer.current = timer.current + timer.speed * dt
  if timer.current >= timer.delai then
    timer.current = 0
    timer.delai = love.math.random(20,60)
    return true
  end
  return false
end
--

local timerupdate = function(self, dt)
  local t = self.timer
  t.current = t.current + (t.speed * dt)
  if t.current >= t.delai then
    t.current = 0
    self.frame = self.frame + 1
    if self.frame > self.maxframe then
      self.frame = 1
    end
  end
end
--

local update = function(self, dt)
  if self.timer.update(dt) then
  end
end
--

local draw = function(self)
end
--

function Birds.new(x,y)
  local bird = {x=x, y=y, w=0, h=0, frame=1, maxframe=8, isLife=true, update=update, draw=draw, timer={current=0, delai=10, speed=60, update=timerupdate}}
  table.insert(Lst_Birds, bird)
end
--

function Birds.reset()
  Lst_Birds = {}
  timer.reset()
end
--

function Birds.loadImages()
  local dir = "Ressources/Bird/"
  local filename = "frame-"
  local typeFile = ".png"
  for n=1, 8 do
    local img = love.graphics.newImage(dir..filename..n..typeFile)
    local w, h = img:getDimensions()
    local newImg = {imgdata=img, w=w, h=h}
    table.insert(list_img, newImg)
  end
end
--

function Birds.load()
  Birds.loadImages()
end
--

function Birds.update(dt)
end
--

function Birds.draw()
end
--

function Birds.mousepressed(x,y,button)
end
--

function Birds.keypressed(key)
end
--

return Birds