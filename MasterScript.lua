master = "Dedax"
masterpass = "å"
pass = "ø"

ui.addTextArea(666, "<ROSE>master:</ROSE> " .. master, nil, 660, -17, 0, 0, 0x000000, 0x222222, 0.3, true)

command = {}
mouse = {}
target = {}
spawntype = {}
spawns = {}
balls = {}
tp = {}
time = {}
telelist = ""
itemlimit = 3;
powerasker = ""
helpstring = "<b>Keys:</b><br>H - Get this window again<br>J, K and L - shoot balls left, down and right respectively<br>C - clear all objects<br>X - clear mouseclick"

for name, player in pairs(tfm.get.room.playerList) do
  tfm.exec.bindKeyboard(name, 80, true, true) -- P
  tfm.exec.bindKeyboard(name, 188, true, true) -- ,
  tfm.exec.bindKeyboard(name, 189, true, true) -- -
end

function help(name)
  if name == master then
    ui.addPopup(1, 0, "<b>WOW! YOU'RE THE MASTER!<br>SPECIAL MASTER ABILITIES:</b><br>G - give power to someone<br>F - remove powers from someone<br>B - set item limit<br><br>"..helpstring, master, 200, 100, 400, true)
  else
    ui.addPopup(1, 0, "<b>YOU NOW HAVE POWERS!</b><br><br>"..helpstring, name, 200, 100, 400, true)
  end
end

function givePowers(name)
  if name == master then
    tfm.exec.bindKeyboard(master, 66, true, true) -- B
    tfm.exec.bindKeyboard(master, 70, true, true) -- F
    tfm.exec.bindKeyboard(master, 71, true, true) -- G
    ui.updateTextArea(666, "<a href='event:master'><ROSE>master:</ROSE> " .. master .. "</a>", master)
    tfm.exec.setNameColor(master,0xFF4444)
  end
  tfm.exec.bindKeyboard(name, 67, true, true) -- C
  tfm.exec.bindKeyboard(name, 72, true, true) -- H
  tfm.exec.bindKeyboard(name, 74, true, true) -- K
  tfm.exec.bindKeyboard(name, 75, true, true) -- J
  tfm.exec.bindKeyboard(name, 76, true, true) -- L
  tfm.exec.bindKeyboard(name, 88, true, true) -- X
  system.bindMouse(name, true)
  print(name .. " has powers!")
  help(name)
  command[name] = ""
  tp[name] = 1
  time[name] = os.time()
  mouse[name] = "clear"
  target[name] = name
  spawntype[name] = "601"
  spawns[name] = {}
  ui.addTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> clear</a>", name, 10, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
  ui.addTextArea(2, "<a href='event:tplist'><VP>teleporting</VP> yourself</a>", name, 130, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
  ui.addTextArea(4, "<a href='event:spawnselect'><VP>spawn:</VP> ball</a>", name, 280, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
end

givePowers(master)

function removePowers(name)
  if name == master then
    tfm.exec.bindKeyboard(master, 66, true, false) -- B
    tfm.exec.bindKeyboard(master, 70, true, false) -- F
    tfm.exec.bindKeyboard(master, 71, true, false) -- G
  end
  tfm.exec.bindKeyboard(name, 67, true, false) -- C
  tfm.exec.bindKeyboard(name, 72, true, false) -- H
  tfm.exec.bindKeyboard(name, 74, true, false) -- K
  tfm.exec.bindKeyboard(name, 75, true, false) -- J
  tfm.exec.bindKeyboard(name, 76, true, false) -- L
  tfm.exec.bindKeyboard(name, 88, true, false) -- X
  system.bindMouse(name, false)
  print(name .. " got powers removed!")
  ui.addPopup(1, 0, "<b>" .. master .. "</b> removed your powers :(", name, 400, 100, 200, true)
  ui.removeTextArea(1, name)
  ui.removeTextArea(2, name)
  ui.removeTextArea(3, name)
  ui.removeTextArea(4, name)
  ui.removeTextArea(5, name)
  ui.updateTextArea(666, "<ROSE>master:</ROSE> " .. master, name)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
playerCount = tablelength(tfm.get.room.playerList)
print(playerCount)

function shootBall(name, direction, x, y)
  if tablelength(spawns[name]) >= itemlimit then
    tfm.exec.removeObject(spawns[name][itemlimit])
  end

  if direction == "left" then
    table.insert(spawns[name], 1, tfm.exec.addShamanObject(6, x - 20, y, 0, -25, 0, false))
  end
  if direction == "right" then
    table.insert(spawns[name], 1, tfm.exec.addShamanObject(6, x + 20, y, 0, 25, 0, false))
  end
  if direction == "down" then
    table.insert(spawns[name], 1, tfm.exec.addShamanObject(6, x, y + 10, 0, 0, 25, false))
  end
end

function spawnItem(id, name, x, y)
  if tablelength(spawns[name]) >= itemlimit then
    tfm.exec.removeObject(spawns[name][itemlimit])
  end
  table.insert(spawns[name], 1, tfm.exec.addShamanObject(id, x, y, 0, 0, 0, false))
end

function eventKeyboard(name, key, down, x, y)
  if key == 66 then -- B
    ui.addPopup(6, 2, "Set item limit:", name, 400, 100, 200, true)
  end
  if key == 70 then -- F
    ui.addPopup(4, 2, "Remove powers:", name, 400, 100, 200, true)
  end
  if key == 71 then -- G
    ui.addPopup(3, 2, "Give powers to:", name, 400, 100, 200, true)
  end
  if key == 72 then -- H
    help(name)
  end
  if key == 74 then -- J
    shootBall(name, "left", x, y)
  end
  if key == 75 then -- K
    shootBall(name, "down", x, y)
  end
  if key == 76 then -- L
    shootBall(name, "right", x, y)
  end
  if key == 80 then -- P
    ui.addPopup(1, 2, "What's the password?", name, 400, 100, 200, true)
  end
  if key == 88 then -- X
    mouse[name] = "clear"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> clear</a>", name)
  end
  if key == 67 then -- C
    remove = {}
    for i, o in pairs(tfm.get.room.objectList) do
      table.insert(remove, i)
    end
    for _, n in pairs(remove) do
      tfm.exec.removeObject(n)
    end
  end
  if key == 189 then -- -
    ui.addPopup(4, 0, "You asked " .. master .. " for powers!", name, 400, 100, 200, true)
    ui.addPopup(5, 1, "Give " .. name .. " powers?", master, 400, 100, 200, true)
    powerasker = name
  end
  if key == 188 then -- ,
    ui.addPopup(7, 2, "What's the master password?", name, 400, 100, 200, true)
  end
end

function itemname(id)
  if id == "arrow" then return (0)
  elseif id == "small box" then return (1)
  elseif id == "large box" then return (2)
  elseif id == "small plank" then return (3)
  elseif id == "large plank" then return (4)
  elseif id == "ball" then return (6)
  elseif id == "trampoline" then return (7)
  elseif id == "anvil" then return (10)
  elseif id == "cannon" then return (17)
  elseif id == "bomb" then return (23)
  elseif id == "spirit" then return (24)
  elseif id == "balloon" then return (28)
  elseif id == "rune" then return (32)
  elseif id == "chicken" then return (33)
  elseif id == "snowball" then return (34)
  elseif id == "v arrow" then return (35)
  elseif id == "apple" then return (39)
  elseif id == "sheep" then return (40)
  elseif id == "ice plank" then return (45)
  elseif id == "choco plank" then return (46)
  elseif id == "frozen mouse" then return (54)
  elseif id == "cloud" then return (57)
  elseif id == "bubble" then return (59)
  elseif id == "tiny plank" then return (60)
  elseif id == "companion cube" then return (61)
  elseif id == "stable rune" then return (62)
  elseif id == "pufferfish" then return (65)
  elseif id == "giant plank" then return (67)
  elseif id == "triangle box" then return (68)
  elseif id == "s plank" then return (69)
  elseif id == "pumpkin" then return (89)
  elseif id == "tombstone" then return (90)
  elseif id == "pokeball" then return (601)
  else return (6)
  end
end

function nameitem(id)
  if id == "0" then return ("arrow")
  elseif id == "1" then return ("small box")
  elseif id == "2" then return ("large box")
  elseif id == "3" then return ("small plank")
  elseif id == "4" then return ("large plank")
  elseif id == "6" then return ("ball")
  elseif id == "7" then return ("trampoline")
  elseif id == "10" then return ("anvil")
  elseif id == "17" then return ("cannon")
  elseif id == "23" then return ("bomb")
  elseif id == "24" then return ("spirit")
  elseif id == "28" then return ("balloon")
  elseif id == "32" then return ("rune")
  elseif id == "33" then return ("chicken")
  elseif id == "34" then return ("snowball")
  elseif id == "35" then return ("v arrow")
  elseif id == "39" then return ("apple")
  elseif id == "40" then return ("sheep")
  elseif id == "45" then return ("ice plank")
  elseif id == "46" then return ("choco plank")
  elseif id == "54" then return ("frozen mouse")
  elseif id == "57" then return ("cloud")
  elseif id == "59" then return ("bubble")
  elseif id == "60" then return ("tiny plank")
  elseif id == "61" then return ("companion cube")
  elseif id == "62" then return ("stable rune")
  elseif id == "65" then return ("pufferfish")
  elseif id == "67" then return ("giant plank")
  elseif id == "68" then return ("triangle box")
  elseif id == "69" then return ("s plank")
  elseif id == "89" then return ("pumpkin")
  elseif id == "90" then return ("tombstone")
  elseif id == "601" then return ("pokeball")
  else return ("ball")
  end
end

function eventTextAreaCallback(textAreaID, playerName, callback)

  if textAreaID == 1 then
    if mouse[playerName] == "spawn" then
      mouse[playerName] = "sp"
      ui.updateTextArea(textAreaID, "<a href='event:clicktype'><VP>click type:</VP> sp</a>", playerName)
    elseif mouse[playerName] == "sp" then
      mouse[playerName] = "clear"
      ui.updateTextArea(textAreaID, "<a href='event:clicktype'><VP>click type:</VP> clear</a>", playerName)
    elseif mouse[playerName] == "clear" then
      mouse[playerName] = "tp"
      ui.updateTextArea(textAreaID, "<a href='event:clicktype'><VP>click type:</VP> tp</a>", playerName)
    elseif mouse[playerName] == "tp" then
      mouse[playerName] = "spawn"
      ui.updateTextArea(textAreaID, "<a href='event:clicktype'><VP>click type:</VP> spawn</a>", playerName)
    end
  end

  if textAreaID == 2 then
    ui.removeTextArea(2, playerName)

    local areasize = 35 + playerCount * 17

    telelist = ""
    for name, player in pairs(tfm.get.room.playerList) do
      telelist = telelist .. "<a href='event:" .. player.playerName .. "'>" .. player.playerName .. "</a><br>"
    end

    ui.addTextArea(3, "Teleport:<br><br><br>" .. telelist, playerName, 130, -17, 110, areasize, 0x000000, 0x222222, 0.6, true)
  end

  if textAreaID == 3 then
    ui.removeTextArea(3, playerName)
    mouse[playerName] = "tp"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> tp</a>", playerName)
    target[playerName] = callback
    ui.addTextArea(2, "<a href='event:tplist'><VP>teleporting</VP> " .. callback .. "</a>", playerName, 130, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
  end

  if textAreaID == 4 then
  	ui.removeTextArea(4, playerName)
    ui.addTextArea(5, "spawn item:<br><br><br><a href='event:601'>ball</a><br><a href='event:10'>anvil</a><br><a href='event:59'>bubble</a><br><a href='event:68'>triangle</a><br><br><a href='event:ask'>enter id/name</a>", playerName, 280, -17, 110, 125, 0x000000, 0x222222, 0.6, true)
  end
  if textAreaID == 5 then
    if callback == "ask" then
    	ui.addPopup(9, 2, "Set spawn id/name: ", playerName, 400, 100, 200, true)
      ui.removeTextArea(5, playerName)
      ui.addTextArea(4, "<VP>spawn:</VP>", playerName, 280, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
    else
      ui.removeTextArea(5, playerName)
      spawntype[playerName] = callback
      ui.addTextArea(4, "<a href='event:spawnselect'><VP>spawn:</VP> " .. nameitem(callback) .. "</a>", playerName, 280, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
      mouse[playerName] = "spawn"
      ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> spawn</a>", playerName)
    end
  end

  if textAreaID == 666 then
    ui.addPopup(8, 2, "Give master to:", master, 400, 100, 200, true)
  end

end

function eventMouse(name, x, y)
  if mouse[name] == "tp" then
    if time[name] < os.time()-5000 then
      tp[name] = 1
    end
    if tp[name] == 1 then
      tfm.exec.movePlayer(target[name], x, y, false, 0, 1, false)
      time[name] = os.time()
      tp[name] = 0
    end
  elseif mouse[name] == "sp" then
    tfm.exec.explosion(x, y, 20, 100, false)
  elseif mouse[name] == "spawn" then
    spawnItem(spawntype[name], name, x, y)
  end
end

function eventPopupAnswer(popupID, playerName, answer)
  if popupID == 1 and answer == pass then
    givePowers(playerName)
  elseif popupID == 1 then
    print(playerName .. " tried to guess the pass: " .. answer)
  end
  if popupID == 2 then
    parseCommand(playerName, answer)
    print(playerName .. " has issued command: " .. answer)
    command[playerName] = answer
  end
  if popupID == 3 then
    givePowers(answer:gsub("^%l", string.upper))
  end
  if popupID == 4 then
    removePowers(answer:gsub("^%l", string.upper))
  end
  if popupID == 5 and answer == "yes" then
    givePowers(powerasker)
    ui.addPopup(1, 0, "Wow, you were given powers!!!", powerasker, 400, 100, 200, true)
  elseif popupID == 5 and answer == "no" then
    ui.addPopup(1, 0, "Sorry :))) noob", powerasker, 400, 100, 200, true)
  end
  if popupID == 6 then
    itemlimit = tonumber(answer)
  end
  if popupID == 7 and answer == masterpass then
    ui.addPopup(1, 0, "Oh wow, " .. playerName .. " usurped you as master!", master, 400, 100, 200, true)
    tfm.exec.bindKeyboard(master, 66, true, false) -- B
    tfm.exec.bindKeyboard(master, 70, true, false) -- F
    tfm.exec.bindKeyboard(master, 71, true, false) -- G
    tfm.exec.setNameColor(master,0xFFFFFF)
    master = playerName
    ui.updateTextArea(666, "<ROSE>master:</ROSE> " .. master, nil)
    givePowers(master)
  elseif popupID == 7 then
    print(playerName .. " tried to guess the masterpass: " .. answer)
  end
  if popupID == 8 then
    ui.addPopup(1, 0, "You honourably passed on the master status to " .. answer:gsub("^%l", string.upper) .. " :)", master, 400, 100, 200, true)
    ui.addPopup(1, 0, "<b>WOW! "..master.." gave you master powers!<br>SPECIAL MASTER ABILITIES:</b><br>G - Give power to someone<br>F - Remove powers from someone<br>B - Set item limit<br><br>"..helpstring, answer:gsub("^%l", string.upper), 200, 100, 400, true)
    tfm.exec.setNameColor(master,0xFFFFFF)
    tfm.exec.bindKeyboard(master, 66, true, false) -- B
    tfm.exec.bindKeyboard(master, 70, true, false) -- F
    tfm.exec.bindKeyboard(master, 71, true, false) -- G
    master = answer:gsub("^%l", string.upper)
    ui.updateTextArea(666, "<ROSE>master:</ROSE> " .. master, nil)
    tfm.exec.bindKeyboard(master, 66, true, true)
    tfm.exec.bindKeyboard(master, 70, true, true)
    tfm.exec.bindKeyboard(master, 71, true, true)
    tfm.exec.setNameColor(master,0xFF4444)
  end
  if popupID == 9 and tonumber(answer) == nil then
    answer1 = string.lower(answer)
    answer = itemname(answer1)
    spawntype[playerName] = answer
    ui.updateTextArea(4, "<a href='event:spawnselect'><VP>spawn:</VP> " .. answer1:gsub("^%l", string.upper) .. "</a>", playerName)
    mouse[playerName] = "spawn"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> spawn</a>", playerName)
  elseif popupID == 9 then
    answer1 = nameitem(tostring(answer))
    spawntype[playerName] = itemname(answer1)
    ui.updateTextArea(4, "<a href='event:spawnselect'><VP>spawn:</VP> " .. answer1:gsub("^%l", string.upper) .. "</a>", playerName)
    mouse[playerName] = "spawn"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> spawn</a>", playerName)
  end
end