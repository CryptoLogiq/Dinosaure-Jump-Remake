-- Globals

love.filesystem.setIdentity("Dinosaure Jump Remake")

love.graphics.setDefaultFilter("nearest")

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
  x2 < x1+w1 and
  y1 < y2+h2 and
  y2 < y1+h1
end
--

function AABB(object, versus)
  return CheckCollision(object.x,object.y,object.w,object.h, versus.x,versus.y,versus.w,versus.h)
end
--

-- Ecran
Screen = {w=960, h=540}
Screen.cx, Screen.cy = Screen.w/2, Screen.h/2

-- Fonts
Font = {}

Font.Defaut = {}
for n=12, 48, 2 do
  Font.Defaut[n] = love.graphics.getFont(n)
end

Font.Caveat = {}
for n=12, 48, 2 do
  Font.Caveat[n] = love.graphics.newFont("Ressources/Font/Caveat-VariableFont_wght.ttf", n)
end

-- Mouse
Mouse = love.mouse
Mouse.x = 0
Mouse.y = 0
Mouse.w = 1
Mouse.h = 1

function Mouse.update(dt)
  Mouse.x, Mouse.y = Mouse:getPosition()
end
--