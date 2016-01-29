tfm.exec.newGame(6445588)
tfm.exec.setNameColor("Imaginist",0xFFFFFF)
tfm.exec.setNameColor("Dedax",0xFFFFFF)
tfm.exec.setUIMapName("I Love You")
tfm.exec.setGameTime(8000,true)

function eventLoop(timeRemaining,timeRemaining)

  imax = tfm.get.room.playerList.Imaginist.x
  imay = tfm.get.room.playerList.Imaginist.y
  ihx = math.random(1,40)
  ihy = math.random(1,40)
  ihrx = imax-20+ihx
  ihry = imay-20+ihy
  tfm.exec.displayParticle(5,ihrx,ihry-30,0,0,0,0,nil)

  dedx = tfm.get.room.playerList.Dedax.x
  dedy = tfm.get.room.playerList.Dedax.y
  dhx = math.random(1,40)
  dhy = math.random(1,40)
  dhrx = dedx-20+dhx
  dhry = dedy-20+dhy
  tfm.exec.displayParticle(5,dhrx,dhry-30,0,0,0,0,nil)

  if imax-dedx <= 50 and imax-dedx >= -50 then
    if imay-dedy <= 50 and imay-dedy >= -50 then

      sp1 = math.random(0,9)-5
      sp2 = math.random(0,9)-5
      sp3 = math.random(0,9)-5
      sp4 = math.random(0,9)-5

      xg1 = math.random(30,770)
      xg2 = math.random(30,770)
      xg3 = math.random(30,770)
      xg4 = math.random(30,770)
      yg1 = math.random(30,370)
      yg2 = math.random(30,370)
      yg3 = math.random(30,370)
      yg4 = math.random(30,370)

      gh1 = math.random(0,1)
      gh2 = math.random(0,1)
      gh3 = math.random(0,1)
      gh4 = math.random(0,1)

      if gh1 == 1 then tfm.exec.displayParticle(11,xg1,yg1,sp1,sp2,0,0,nil) end
      if gh2 == 1 then tfm.exec.displayParticle(11,xg2,yg2,sp2,sp3,0,0,nil) end
      if gh3 == 1 then tfm.exec.displayParticle(11,xg3,yg3,sp3,sp4,0,0,nil) end
      if gh4 == 1 then tfm.exec.displayParticle(11,xg4,yg4,sp4,sp1,0,0,nil) end

      spa1 = math.random(0,9)-5
      spa2 = math.random(0,9)-5
      spa3 = math.random(0,9)-5
      spa4 = math.random(0,9)-5

      xga1 = math.random(30,770)
      xga2 = math.random(30,770)
      xga3 = math.random(30,770)
      xga4 = math.random(30,770)
      yga1 = math.random(30,370)
      yga2 = math.random(30,370)
      yga3 = math.random(30,370)
      yga4 = math.random(30,370)

      gha1 = math.random(0,1)
      gha2 = math.random(0,1)
      gha3 = math.random(0,1)
      gha4 = math.random(0,1)

      if gha1 == 1 then tfm.exec.displayParticle(0,xga1,yga1,spa1,spa2,0,0,nil) end
      if gha2 == 1 then tfm.exec.displayParticle(0,xga2,yga2,spa2,spa3,0,0,nil) end
      if gha3 == 1 then tfm.exec.displayParticle(0,xga3,yga3,spa3,spa4,0,0,nil) end
      if gha4 == 1 then tfm.exec.displayParticle(0,xga4,yga4,spa4,spa1,0,0,nil) end

      spb1 = math.random(0,9)-5
      spb2 = math.random(0,9)-5
      spb3 = math.random(0,9)-5
      spb4 = math.random(0,9)-5

      xgb1 = math.random(30,770)
      xgb2 = math.random(30,770)
      xgb3 = math.random(30,770)
      xgb4 = math.random(30,770)
      ygb1 = math.random(30,370)
      ygb2 = math.random(30,370)
      ygb3 = math.random(30,370)
      ygb4 = math.random(30,370)

      ghb1 = math.random(0,1)
      ghb2 = math.random(0,1)
      ghb3 = math.random(0,1)
      ghb4 = math.random(0,1)

      if ghb1 == 1 then tfm.exec.displayParticle(1,xgb1,ygb1,spb1,spb2,0,0,nil) end
      if ghb2 == 1 then tfm.exec.displayParticle(1,xgb2,ygb2,spb2,spb3,0,0,nil) end
      if ghb3 == 1 then tfm.exec.displayParticle(1,xgb3,ygb3,spb3,spb4,0,0,nil) end
      if ghb4 == 1 then tfm.exec.displayParticle(1,xgb4,ygb4,spb4,spb1,0,0,nil) end

      spc1 = math.random(0,9)-5
      spc2 = math.random(0,9)-5
      spc3 = math.random(0,9)-5
      spc4 = math.random(0,9)-5

      xgc1 = math.random(30,770)
      xgc2 = math.random(30,770)
      xgc3 = math.random(30,770)
      xgc4 = math.random(30,770)
      ygc1 = math.random(30,370)
      ygc2 = math.random(30,370)
      ygc3 = math.random(30,370)
      ygc4 = math.random(30,370)

      ghc1 = math.random(0,1)
      ghc2 = math.random(0,1)
      ghc3 = math.random(0,1)
      ghc4 = math.random(0,1)

      if ghc1 == 1 then tfm.exec.displayParticle(9,xgc1,ygc1,spc1,spc2,0,0,nil) end
      if ghc2 == 1 then tfm.exec.displayParticle(9,xgc2,ygc2,spc2,spc3,0,0,nil) end
      if ghc3 == 1 then tfm.exec.displayParticle(9,xgc3,ygc3,spc3,spc4,0,0,nil) end
      if ghc4 == 1 then tfm.exec.displayParticle(9,xgc4,ygc4,spc4,spc1,0,0,nil) end

      spd1 = math.random(0,9)-5
      spd2 = math.random(0,9)-5
      spd3 = math.random(0,9)-5
      spd4 = math.random(0,9)-5

      xge1 = math.random(30,770)
      xge2 = math.random(30,770)
      xge3 = math.random(30,770)
      xge4 = math.random(30,770)
      yge1 = math.random(30,370)
      yge2 = math.random(30,370)
      yge3 = math.random(30,370)
      yge4 = math.random(30,370)

      ghe1 = math.random(0,1)
      ghe2 = math.random(0,1)
      ghe3 = math.random(0,1)
      ghe4 = math.random(0,1)

      if ghe1 == 1 then tfm.exec.displayParticle(13,xge1,yge1,spd1,spd2,0,0,nil) end
      if ghe2 == 1 then tfm.exec.displayParticle(13,xge2,yge2,spd2,spd3,0,0,nil) end
      if ghe3 == 1 then tfm.exec.displayParticle(13,xge3,yge3,spd3,spd4,0,0,nil) end
      if ghe4 == 1 then tfm.exec.displayParticle(13,xge4,yge4,spd4,spd1,0,0,nil) end

    end
  end

  spe1 = math.random(0,9)-5
  spe2 = math.random(0,9)-5
  spe3 = math.random(0,9)-5
  spe4 = math.random(0,9)-5

  x1 = math.random(30,770)
  x2 = math.random(30,770)
  x3 = math.random(30,770)
  x4 = math.random(30,770)
  y1 = math.random(30,370)
  y2 = math.random(30,370)
  y3 = math.random(30,370)
  y4 = math.random(30,370)

  rh1 = math.random(0,1)
  rh2 = math.random(0,1)
  rh3 = math.random(0,1)
  rh4 = math.random(0,1)

  if rh1 == 1 then tfm.exec.displayParticle(30,x1,y1,spe1,spe2,0,0,nil) end
  if rh2 == 1 then tfm.exec.displayParticle(30,x2,y2,spe2,spe3,0,0,nil) end
  if rh3 == 1 then tfm.exec.displayParticle(30,x3,y3,spe3,spe4,0,0,nil) end
  if rh4 == 1 then tfm.exec.displayParticle(30,x4,y4,spe4,spe1,0,0,nil) end

  spf1 = math.random(0,9)-5
  spf2 = math.random(0,9)-5
  spf3 = math.random(0,9)-5
  spf4 = math.random(0,9)-5

  a1 = math.random(30,770)
  a2 = math.random(30,770)
  a3 = math.random(30,770)
  a4 = math.random(30,770)
  b1 = math.random(30,370)
  b2 = math.random(30,370)
  b3 = math.random(30,370)
  b4 = math.random(30,370)

  ph1 = math.random(0,1)
  ph2 = math.random(0,1)
  ph3 = math.random(0,1)
  ph4 = math.random(0,1)

  if ph1 == 1 then tfm.exec.displayParticle(31,a1,b1,spf1,spf2,0,0,nil) end
  if ph2 == 1 then tfm.exec.displayParticle(31,a2,b2,spf2,spf3,0,0,nil) end
  if ph3 == 1 then tfm.exec.displayParticle(31,a3,b3,spf3,spf4,0,0,nil) end
  if ph4 == 1 then tfm.exec.displayParticle(31,a4,b4,spf4,spf1,0,0,nil) end

  tfm.exec.displayParticle(31,a4,b4,0,0,0,0,nil)

end

function eventEmotePlayed(name, id)
  if id==3 and name=="Imaginist" then
    tfm.exec.displayParticle(10,tfm.get.room.playerList.Imaginist.x,tfm.get.room.playerList.Imaginist.y-30,0,0,0,0,nil)
  end
  if id==3 and name=="Dedax" then
    tfm.exec.displayParticle(10,tfm.get.room.playerList.Dedax.x,tfm.get.room.playerList.Dedax.y-30,0,0,0,0,nil)
  end
end
