player = {}
balls = {}
limit = 3
shuffle = {}
ground1 = 10000
ground2 = 40000
ticker = 0
spawnticker = 0
powers = 0
powered = 5000
powertime = 4500
xx = 0

KEYS={
  J=74,
  K=75,
  L=76
}

ITEMS={
  BALL = 6,
  ANVIL = 10,
  SPIRIT = 24,
  BALLOON = 28,
  FISH = 63,
  PUFFERFISH = 65,
  HEARTBOX=101,
}

map = '<C><P F="0" /><Z><S><S L="250" H="40" X="125" Y="200" T="8" P="0,0,0.3,0.2,0,0,0,0" /><S L="200" H="30" X="100" Y="200" T="0" P="0,0,0.3,0.2,0,0,0,0" v="10000" /><S L="250" X="675" H="40" Y="200" T="8" P="0,0,0.3,0.2,0,0,0,0" /><S L="200" X="700" H="30" Y="200" T="0" P="0,0,0.3,0.2,0,0,0,0" v="10000" /><S L="800" H="30" X="400" Y="385" T="8" P="0,0,0.3,0.2,0,0,0,0" /><S L="800" H="20" X="400" Y="390" T="0" P="0,0,0.3,0.2,0,0,0,0" v="40000" /><S L="780" H="10" X="400" Y="-5" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="10" H="150" X="5" Y="-75" T="1" P="0,0,0,0.2,0,0,0,0" /><S L="10" X="795" H="150" Y="-75" T="1" P="0,0,0,0.2,0,0,0,0" /><S L="780" H="10" X="400" Y="-145" T="1" P="0,0,0,0.2,0,0,0,0" /></S><D><P P="0,0" C="fdfdfd" Y="-73" T="90" X="120" /><F Y="200" X="400" /><DS Y="-27" X="401" /><P P="0,0" C="8a311b" Y="-10" T="15" X="588" /><P P="0,0" C="8a311b" Y="-10" T="19" X="151" /><P P="0,0" C="8a311b" Y="-10" T="19" X="218" /><P P="0,0" C="8a311b" Y="-10" T="19" X="285" /><P P="0,0" Y="-11" T="26" X="752" /></D><O /></Z></C>'

tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoTimeLeft(true)

function round(t)
  return math.ceil(t/1000)
end

function maptimer()
  ui.addTextArea(1, "10", nil, 94, 192, 12, 16, nil, nil, 0.8, false)
  ui.addTextArea(2, "40", nil, 391, 382, 18, 16, nil, nil, 0.8, false)
end

function shootBall(name, direction, x, y)
  if #player[name]["spawns"] >= limit then
    tfm.exec.removeObject(player[name]["spawns"][limit])
  end
  if direction == "left" then
    xPosition = x - 20
    yPosition = y
    xSpeed = -25
    ySpeed = 0
  end
  if direction == "right" then
     xPosition = x + 20
     yPosition = y
     xSpeed = 25
     ySpeed = 0
  end
  id = tfm.exec.addShamanObject(player[name]["power"].powertype, xPosition, yPosition, 0, xSpeed, ySpeed, false)
  table.insert(balls,{os.time(),id})
  table.insert(player[name]["spawns"], 1, id)
end

function powerUp()
  where = math.random(3)
  print(where)
  if where == 1 then
    xx = 200
  elseif where == 2 then
    xx = 400
  else
    xx = 600
  end
  tfm.exec.addPhysicObject(169,xx,50,{type=8,restitution=0.2,friction=0.3,width=30,height=30,miceCollision=false,groundCollision=false})
  powers = os.time()
  powerparty = 1
  print("Power Party! :)")
end

function givePower(name)
  if player[name]["power"].on == 0 then
    luck = math.random(6)
    if luck == 1 then luck = ITEMS.ANVIL
    elseif luck == 2 then luck = ITEMS.SPIRIT
    elseif luck == 3 then luck = ITEMS.BALLOON
    elseif luck == 4 then luck = ITEMS.HEARTBOX
    elseif luck == 5 then luck = ITEMS.PUFFERFISH
    elseif luck == 6 then luck = ITEMS.FISH
    else luck = player[name]["balltype"] end
    print("Granted for "..name.."! Lucky number "..luck)
    player[name]["power"] = {powertype = luck, on = 1, time = os.time()}
  else
    print(name.." already has a power.")
  end
end

function bindAll(name)
  for _, k in pairs({74, 75, 76}) do
    tfm.exec.bindKeyboard(name, k, true, true)
    print("bound key "..k)
  end
end

function unbindPlayer(name)
  for _, k in pairs({74, 75, 76}) do
    tfm.exec.bindKeyboard(name, k, true, false)
  end
end

function eventLoop(time,remaining)
  for i,cannon in ipairs(balls) do
    if cannon[1] <= os.time()-1000 then
      tfm.exec.removeObject(cannon[2])
      table.remove(balls,i)
    end
  end

  if ticker == 0 then
    if ground1 > 0 then
      ground1 = ground1 - 1
      ui.updateTextArea(1,ground1,nil)
    else
      ui.removeTextArea(1,nil)
    end
    if ground2 > 0 then
      ground2 = ground2 - 1
      ui.updateTextArea(2,ground2,nil)
    else
      ui.removeTextArea(2,nil)
    end
    ticker = ticker + 1
  else
    ticker = 0
  end

  if time >= 10000 and time <= 10500 then powerUp() end
  if time >= 30000 and time <= 30500 then powerUp() end
  if time >= 50000 and time <= 50500 then powerUp() end
  if time >= 70000 and time <= 70500 then powerUp() end
  if time >= 90000 and time <= 90500 then powerUp() end
  if time >= 100000 and time <= 100500 then powerUp() end

  if powers <= os.time()-powered and powerparty == 1 then
    powerparty = 0
    tfm.exec.removePhysicObject(169)
    print("Power Party over ;/")
  end
  
  for name,players in pairs(tfm.get.room.playerList) do
    if powerparty == 1 and players.x >= xx-15 and players.x <= xx+15 and players.y >= 35 and players.y <= 65 then givePower(name) end
    if player[name]["power"].on == 1 then
      if player[name]["power"].time <= os.time()-powertime then
        player[name]["power"].on = 0
        player[name]["power"].powertype = player[name]["balltype"]
        print("Power disabled for "..name)
      end
    end
  end
  simple = round(time)
end

function eventKeyboard(name, key, down, x, y)
  if powerparty == 1 and x >= xx-15 and x <= xx+15 and y >= 35 and y <= 65 then givePower(name) end
  if key == KEYS.J then
    shootBall(name, "left", x, y)
  end
  if key == KEYS.K then
    id = tfm.exec.addShamanObject(player[name]["balltype"], x, y + 10, 0, 0, 15, false)
    table.insert(balls,{os.time(),id})
    table.insert(player[name]["spawns"], 1, id)
  end
  if key == KEYS.L then
    shootBall(name, "right", x, y)
  end
end

function eventTextAreaCallback(id, name, callback)
  if id == 69 then
    ui.removeTextArea(69,nil)
    tfm.exec.newGame(map)
  end
end

function eventNewGame()
  print("A new round has just started.")
  maptimer()
  for name,player in pairs(tfm.get.room.playerList) do
      table.insert(shuffle, 1, {name, player.score})
      print("Player "..name.." with "..player.score.." points registered.")
      if spawnticker == 0 then
        tfm.exec.movePlayer(name, 100, 185, false, 0, 0, false)
        spawnticker = spawnticker + 1
      else
        tfm.exec.movePlayer(name, 700, 185, false, 0, 0, false)
        spawnticker = 0
      end
      print(name.." is now playing.")
  end
  ground1 = 10
  ground2 = 40
end

function eventPlayerWon(name)
    tfm.exec.respawnPlayer(name)
end

function eventPlayerDied(name)
    tfm.exec.respawnPlayer(name)
    ui.addTextArea(69, "<a href='event:reset'><VP>Reset</VP></a>", nil, 380, -138, 40, 15, nil, nil, 1, false)
end

function eventNewPlayer(name)
    bindAll(name)
    player[name] = {balltype = 6, power = {powertype = ITEMS.BALL, on = 1, time = os.time()}, spawns = {}}
end

for name,player in pairs(tfm.get.room.playerList) do
    eventNewPlayer(name)
end

tfm.exec.newGame(map)
