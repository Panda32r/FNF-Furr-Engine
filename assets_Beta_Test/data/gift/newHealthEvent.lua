local hpmines = 0.015
local hp = 1

function opponentNoteHit ( id, direction, noteType, isSustainNote)
	if getProperty('health') >= 0.2 then
		hp = hp - hpmines
    end
end

function onUpdate ()
	if getProperty('health') >= hp then
			setProperty('health', getProperty('health')  - 0.004)
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if hp < 2 then
  		hp = hp + hpmines
	else 
		hp = 2
	end

end