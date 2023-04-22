local Game = {debug=false, start=false, pause=false, speedWalk=35, speedRun=100, speed=35, surface=480, gravity=250}

DinoGame = Dinosaure.new()

function Game.reset()
  Game.speed = Game.speedWalk
  Game.start = false
  Game.pause = false
  --
  CycleJourNuit.reset()
  BackGround.reset()
  DinoGame.reset()
end
--

function Game.launch()
  Game.start = true
  Game.pause = false
  DinoGame.live = true
end
--

function Game.load()
  GameUI.load()
  BackGround.load()
  CycleJourNuit.reset()
  --
  DinoGame.load()
end
--

function Game.update(dt)
  if not Game.pause then
    GameUI.update(dt)
    BackGround.update(dt)
    CycleJourNuit.update(dt)
    --
    DinoGame.update(dt)
  end
end
--

function Game.draw()
  -- background
  BackGround.draw()

  -- entites
  DinoGame.draw()

  -- jour nuit
  CycleJourNuit.draw()

  -- not influenced by Jour/Nuit :
  DinoGame.drawDebug()
  GameUI.draw()
end
--

function Game.mousepressed(x,y,button)
end
--

function Game.keypressed(key)
  DinoGame.keypressed(key)
  --
  if key == "escape" and DinoGame.live then
    Scene.set(Menu)
    Game.pause = true
  elseif key == "escape" and not DinoGame.live then
    Menu.reset()
  end
end
--

return Game