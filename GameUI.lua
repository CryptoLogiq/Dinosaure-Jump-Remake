local GameUI = {debug=false}

local listeTexte = {}
local pressJump, pressMenu, score

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
  score = GameUI.newText("Score : 0", 40, Screen.w - 150, 50)
end
--

function GameUI.update(dt)
  score.text:set("Score : "..tostring(Game.score))
  score.w, score.h = score.text:getDimensions()
  score.ox, score.oy = score.w/2, score.h/2
end
--

function GameUI.draw()
  if Game.start then
    if not DinoGame.firstJump then
      love.graphics.setColor(pressJump.color)
      love.graphics.draw(pressJump.text, pressJump.x, pressJump.y, 0, 1, 1, pressJump.ox, pressJump.oy)
      love.graphics.setColor(1,1,1,1)
    end

    -- score
    love.graphics.setColor(score.color)
    love.graphics.draw(score.text, score.x, score.y, 0, 1, 1, score.ox, score.oy)
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