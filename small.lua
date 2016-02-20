-- let's TP Wolfyclaws

function eventMouse(name,xco,yco)
tfm.exec.movePlayer("Wolfyclaws",xco,yco,false,0,-75,false)
end
system.bindMouse("Imaginist",true)

--- double click to TP

mouse = {}

for name, player in pairs(tfm.get.room.playerList) do
  mouse[name] = {count = 0, tp = 0}
  mouse[player] = {count = 0, tp = 0}
  system.bindMouse(name,true)
  system.bindMouse(player,true)
end

function eventMouse(name,x,y)
  mouse[name]["tp"] = mouse[name]["tp"] + 1
  if mouse[name]["tp"] == 2 then
    tpme(name,x,y)
  end
end

function tpme(name,x,y)
  tfm.exec.movePlayer(name,x,y,false,0,0,true)
  mouse[name]["tp"] = 0
end

function eventLoop(timeRemaining,timeRemaining)
  for name, player in pairs(tfm.get.room.playerList) do
    mouse[name]["count"] = mouse[name]["count"] + 1
    if mouse[name]["count"] == 1 then
      mouse[name]["count"] = 0
      mouse[name]["tp"] = 0
    end
  end
end

--- fly

for name, player in pairs(tfm.get.room.playerList) do
  for keys, k in pairs({32}) do -- space
    tfm.exec.bindKeyboard(name, k, true, true)
  end
end
function eventKeyboard(name, key, down, x, y)
  if key == 32 then -- space
    tfm.exec.movePlayer(name,x,y,false,0,-50,false)
  end
end

--- rest in peace, bowie

for keys, k in pairs(tfm.get.room.playerList) do
  tfm.exec.movePlayer(keys,800,-30,false,0,0,false)
end

function eventChatCommand(playerName,message)
  if message == "rip" then
    print("REST IN PEACE")
    for keys, k in pairs(tfm.get.room.playerList) do
      tfm.exec.movePlayer(keys,0,0,false,0,-500,false)
    end
  end
end

-- prank someone

killthis = tfm.get.room.playerList.Boxedmeow

function eventMouse(name,xco,yco)
  tfm.exec.addShamanObject(10, killthis.x, killthis.y+10, 0, 0, -2000, false)
end

system.bindMouse("Boxedmeow",true)
