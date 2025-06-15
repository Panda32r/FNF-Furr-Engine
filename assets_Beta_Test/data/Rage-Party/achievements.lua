local Not_P = false 
local fat_cat = false

function onEndSong()
    unlockAchievement('song_completed')
    if fat_cat then unlockAchievement('song_completed_fat') end
    if difficultyName ~= 'Easy' then
    if fat_cat == true and misses == 1 then unlockAchievement('fc_fat') end
    if misses == 0 then unlockAchievement('fc') end
    if not Not_P then unlockAchievement('P') end
    end
end


function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if noteType == 'Nots_eat' then fat_cat = true end
    if ratingName == 'Meh' then Not_P = true end
end

function onUpdate(elapsed)
    if difficultyName ~= 'Easy' then
    if curStep == 816 then unlockAchievement('fc_part1') end
    if curStep == 816 then triggerEvent('Play Animation','sad','Dad') end
    if curStep == 832 then triggerEvent('Change Character', 'Dad', 'dog-sad') end
    else
    if curStep == 816 then triggerEvent('Play Animation','heh','Dad') end
    if curStep == 830 then triggerEvent('Change Character', 'Dad', 'dog-j') end
    if curStep == 1440 then triggerEvent('Change Character', 'Dad', 'dog-j-w') end
    if curStep == 1599 then triggerEvent('Change Character', 'Dad', 'dog-j') end
    end
end




