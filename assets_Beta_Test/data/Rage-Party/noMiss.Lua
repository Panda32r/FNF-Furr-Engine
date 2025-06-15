local NoMiss = 0

function onCreate()
	makeLuaText('NoMiss', 'Miss 0/5', 1280, 5, -1000)
	setProperty('NoMiss.camera', instanceArg('camHUD'), false, true)
	addLuaText('NoMiss')

	setTextSize('NoMiss', 25)
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if curStep >= 1472 then
		if noteType == 'Nots_eat' then
			NoMiss = NoMiss + 1
			if NoMiss <= 5 then	
				makeLuaText('NoMiss', 'Miss '..NoMiss..'/5', 1280, 5, 150) --Y 100
				addLuaText('NoMiss')
				setTextSize('NoMiss', 25)
				setTextColor('NoMiss','#FF0000')
			end
		end
	end	
end

function noteMiss(id, direction, noteType, isSustainNote)
	if curStep >= 1472 then
		NoMiss = NoMiss + 1
		if NoMiss <= 5 then	
			makeLuaText('NoMiss', 'Miss '..NoMiss..'/5', 1280, 5, 150) --Y 100
			addLuaText('NoMiss')
			setTextSize('NoMiss', 25)
			setTextColor('NoMiss','#FF0000')
		end
	end	
end

function onUpdate()
	if curStep >= 1472 then
		if NoMiss > 5 then
			setProperty('health', 0)
		end
	end
	if curStep == 1488 then
		doTweenY('TweenNoMiss', 'NoMiss', 150, 1.2, 'quintInOut')
	end
end