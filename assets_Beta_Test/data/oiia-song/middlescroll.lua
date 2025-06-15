
function onUpdate()
	if getPropertyFromClass('ClientPrefs', 'middleScroll') and not
	getPropertyFromClass('PlayState', 'isPixelStage') and not inGameOver then
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'x', 30 + (90 * (i % 4)));
			setPropertyFromGroup('strumLineNotes', i, 'scale.x', 0.6);
			setPropertyFromGroup('strumLineNotes', i, 'scale.y', 0.6);
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.35); -- 0.35 default
		end
	elseif getPropertyFromClass('ClientPrefs', 'middleScroll') and 
	getPropertyFromClass('PlayState', 'isPixelStage') and not inGameOver then
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'x', 30 + (90 * (i % 4)));
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.35); -- 0.35 default
		end
	end
end