local CycleJourNuit = {debug=false, alpha=1}

local timer = {current=100, min=5, max=100, speed=-5, speedDef=-5, wait=true}

local wait = {current=0, status="Jour", delai=60, delaiNuit=30, delaiJour=100, speed=5}

local filtre = {imgdata=love.graphics.newImage("Ressources/Desert/Nuit.png"), alpha=timer.current}

function CycleJourNuit.reset()
  timer.current = 100
  timer.speed = timer.speedDef
  timer.wait = false
  --
  filtre.alpha = 0
  --
  CycleJourNuit.alpha = timer.current / 100
end
--

function CycleJourNuit.update(dt)
  if Game.start then

    CycleJourNuit.alpha = timer.current / 100

    if timer.wait then

      wait.delai = wait["delai"..wait.status]

      wait.current = wait.current + wait.speed * dt

      if wait.current >= wait.delai then
        timer.wait = false
        wait.current = 0
      end

    else

      timer.current = timer.current + timer.speed * dt
      filtre.alpha = 1-(timer.current/100)

      if timer.current > timer.max then
        timer.current = timer.max
        timer.speed = 0 - timer.speed
        timer.wait = true
        wait.status = "Jour"
      elseif timer.current < timer.min then
        timer.current = timer.min
        timer.speed = 0 - timer.speed
        timer.wait = true
        wait.status = "Nuit"
      end

    end
  elseif Game.start == false then
    CycleJourNuit.reset()
  end
end
--

function CycleJourNuit.draw()
  love.graphics.setColor(1,1,1,filtre.alpha)

  love.graphics.draw(filtre.imgdata)

  love.graphics.setColor(1,1,1,1)

  if CycleJourNuit.debug then
    love.graphics.print(timer.current.."\n"..tostring(timer.wait), 10, 10)
  end
end
--

function CycleJourNuit.mousepressed(x,y,button)
end
--

function CycleJourNuit.keypressed(key)
end
--

return CycleJourNuit