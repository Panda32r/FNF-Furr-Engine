local fat_hp=false

function opponentNoteHit ( id, direction, noteType, isSustainNote)
  if curStep >= 288 and curStep <= 319 then
      health_down_shit(0.02)
  end

  if curStep >= 319 and curStep <=432 then
      health_down_shit(0.012)
  end

  if curStep >= 432 and curStep <= 496 then
      health_down_shit(0.019)
  end

  if curStep >= 496 and curStep <= 559 then
      health_down_shit(0.04)
  end

  if curStep >= 559 and curStep <= 624 then
      health_down_shit(0.019)
  end

  if curStep >= 624 and curStep <= 655 then
      health_down_shit(0.04)
  end

  if curStep >= 655 and curStep <= 687 then
     health_down_shit(0.018)
  end

  if curStep >= 687 and curStep <= 830 then
      health_down_shit(0.024)
  end

  if curStep >= 832 and curStep <= 1088 then
      health_down_shit(0.026)
  end

  if curStep >= 1088 and curStep <= 1343 then
      health_down_shit(0.04)
  end

  if curStep >= 1420 and curStep <= 1600 then
      health_down_shit(0.015)
  end

  if curStep >= 1600 and curStep <=2112 then
      health_down_shit(0.04)
  end

end

function onUpdate()
  if curStep >= 816 and curStep <= 831 then
          setProperty('health', getProperty('health')  + 0.015)
  end

  if curStep >= 1344 and curStep <= 1464 then
          setProperty('health', getProperty('health')  + 0.015)
  end
  if curStep >= 2112 and curStep <= 2200 then
      if getProperty('health') <=1 then
          setProperty('health', getProperty('health')  + 0.0045)
      end
  end
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
  if noteType == 'Nots_eat' then
    fat_hp=true
  end
end

function health_down_shit(hp)
  if fat_hp then
    if getProperty('health') >= 0.2 then
      setProperty('health', getProperty('health')  - (hp/2))
    end
  else
    if getProperty('health') >= 0.2 then
      setProperty('health', getProperty('health')  - hp)
    end
  end
end