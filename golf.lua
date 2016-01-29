tfm.exec.newGame(4236177)
tfm.exec.setGameTime(8000,true)

golfer = "Dedax"

system.bindMouse(golfer, true)
tfm.exec.addShamanObject(6, 60, 350, 0, 0, false)

inhole = 0
offset = 3.33333333333333333333
holex = 700
holey = 355

function eventLoop(currentTime,timeRemaining)
if inhole == 0 then

ballx = tfm.get.room.objectList[200].x
bally = tfm.get.room.objectList[200].y

if (ballx >= holex-50 and ballx <= holex+50) then
  if (bally >= holey-15 and bally <= holey+15) then
    ui.addTextArea(1, "you did it!!!", nil, 370, 200, 60, 0, 0x324650, 0x212F36, 0.2, false)
    inhole = 1
  end
end

end
end

function eventMouse(name,x,y)
tfm.exec.explosion(x, y, 20, 50, false)
end
