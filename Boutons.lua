local Boutons = {debug=false, decY=10}

local Lst_Boutons = {}

local playContinue

function Boutons.reset()
  playContinue:setText("Play New Game")
end
--

function Boutons.newBouton(pText, pFonc)
  local update = function(self, dt)
    if CheckCollision(self.x, self.y, self.w, self.h, Mouse.x, Mouse.y, Mouse.w, Mouse.h) then
      self.color = self.colorOnSurvol
    else
      self.color = self.colorDef
    end
  end
  --

  local draw = function(self)
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    --
    love.graphics.setColor(0,0,0,1)
    love.graphics.draw(self.text.data, self.text.x, self.text.y, 0, 1, 1, self.text.ox, self.text.oy)
    --
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    --
    love.graphics.setColor(1,1,1,1)
  end
  --

  local setText = function(self, pText)
    self.text.string = pText
    self.text.data:set(pText)
    self.text.w, self.text.h = self.text.data:getDimensions()
    self.text.ox, self.text.oy = self.text.w/2, self.text.h/2
  end
  --

  local button = {
    x=Screen.cx - 100,
    y=0, w=200, h=50,
    text={data=love.graphics.newText(Font.Caveat[28], ""), string=pText},
    execute=pFonc,
    color={1,1,1,1},
    colorDef={1,1,0,0.8},
    colorOnSurvol={0,1,0,0.8},
    draw=draw,
    update=update,
    setText=setText
  }
  button.text.x = Screen.cx
  button.text.y = 0
  --
  button:setText(pText)
  --
  table.insert(Lst_Boutons, button)
  --
  local boutonsHeight = #Lst_Boutons * button.h
  local boutonsDecYtotal = (#Lst_Boutons - 1 ) * Boutons.decY
  --
  local totalH = boutonsHeight + boutonsDecYtotal
  --
  local spaceY = totalH / #Lst_Boutons
  --
  local y = Screen.cy - (totalH/2)
  --
  for n=1, #Lst_Boutons do
    local bt = Lst_Boutons[n]
    bt.y = y
    bt.text.y = y + (bt.h/2)
    --
    y = y + spaceY
  end

  return button

end
--

function Boutons.load()
  playContinue = Boutons.newBouton( "Play", function(self) Scene.set(Game); Game.launch(); self:setText("Continue") end )
  Boutons.newBouton( "Quit", function(self) love.event.quit() end )
end
--

function Boutons.update(dt)
  for n=1, #Lst_Boutons do
    local bt = Lst_Boutons[n]
    bt:update(dt)
  end
end
--

function Boutons.draw()
  for n=1, #Lst_Boutons do
    local bt = Lst_Boutons[n]
    bt:draw()
  end
end
--

function Boutons.mousepressed(x,y,button)
  if Scene.current == Menu then
    if button == 1 then
      for n=1, #Lst_Boutons do
        local bt = Lst_Boutons[n]
        if CheckCollision(bt.x, bt.y, bt.w, bt.h, x, y, Mouse.w, Mouse.h) then
          bt:execute()
        end
      end

    end

  end
end
--

function Boutons.keypressed(key)
end
--

return Boutons