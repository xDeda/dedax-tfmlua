moduleName="tactutil"
players={}
notifyOrder={}
map={}
currentTime=0
SPAWNEDOBJS = {}
_S = {}
ctrldown = {}
paired = {}
paircount = 0

ranks={
    Tactcat=5
}

RANKS={
    STAFF=5,
    ROOM_OWNER=4,
    ROOM_ADMIN=3,
    ANY=1
}

modes={
    tribe="mapMode_tribe",
    tribehouse="mapMode_tribe",
    bootcamp="mapMode_bootcamp",
    shaman="mapMode_shaman",
    sham="mapMode_shaman",
    dual="mapMode_dual_shaman",
    all="mapMode_all_shaman",
    vampire="mapMode_vampire",
    vamp="mapMode_vampire",
    racing="mapMode_racing",
    survivor="mapMode_survivor",
}

translations = {}
maps = {}

toRespawn={}

mapInfo={
    lastLoad=os.time()-5000,
    queue={},
}
map={}

KEYS={
    LEFT=0,
    UP=1,
    RIGHT=2,
    DOWN=3,
    BACKSPACE=8,
    SHIFT=16,
    CTRL=17,
    ALT=18,
    CAPS=20,
    ESCAPE=27,
    SPACE=32,
    PAGEUP=33,
    PAGEDOWN=34,
    END=35,
    HOME=36,
    LEFT_ARROW=37,
    UP_ARROW=38,
    RIGHT_ARROW=39,
    DOWN_ARROW=40,
    DELETE=46,
    [0]=48,
    [1]=49,
    [2]=50,
    [3]=51,
    [4]=52,
    [5]=53,
    [6]=54,
    [7]=55,
    [8]=56,
    [9]=57,
    A=65,
    B=66,
    C=67,
    D=68,
    E=69,
    F=70,
    G=71,
    H=72,
    I=73,
    K=75,
    J=74,
    L=76,
    M=77,
    N=78,
    O=79,
    P=80,
    Q=81,
    R=82,
    S=83,
    T=84,
    U=85,
    V=86,
    W=87,
    X=88,
    Y=89,
    Z=90,
    ["WINDOWS"]=91,
    ["CONTEXT"]=93,
    ["NUMPAD 0"]=96,
    ["NUMPAD 1"]=97,
    ["NUMPAD 2"]=98,
    ["NUMPAD 3"]=99,
    ["NUMPAD 4"]=100,
    ["NUMPAD 5"]=101,
    ["NUMPAD 6"]=102,
    ["NUMPAD 7"]=103,
    ["NUMPAD 8"]=104,
    ["NUMPAD 9"]=105,
    ["F1"]=112,
    ["F2"]=113,
    ["F3"]=114,
    ["F4"]=115,
    ["F5"]=116,
    ["F6"]=117,
    ["F7"]=118,
    ["F8"]=119,
    ["F9"]=120,
    ["F10"]=121,
    ["F11"]=122,
    ["F12"]=123,
    ["NUMLOCK"]=144,
    [";"]=186,
    ["="]=187,
    [","]=188,
    ["-"]=189,
    ["."]=190,
    ["/"]=191,
    ["'"]=192,
    ["["]=219,
    ["\\"]=220,
    ["]"]=221,
    ["#"]=222,
    ["`"]=223,
}

-- Particle IDs for fireworks
REDWHITEBLUE = {13,0,-1}

tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAfkDeath(true)

_,_,suffix=string.find((tfm.get.room.name:sub(1,2)=="e2" and tfm.get.room.name:sub(3)) or tfm.get.room.name,"%d+(.+)$")
local roomSuffix = string.match(tfm.get.room.name, "%d+(.-)$")

function selectMap(map,category)
    if map then
        if category and maps[category] and (maps[category][tonumber(map)] or maps[category][map]) then
            local m=maps[category][tonumber(map)] or maps[category][map]
            if type(m)=="table" then m=table.random(m,false,true) end
            playMap(m)
        elseif category and maps[category] then
            playMap(randomMap(maps[category]))
        elseif category and modes[tostring(category):lower()] then
            tempMode=category:lower()
            playMap(map)
        elseif maps[map] then
            playMap(randomMap(maps[map]))
        else
            playMap(map)
        end
    else
        if mapInfo.queue[1] then
            playMap(mapInfo.queue[1].map)
            tfm.exec.chatMessagePublic("loadingmap",players,mapInfo.queue[1].map,mapInfo.queue[1].name)
            table.remove(mapInfo.queue,1)
        else
            local tbl={} for k,v in pairs(SETTINGS.ROTATION) do table.insert(tbl,k) end
            local category=tbl[math.random(#tbl)]
            playMap(randomMap(maps[category]) or 0)
        end
    end
end

function playMap(map)
    local timeSinceLastLoad=os.time()-mapInfo.lastLoad
    if timeSinceLastLoad<=3000 then
        --tfm.exec.chatMessage("Error. Map trying to reload: "..map)
        local timeUntilNextLoad=3000-timeSinceLastLoad
        if timeUntilNextLoad<1000 then timeUntilNextLoad=1000 end
        if mapInfo.timer then system.removeTimer(mapInfo.timer) mapInfo.timer=nil end
        mapInfo.timer=system.newTimer(function(...)
            local arg={...}
            --tfm.exec.chatMessage("Reloading "..tostring(arg[2]))
            playMap(arg[2])
        end,timeUntilNextLoad,false,map,map)
    else
        --tfm.exec.chatMessage("Map "..map.." loaded!")
        tfm.exec.newGame(map,false)
        mapInfo.lastLoad=os.time()
    end
end

function pairup(message)
    local i = 0
    local t = {}
    for k, v in string.gmatch(message, "(%S+)") do
        t[i] = k
        i = i+1
    end
    paired[paircount] = t
    print("Pair number "..paircount..": "..paired[paircount][0].."and"..paired[paircount][1])
    tfm.exec.linkMice(paired[paircount][0],paired[paircount][1],true)
    paircount = paircount+1
end

function pairdown(name)
    for i, j in pairs(paired) do
        if paired[i][0] == name then
            tfm.exec.linkMice(paired[i][0],paired[i][1],false)
            print("Unpaired "..paired[i][0].." and ".. paired[i][1])
            paired[i] = nil
            break
        elseif paired[i][1] == name then
            tfm.exec.linkMice(paired[i][0],paired[i][1],false)
            print("Unpaired "..paired[i][0].." and ".. paired[i][1])
            paired[i] = nil
            break
        end
    end
end

function listpair()
    for i, j in pairs(paired) do
        print(paired[i][0].." and ".. paired[i][1])
    end
end

function undo(name)
    local delet = 0
    local last = 0
    for i, j in pairs(players[name].obj) do
        delet = j
        last = i
    end
    tfm.exec.removeObject(delet)
    table.remove(players[name].obj,last)
end

function eventChatCommand(name,message)
    print(name.." said "..message)
    if message:sub(0,3) == "map" then
        playMap(message:sub(5))
    end
    if message:sub(0,6) == "normal" then 
        tfm.exec.setShaman(name, true)
        tfm.exec.setShamanMode(name,0) 
    end
    if message:sub(0,4) == "hard" then tfm.exec.setShaman(name, true)
        tfm.exec.setShaman(name, true)
        tfm.exec.setShamanMode(name,1) 
    end
    if message:sub(0,6) == "divine" then tfm.exec.setShaman(name, true)
        tfm.exec.setShaman(name, true)
        tfm.exec.setShamanMode(name,2) 
    end
    if message:sub(0,3) == "off" then tfm.exec.setShaman(name,false) end
    if message:sub(0,8) == "nocheese" then
        tfm.exec.removeCheese(name)
    end
    if message:sub(0,5) == "invis" then
        tfm.exec.disablePrespawnPreview(true)
    end
    if message:sub(0,5) == "clear" then
        for objectId in pairs(SPAWNEDOBJS) do
            tfm.exec.removeObject(objectId) 
        end
        for i, j in pairs(players) do
            players[name].obj = {}
        end
        SPAWNEDOBJS = {}
    end
    if message:sub(0,4) == "undo" then
        undo(name)
    end
    if message:sub(0,4) == "size" then
        tfm.exec.changePlayerSize(name,message:sub(5))
    end
    if message:sub(0,9) == "transform" then
        tfm.exec.giveTransformations(name,true)
    end
    if message:sub(0,4) == "link" then
        pairup(message:sub(6))
    end
    if message:sub(0,6) == "unlink" then
        pairdown(name)
    end
    if message:sub(0,3) == "plz" then
        tfm.exec.respawnPlayer(name)
    end
    if message:sub(0,4) == "list" then
        listpair()
        for objectId in pairs(players[name].obj) do
            print(objectId)
        end
    end
end

function eventSummoningEnd(name, type, x, y, ang, other)
    SPAWNEDOBJS[other.id] = true
    table.insert(players[name].obj,other.id)
    print(name.." spawned "..other.id)
end

function eventPlayerWon(name)
    tfm.exec.respawnPlayer(name)
end

function eventPlayerDied(name)
    tfm.exec.respawnPlayer(name)
end

function eventNewPlayer(name)
    print(name.." joined the room!")
    tfm.exec.respawnPlayer(name)
    system.bindMouse(name,true)
    tfm.exec.bindKeyboard(name,KEYS.CTRL,true,true)
    tfm.exec.bindKeyboard(name,KEYS.CTRL,false,true)
    players[name] = { ctrl = false }
    players[name].obj = {}
end

function eventMouse(name,x,y)
    if players[name].ctrl then
        tfm.exec.movePlayer(name,x,y,false,0,0,false)
    end
end

function eventKeyboard(name, key, down, x, y)
    if key==KEYS.CTRL and down==true then
        players[name].ctrl=true
    elseif key==KEYS.CTRL and down==false then
        players[name].ctrl=false
    end
end

for name,player in pairs(tfm.get.room.playerList) do
    eventNewPlayer(name)
end