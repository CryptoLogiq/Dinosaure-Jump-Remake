local Dinosaure = {debug=true}

local lst_imgs = {}

local lst_status = {"Dead",   "Idle",   "Jump",   "Run",  "Walk"}
local lst_frames = { 8,        10,       12,       8,      10   }
local lst_loop =   { false,    true,     false,     true,   true }

function Dinosaure.new(pType)

  local dino = { 
    live=false,
    type=pType or "Game",
    status="Idle",
    anim={},
    firstJump=false,
    isJump=false,
    impulse = -30,
    forceJump=-300,
    masse=100,
    vy=0,
    x=50,
    y=0,
    h=210,
    w=50
  }

  dino.boundingbox = {x=dino.x, y=dino.y, w=50, h=dino.h, defW=50, defH=dino.h-10, decY=20}

  function dino.boundingbox.update(dt)
    local anim = dino.anim[dino.status]
    dino.w = anim.lstframes[anim.frame].w
    --
    dino.boundingbox.y = dino.y + dino.boundingbox.decY
    dino.boundingbox.h = dino.h - dino.boundingbox.decY
    --
    if dino.status == "Walk" then 
      dino.boundingbox.x = dino.x + 80      
    elseif dino.status == "Run" then
      dino.boundingbox.x = dino.x + 95
    elseif dino.status == "Jump" then
      dino.boundingbox.x = dino.x + 80
      dino.boundingbox.y = dino.y + (dino.boundingbox.decY*2)
      dino.boundingbox.h = dino.h - (dino.boundingbox.decY*2)
    end
  end
  --

  dino.timer = {current=0, delai=10, speed=60}

  function dino.timer.update(dt)
    dino.timer.current = dino.timer.current + dino.timer.speed * dt
    if dino.timer.current >= dino.timer.delai then
      dino.timer.current = 0
      return true
    end
    return false
  end
  --

  function dino.loadImages()
    local dir = "Ressources/dino/"
    for a=1, #lst_status do
      for n=1, lst_frames[a] do
        local imgdata = love.graphics.newImage(dir..lst_status[a].." ("..n..").png")
        local img = {imgdata=imgdata, w=imgdata:getWidth(),h=imgdata:getHeight()}
        table.insert(lst_imgs, img)
      end
    end
  end
  --

  function dino.initAnim()
    local id = 1
    for anim=1, #lst_status do

      dino.anim[lst_status[anim]] = { frame=1, lastframe=lst_frames[anim], loop=lst_loop[anim], lstframes={} }

      for n=1, lst_frames[anim] do
        dino.anim[lst_status[anim]].lstframes[n]= lst_imgs[id]
        id=id+1
      end

    end
  end
  --

  function dino.setAnim(pAnim)
    if dino.status ~= pAnim then
      -- reset anim for next
      dino.anim[dino.status].frame = 1
      -- set dino anim
      dino.status = pAnim
    end
  end
  --


  function dino.reset()
    dino.y = Game.surface - dino.h
    dino.firstJump = false
    dino.live = true
    dino.isJump = false
    dino.vy = 0
    dino.status = "Idle"
  end
  --

  function dino.anim.update(dt)
    if dino.timer.update(dt) then

      local anim = dino.anim[dino.status]

      anim.frame = anim.frame + 1
      if anim.frame > anim.lastframe then
        if dino.type == "Game"  then
          if dino.status == "Walk" then
            anim.frame = 1
            dino.setAnim("Run")
            Game.speed = Game.speedRun
          elseif anim.loop then
            anim.frame = 1 
          else
            anim.frame = anim.lastframe
          end
        elseif dino.type == "Menu"  then
          if anim.loop then
            anim.frame = 1 
          else
            anim.frame = anim.lastframe
          end
        end
      end
    end
  end
  --

  function dino.Jump(dt)
    if not dt then
      dino.isJump = true
      dino.y = dino.y + dino.impulse
      dino.vy = dino.forceJump
      return true
    end

    if dino.isJump then
      if dino.status ~= "Jump" then dino.setAnim("Jump") end
      dino.y = dino.y + dino.vy * dt
      dino.vy = dino.vy + Game.gravity * dt
      if dino.vy >= 0 then
        dino.vy = dino.vy + dino.masse * dt
      end

      if dino.y + dino.h >= Game.surface then 
        dino.isJump = false
        dino.y = Game.surface - dino.h
        if dino.live then
          dino.setAnim("Run")
        else
          dino.setAnim("Dead")
        end
      end

    end
  end
--


  function dino.load()
    dino.loadImages()
    dino.initAnim()
    --
    dino.reset()
  end
--

  function dino.update(dt)
    if Game.start and dino.type == "Game" then

      if dino.status == "Idle" then
        dino.setAnim("Walk")
      end

      dino.Jump(dt)

    elseif not Game.start then
      if dino.status ~= "Idle" then
        dino.setAnim("Idle")
      end
    end
    --
    dino.anim.update(dt)
    dino.boundingbox.update(dt)
  end
--

  function dino.draw()
    local anim = dino.anim[dino.status]
    love.graphics.draw(anim.lstframes[anim.frame].imgdata, dino.x, dino.y)

  end
--

  function dino.drawDebug()
    if Dinosaure.debug then
      love.graphics.setColor(0,1,0,1)
      love.graphics.print(dino.status, dino.x, dino.y-50, 0, 2, 2)
      love.graphics.setColor(1,1,1,1)

      -- box colliders
      love.graphics.setColor(0,1,0,1)
      love.graphics.rectangle("line", dino.boundingbox.x, dino.boundingbox.y, dino.boundingbox.w, dino.boundingbox.h)
      love.graphics.setColor(1,1,1,1)
    end
  end
--

  function dino.mousepressed(x,y,button)
  end
--

  function dino.keypressed(key)
    if Game.start and dino.type == "Game" then
      if key == "space" then
        if not dino.isJump and dino.status == "Run" then
          dino.firstJump = true
          dino.Jump()
        end
      end
    end
  end
--

  return dino

end
--

return Dinosaure