local stepNew = 1

function onStepHit()
	lightShow(1600)
	lightShow(1616)
	lightShow(1632)
	lightShow(1648)
	lightShow(1664)
	lightShow(1680)
	lightShow(1696)
	lightShow(1712)
	lightShow(1728)
	lightShow(1744)
	lightShow(1760)
	lightShow(1776)
	lightShow(1792)
	lightShow(1808)
	lightShow(1824)
	lightShow(1840)
	lightShow(1856)
	lightShow(1872)
	lightShow(1888)
	lightShow(1904)
	lightShow(1920)
	lightShow(1936)
	lightShow(1952)
	lightShow(1968)
	lightShow(1984)
	lightShow(2000)
	lightShow(2016)
	lightShow(2032)
	lightShow(2048)
	lightShow(2064)
	lightShow(2080)
	lightShow(2096)
	if curStep == 2112 then
		doTweenColor('lightcolor', 'light', '#FFF', 0.01, 'linear')
		doTweenColor('light1color', 'light1', '#FFF', 0.01, 'linear')
		doTweenColor('Starscolor', 'Stars', '#FFF', 0.01, 'linear')
		doTweenColor('Mooncolor', 'Moon', '#FFF', 0.01, 'linear')
	end

end

function lightShow(step)
	if curStep == step+4 then
		setProperty("light.alpha", 0.5)
		doTweenAlpha("lightalhpa", "light", 0.3, 0.4, "linear")
		setProperty("light1.alpha", 0.5)
		doTweenAlpha("light1alhpa", "light1", 0.3, 0.4, "linear")
		doTweenColor('lightcolor', 'light', '#FF0000', 0.01, 'linear')
		doTweenColor('light1color', 'light1', '#FF0000', 0.01, 'linear')
		doTweenColor('Starscolor', 'Stars', '#FF0000', 0.01, 'linear')
		doTweenColor('Mooncolor', 'Moon', '#FF0000', 0.01, 'linear')
		
	end
	if curStep == step+10 then
		setProperty("light.alpha", 0.5)
		doTweenAlpha("lightalhpa", "light", 0.3, 0.4, "linear")
		setProperty("light1.alpha", 0.5)
		doTweenAlpha("light1alhpa", "light1", 0.3, 0.4, "linear")
		doTweenColor('lightcolor', 'light', '#008000', 0.01, 'linear')
		doTweenColor('light1color', 'light1', '#008000', 0.01, 'linear')
		doTweenColor('Starscolor', 'Stars', '#008000', 0.01, 'linear')
		doTweenColor('Mooncolor', 'Moon', '#008000', 0.01, 'linear')
		
	end
	if curStep == step+14 then
		setProperty("light.alpha", 0.5)
		doTweenAlpha("lightalhpa", "light", 0.3, 0.4, "linear")
		setProperty("light1.alpha", 0.5)
		doTweenAlpha("light1alhpa", "light1", 0.3, 0.4, "linear")
		doTweenColor('lightcolor', 'light', '#FFFF00', 0.01, 'linear')
		doTweenColor('light1color', 'light1', '#FFFF00', 0.01, 'linear')
		doTweenColor('Starscolor', 'Stars', '#FFFF00', 0.01, 'linear')
		doTweenColor('Mooncolor', 'Moon', '#FFFF00', 0.01, 'linear')
		
	end
end