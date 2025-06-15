local IconPoss = getProperty('iconP2.x')
local IconPos = healthBar
local Hid_hud = (-1000)
local HealthY = 75
local hid = false
if downscroll then scoreTxtY = getProperty('scoreTxt.y')+570 else scoreTxtY = getProperty('scoreTxt.y') end
local timeTxtY = getProperty('timeTxt.y')

function show_hud (time,HealthYY)
	if downscroll then
		doTweenY('TweeniconP2', 'iconP2', getProperty('IconPos.y'), time, 'quintInOut')
		doTweenY('TweeniconP1', 'iconP1', getProperty('IconPos.y'), time, 'quintInOut')
	else
		doTweenY('TweeniconP2', 'iconP2', HealthYY, time, 'quintInOut')
		doTweenY('TweeniconP1', 'iconP1', HealthYY, time, 'quintInOut')
	end
	doTweenY('TweenhealthBar', 'healthBar', HealthY+HealthYY, time, 'quintInOut')
	doTweenY('TweentimeTxt', 'scoreTxt', scoreTxtY, time, 'quintInOut')
	doTweenY('TweenscoreTxt', 'timeTxt', timeTxtY, time, 'quintInOut')
end

function hid_hud (hid,time)
	if hid then
		setProperty('iconP1.y',Hid_hud)
		setProperty('iconP2.y',Hid_hud)
		setProperty('healthBar.y', Hid_hud)
		setProperty('scoreTxt.y', Hid_hud*(-1))
		setProperty('timeTxt.y', Hid_hud*(-1))
	else
		doTweenY('TweenhidiconP2', 'iconP2', Hid_hud, time, 'quintInOut')
		doTweenY('TweenhidiconP1', 'iconP1', Hid_hud, time, 'quintInOut')
		doTweenY('TweenhidhealthBar', 'healthBar', Hid_hud, time, 'quintInOut')
		doTweenY('TweenhidtimeTxt', 'scoreTxt', Hid_hud*(-1), time, 'quintInOut')
		doTweenY('TweenhidscoreTxt', 'timeTxt', Hid_hud*(-1), time, 'quintInOut')
	end
end

function onUpdatePost ()
	if curStep == 1 then
	end
	if curStep == 0 then
		hid_hud (true,0)
	end
	if curStep == 155 then
		if downscroll then
			show_hud(1.8,0)
		else
			show_hud(1.8,560)
		end
	end
	if curStep == 1344 then
		hid_hud (false,2)
	end
	if curStep == 1488 then
		if downscroll then
			show_hud(1.2,20)
		else
			show_hud(1.2,560)
		end
	end
	if curStep >= 1485 then
		setProperty('iconP2.x', 250)
		setProperty('iconP1.x', 850)
	end
end