local Game = {debug=false, start=false, capture=nil, pause=false, speedWalk=45, speedRun=120, speed=35, surface=480, gravity=250, score=0}

DinoGame = Dinosaure.new()

function Game.reset()
  Game.speed = Game.speedWalk
  Game.start = false
  Game.pause = false
  --
  Game.score = 0
  --
  CycleJourNuit.reset()
  BackGround.reset()
  DinoGame.reset()
  Caisses.reset()
end
--

function Game.launch()
  Game.start = true
  Game.pause = false
end
--

function Game.load()
  GameUI.load()
  BackGround.load()
  CycleJourNuit.reset()
  --
  Caisses.load()
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
    Caisses.update(dt)
  end
end
--

function Game.draw()
  -- background
  BackGround.draw()

  -- entites
  DinoGame.draw()
  Caisses.draw()

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
  if key == "escape" then
    Scene.set(Menu)
  end
end
--

return Game