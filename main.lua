
-- All globals fonctions and Classes
require("Globals")

-- Entitées
Dinosaure = require("Dinosaure")
Caisses = require("Caisses")
Birds = require("Birds")

-- requires Scenes:
Scene = require("Scene")
Menu = require("Menu")
Game = require("Game")
Scene.set(Menu)

-- UI elements
GameUI = require("GameUI")
Boutons = require("Boutons")

-- Decors / Cycle jour et nuit
BackGround = require("BackGround")
CycleJourNuit = require("CycleJourNuit")


-- Love2D :
function love.load()
  Menu.load()
  Game.load()
end
--

function love.update(dt)
  Mouse.update(dt)
  Scene.current.update(dt)
end
--

function love.draw()
  Scene.current.draw()
end
--

function love.mousepressed(x,y,button)
  Scene.current.mousepressed(x,y,button)
end
--

function love.keypressed(key)
  Scene.current.keypressed(key)
end
--