-- gestion scenes :
local Scene = {current=nil}

function Scene.set(pScene)
  Scene.current = pScene
end
--

return Scene