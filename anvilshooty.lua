toDespawn={} -- define a table variable that you can put spawned items into

--

function eventMouse(name,xco,yco) -- name = name of clicker, xco = x cord of click, yco = y cord of click
  ax = tfm.get.room.playerList[name].x -- x cord of mouse that clicked 
  by = tfm.get.room.playerList[name].y -- y cord of mouse that clicked 

  x = ax - xco -- x cord of mouse minus x cord of click
  y = by - yco -- y cord of mouse minus y cord of click

-- if mouse cords are both bigger than mouse click cords (which means mouse has clicked to the RIGHT and DOWN of his own mouse)
  if ax < xco and by < yco then
    print("| right | down |")
    xo = x-x-x -- making a new variable (from x) that is flipped from positive to negative but with same numerical value
    yo = y-y-y -- same
    xs = xo/10 -- define the speed derived from the opposite (and lower (division)) value of the thing (???)
    ys = yo/10 -- same
  elseif ax > xco and by < yco then -- if left and down of click
    print(" | left | down | ")
    xo = x-x-x
    yo = y-y-y
    xs = xo/10
    ys = yo/10
  elseif ax < xco and by > yco then -- if right and up of click
    print(" | right | up | ")
    xo = x-x-x
    yo = y-y-y
    xs = xo/10
    ys = yo/10
  elseif ax > xco and by > yco then -- if left and up of click
    print(" | left | up | ")
    xo = x-x-x
    yo = y-y-y
    xs = xo/10
    ys = yo/10
  end
  id = tfm.exec.addShamanObject(6, xco, yco, 0, xs, ys, false) -- shoot the ball (id 6) from mouse-click position (xco, yco) with the derived speed (xs, ys)
  table.insert(toDespawn,{os.time(),id}) -- insert into list over items to be despawned by cleaner-upper below
end

-- clean up spawned items

function eventLoop(time,remaining) -- activates every half second, variables (time,remaining) don't matter in this script
  for i,cannon in ipairs(toDespawn) do -- for item,item in toDespawn table
    if cannon[1] <= os.time()-3000 then -- if item is older than 3000 milliseconds
      tfm.exec.removeObject(cannon[2]) -- fucking remove them m8
      table.remove(toDespawn,i) -- remove from list of things to be despawned
    end
  end
end

-- initiate the script and bind mouseclicks 

for name, player in pairs(tfm.get.room.playerList) do -- loop every mouse, takes two mice in a single loop
  system.bindMouse(name,true) -- player one bound now
  system.bindMouse(player,true) -- second player in the single loop bound
end

-- if a mouse enters the room

function eventNewPlayer(name)
  system.bindMouse(name,true)
end