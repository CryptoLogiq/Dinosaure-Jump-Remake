local GameUI = {debug=false}

local listeTexte = {}
local pressJump, pressMenu

function GameUI.newText(pText, pSize, x, y)
  local texte = {text=love.graphics.newText(Font.Caveat[pSize], pText), x=x, y=y, color={1,0,1,1}}
  texte.w, texte.h = texte.text:getDimensions()
  texte.ox, texte.oy = texte.w/2, texte.h/2
  table.insert(listeTexte, texte)
  return texte
end
--

function GameUI.load()
  pressJump = GameUI.newText("You can Press Space for Jump, Good Luck !", 40, Screen.cx, Screen.cy)
  pressMenu = GameUI.newText("Press Escape to back Menu/Pause", 20, 20, 20)
end
--

function GameUI.update(dt)
end
--

function GameUI.draw()
  if DinoGame.firstJump == false and Game.start then
    love.graphics.setColor(pressJump.color)
    love.graphics.draw(pressJump.text, pressJump.x, pressJump.y, 0, 1, 1, pressJump.ox, pressJump.oy)
    love.graphics.setColor(1,1,1,1)
  end
  --
  love.graphics.setColor(pressJump.color)
  love.graphics.draw(pressMenu.text, pressMenu.x, pressMenu.y)
  love.graphics.setColor(1,1,1,1)
end
--

function GameUI.mousepressed(x,y,button)
end
--

function GameUI.keypressed(key)
end
--

return GameUI