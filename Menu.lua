local Menu = {}

DinoMenu = Dinosaure.new("Menu")

function Menu.reset()
  Game.reset()
  Scene.set(Menu)
end
--

function Menu.load()
  Boutons.load()
  DinoMenu.load()
end
--

function Menu.update(dt)
  Boutons.update(dt)
  DinoMenu.update(dt)
end
--

function Menu.draw()
  BackGround.draw()
  DinoMenu.draw()
  --
  Boutons.draw()
  if Game.start then
--    DinoGame.draw()
  end
end
--

function Menu.mousepressed(x,y,button)
  Boutons.mousepressed(x,y,button)
end
--

function Menu.keypressed(key)
  Boutons.keypressed(key)
end
--

return Menu