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

---

function eventMouse(name,xco,yco) -- doesn't really matter since we just need a click, nothing more, you're the only one who has mouse clicks registered
  tfm.exec.addShamanObject(10, tfm.get.room.playerList.Lillyla.x, tfm.get.room.playerList.Lillyla.y+10, 0, 0, -200, false)
end -- ends the eventMouse function

system.bindMouse("Lillyla",true) -- only you have mouse bound
