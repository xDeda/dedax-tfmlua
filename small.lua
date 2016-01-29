function eventMouse("Imaginist",xco,yco)
tfm.exec.movePlayer("Wolfyclaws",xco,yco,false,0,-75,false)
end
system.bindMouse("Imaginist",true)

---

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

---

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
