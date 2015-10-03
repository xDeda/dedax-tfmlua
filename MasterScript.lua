master = "Dedax"
masterpass = "å"
pass = "ø"

ui.addTextArea(666, "<ROSE>master:</ROSE> " .. master, nil, 660, -17, 0, 0, 0x000000, 0x222222, 0.3, true)

itemlist = {[0] = "arrow", [1] = "small box", [2] = "large box", [3] = "small plank", [4] = "large plank", [6] = "ball", [7] = "trampoline", [10] = "anvil", [17] = "cannon", [23] = "bomb", [24] = "spirit", [28] = "balloon", [32] = "rune", [33] = "chicken", [34] = "snowball", [35] = "v arrow", [39] = "apple", [40] = "sheep", [45] = "ice plank", [46] = "choco plank", [54] = "frozen mouse", [57] = "cloud", [59] = "bubble", [60] = "tiny plank", [61] = "companion cube", [62] = "stable rune", [65] = "pufferfish", [67] = "giant plank", [68] = "triangle box", [69] = "s plank", [89] = "pumpkin", [90] = "tombstone", [601] = "pokeball"}

player = {} -- player[name] = {mouse = "clear", target = name, spawntype = "601", spawns = {}, tp = "1", time = os.time()}
telelist = ""
itemlimit = 3;
powerasker = ""
helpstring = "<b>Keys:</b><br><b> H</b> - Get this window again<br><b> J, K and L</b> - shoot balls left, down and right respectively<br><b> C</b> - clear all objects<br><b> Spacebar</b> - Cycle through click types<br><b> X</b> - clear mouseclick"

for name, player in pairs(tfm.get.room.playerList) do
  for keys, k in pairs({80, 188, 189}) do -- P, , (comma), - (hyphen)
    tfm.exec.bindKeyboard(name, k, true, true)
  end
end

function startBind(name)
  for keys, k in pairs({80, 188, 189}) do -- P, , (comma), - (hyphen)
    tfm.exec.bindKeyboard(name, k, true, true)
  end
end

function unbindMaster()
  for keys, k in pairs({66, 70, 71}) do -- B, F, G
    tfm.exec.bindKeyboard(master, k, true, false)
  end
end

function help(name)
  if name == master then
    ui.addPopup(1, 0, "<b>WOW! YOU'RE THE <R>MASTER!</R><br>SPECIAL MASTER ABILITIES:</b><br><b> G</b> - give power to someone<br><b> F</b> - remove powers from someone<br><b> B</b> - set item limit<br><br>" .. helpstring, master, 200, 100, 400, true)
  else
    ui.addPopup(1, 0, "<b>YOU NOW HAVE POWERS!</b><br><br>" .. helpstring, name, 200, 100, 400, true)
  end
end

function givePowers(name)
  if name == master then
    for keys, k in pairs({66, 70, 71}) do -- B, F, G
      tfm.exec.bindKeyboard(name, k, true, true)
    end
    ui.updateTextArea(666, "<a href='event:master'><ROSE>master:</ROSE> " .. master .. "</a>", master)
  end
  for keys, k in pairs({32, 67, 72, 74, 75, 76, 88}) do -- Space, C, H, K, J, L, X
    tfm.exec.bindKeyboard(name, k, true, true)
  end
  system.bindMouse(name, true)
  print(name .. " has powers!")
  help(name)
  player[name] = {mouse = "clear", target = name, spawntype = "601", spawns = {}, tp = "1", time = os.time()}
  ui.addTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> clear</a>", name, 10, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
  ui.addTextArea(2, "<a href='event:tplist'><VP>teleporting</VP> yourself</a>", name, 130, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
  ui.addTextArea(4, "<a href='event:spawnselect'><VP>spawn:</VP> ball</a>", name, 280, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
end

givePowers(master)

function removePowers(name)
  if name == master then
    unbindMaster()
  end
  for keys, k in pairs({32, 67, 72, 74, 75, 76, 88}) do -- Space, C, H, K, J, L, X
    tfm.exec.bindKeyboard(name, k, true, false) -- C
  end
  system.bindMouse(name, false)
  print(name .. " got powers removed!")
  ui.addPopup(1, 0, "<b>" .. master .. "</b> removed your powers :(", name, 400, 100, 200, true)
  for i, o in pairs({1, 2, 3, 4, 5}) do
    ui.removeTextArea(o, name)
  end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function finditem(a)
  for id, name in pairs(itemlist) do
    if a == id then return name
    elseif a == name then return id
    end
  end
end

function shootBall(name, direction, x, y)
  if tablelength(player[name]["spawns"]) >= itemlimit then
    tfm.exec.removeObject(player[name]["spawns"][itemlimit])
  end

  if direction == "left" then
    table.insert(player[name]["spawns"], 1, tfm.exec.addShamanObject(6, x - 20, y, 0, -25, 0, false))
  end
  if direction == "right" then
    table.insert(player[name]["spawns"], 1, tfm.exec.addShamanObject(6, x + 20, y, 0, 25, 0, false))
  end
  if direction == "down" then
    table.insert(player[name]["spawns"], 1, tfm.exec.addShamanObject(6, x, y + 10, 0, 0, 25, false))
  end
end

function spawnItem(id, name, x, y)
  if tablelength(player[name]["spawns"]) >= itemlimit then
    tfm.exec.removeObject(player[name]["spawns"][itemlimit])
  end
  table.insert(player[name]["spawns"], 1, tfm.exec.addShamanObject(id, x, y, 0, 0, 0, false))
end

function cycleMouse(name)
  if player[name]["mouse"] == "spawn" then
    player[name]["mouse"] = "sp"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> sp</a>", name)
  elseif player[name]["mouse"] == "sp" then
    player[name]["mouse"] = "clear"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> clear</a>", name)
  elseif player[name]["mouse"] == "clear" then
    player[name]["mouse"] = "tp"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> tp</a>", name)
  elseif player[name]["mouse"] == "tp" then
    player[name]["mouse"] = "spawn"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> spawn</a>", name)
  end
end

function eventKeyboard(name, key, down, x, y)
  if key == 32 then -- Space
    cycleMouse(name)
  end
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
    player[name]["mouse"] = "clear"
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

function eventTextAreaCallback(textAreaID, playerName, callback)

  if textAreaID == 1 then
    cycleMouse(playerName)
  end

  if textAreaID == 2 then
    ui.removeTextArea(2, playerName)

    playerCount = tablelength(tfm.get.room.playerList)
    local areasize = 35 + playerCount * 17

    telelist = ""
    for name, player in pairs(tfm.get.room.playerList) do
      telelist = telelist .. "<a href='event:" .. name .. "'>" .. name .. "</a><br>"
    end

    ui.addTextArea(3, "Teleport:<br><br><br>" .. telelist, playerName, 130, -17, 110, areasize, 0x000000, 0x222222, 0.6, true)
  end

  if textAreaID == 3 then
    ui.removeTextArea(3, playerName)
    player[playerName]["mouse"] = "tp"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> tp</a>", playerName)
    player[playerName]["target"] = callback
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
      player[playerName]["spawntype"] = callback
      ui.addTextArea(4, "<a href='event:spawnselect'><VP>spawn:</VP> " .. finditem(tonumber(callback)) .. "</a>", playerName, 280, -17, 0, 0, 0x000000, 0x222222, 0.3, true)
      player[playerName]["mouse"] = "spawn"
      ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> spawn</a>", playerName)
    end
  end

  if textAreaID == 666 then
    ui.addPopup(8, 2, "Give master to:", master, 400, 100, 200, true)
  end

end

function eventMouse(name, x, y)
  if player[name]["mouse"] == "tp" then
    if player[name]["time"] < os.time() - 5000 then
      player[name]["tp"] = 1
    end
    if player[name]["tp"] == 1 then
      tfm.exec.movePlayer(player[name]["target"], x, y, false, 0, 1, false)
      player[name]["time"] = os.time()
      player[name]["tp"] = 0
    end
  elseif player[name]["mouse"] == "sp" then
    tfm.exec.explosion(x, y, 20, 100, false)
  elseif player[name]["mouse"] == "spawn" then
    spawnItem(player[name]["spawntype"], name, x, y)
  end
end

function eventPopupAnswer(popupID, playerName, answer)
  if popupID == 1 and answer == pass then
    givePowers(playerName)
  elseif popupID == 1 then
    print(playerName .. " tried to guess the pass: " .. answer)
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
    unbindMaster()
    master = playerName
    ui.updateTextArea(666, "<ROSE>master:</ROSE> " .. master, nil)
    givePowers(master)
  elseif popupID == 7 then
    print(playerName .. " tried to guess the masterpass: " .. answer)
  end
  if popupID == 8 then
    ui.addPopup(1, 0, "You honourably passed on the master status to " .. answer:gsub("^%l", string.upper) .. " :)", master, 400, 100, 200, true)
    ui.addPopup(1, 0, "<b>WOW! " .. master .. " gave you master powers!<br>SPECIAL MASTER ABILITIES:</b><br>G - Give power to someone<br>F - Remove powers from someone<br>B - Set item limit<br><br>" .. helpstring, answer:gsub("^%l", string.upper), 200, 100, 400, true)
    master = answer:gsub("^%l", string.upper)
    ui.updateTextArea(666, "<ROSE>master:</ROSE> " .. master, nil)
    givePowers(master)
  end
  if popupID == 9 and tonumber(answer) == nil then
    answer = finditem(string.lower(answer))
    player[playerName]["spawntype"] = answer
    ui.updateTextArea(4, "<a href='event:spawnselect'><VP>spawn:</VP> " .. finditem(answer) .. "</a>", playerName)
    player[playerName]["mouse"] = "spawn"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> spawn</a>", playerName)
  elseif popupID == 9 then
    answer = finditem(tonumber(answer))
    player[playerName]["spawntype"] = finditem(answer)
    ui.updateTextArea(4, "<a href='event:spawnselect'><VP>spawn:</VP> " .. answer .. "</a>", playerName)
    player[playerName]["mouse"] = "spawn"
    ui.updateTextArea(1, "<a href='event:clicktype'><VP>click type:</VP> spawn</a>", playerName)
  end
end

function eventNewPlayer(name)
  startBind(name)
end