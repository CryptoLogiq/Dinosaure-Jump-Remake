local Caisses = {debug=true}

local lst_imgs = {}
local dir = "Ressources/Box/"

local Lst_Box = {}

local timer = {current=0, delai=40, speed=10}

function Caisses.reset()
  Lst_Box = {}
  timer.reset()
end
--

function Caisses.new()
  local x = Screen.w + 10
  local y = Game.surface

  local rand = love.math.random(#lst_imgs)
  local typebox = lst_imgs[rand]

  local nbBox = love.math.random(1,2)

  for n=1, nbBox do
    local caisse = {imgdata=typebox.imgdata, w=typebox.w, h=typebox.h, x=x, y=y-typebox.h, point=10, isjumped=false}
    table.insert(Lst_Box, caisse)
    y = y-typebox.h
  end
end
--

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

function Caisses.collide()
  for n=1, #Lst_Box do
    local caisse = Lst_Box[n]
    if AABB(DinoGame.boundingbox, caisse)then
      return true
    end
  end
end
--

function Caisses.load()
  for n=1, 5 do
    local imgdata = love.graphics.newImage(dir.."box_"..n..".png")
    local img = {imgdata=imgdata, w=imgdata:getWidth(),h=imgdata:getHeight()}
    table.insert(lst_imgs, img)
  end
end
--

function Caisses.update(dt)
  if Game.start and DinoGame.live then

    if timer.update(dt) then
      Caisses.new()
    end

    for n=#Lst_Box, 1, -1 do
      local caisse = Lst_Box[n]
      caisse.x = caisse.x - Game.speed * dt
      if not caisse.isjumped then
        if caisse.x + caisse.w <= DinoGame.boundingbox.x then
          caisse.isjumped = true
          Game.score = Game.score + caisse.point
        end
      end
      if caisse.x + caisse.w <= 0 then
        table.remove(Lst_Box, n)
      end
    end

    if Caisses.collide() then
      DinoGame.live = false
      DinoGame.setAnim("Dead")
    end

  end
end
--

function Caisses.draw()
  for n=1, #Lst_Box do
    local caisse = Lst_Box[n]
    love.graphics.draw(caisse.imgdata, caisse.x, caisse.y)
    if Caisses.debug then
      love.graphics.setColor(1,0,1,1)
      love.graphics.rectangle("line",caisse.x, caisse.y, caisse.w, caisse.h)
      love.graphics.setColor(1,1,1,1)
    end
  end
end
--

function Caisses.mousepressed(x,y,button)
end
--

function Caisses.keypressed(key)
end
--

return Caisses