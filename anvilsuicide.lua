toDespawn={}

--

function eventMouse(name,xco,yco)
  ax = tfm.get.room.playerList[name].x
  by = tfm.get.room.playerList[name].y
  x = tfm.get.room.playerList[name].x - xco
  y = tfm.get.room.playerList[name].y - yco
  if ax < xco and by < yco then
    xs = x/10
    ys = y/10
  elseif ax > 0 and by < 0 then 
    xs = x/10
    ys = y/10
  elseif ax < 0 and by > 0 then   
    xs = x/10
    ys = y/10
  elseif ax > 0 and by > 0 then
    xs = x/10
    ys = y/10
  end
  id = tfm.exec.addShamanObject(6, xco, yco, 0, xs, ys, false)
  table.insert(toDespawn,{os.time(),id})
end

--

function eventLoop(time,remaining)
  for i,cannon in ipairs(toDespawn) do
    if cannon[1] <= os.time()-3000 then
    tfm.exec.removeObject(cannon[2])
    table.remove(toDespawn,i)
    end
  end
end

--

for name, player in pairs(tfm.get.room.playerList) do
  system.bindMouse(name,true)
  system.bindMouse(player,true)
  tfm.exec.bindKeyboard(name, 67, true, false)
  tfm.exec.bindKeyboard(player, 67, true, false)
end

--

function eventNewPlayer(name)
  tfm.exec.bindKeyboard(name, 67, true, false)
  system.bindMouse(name,true)
end