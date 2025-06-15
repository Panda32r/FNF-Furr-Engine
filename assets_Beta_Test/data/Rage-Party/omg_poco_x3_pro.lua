local playerArrowScale = 0.4
local down_mowe = 0

function onCreate()
    if downscroll then down_mowe = 90 else down_mowe = -90 end
    for i = 0,3 do
            setPropertyFromGroup('opponentStrums', i, 'scale.x', 0.7)
            setPropertyFromGroup('opponentStrums', i, 'scale.y', 0.7)
            setPropertyFromGroup('playerStrums', i, 'scale.x', 0.7)
            setPropertyFromGroup('playerStrums', i, 'scale.y', 0.7)
    end 
end
function woof_idi_nah (gg,alha_blat)
     if gg then
        arrows_tweenXP1(420, 0.5)
        arrows_tweenYP2 (defaultPlayerStrumY0-down_mowe,0.5)
        arrows_tweenYP1 (defaultPlayerStrumY0,0.5)
        arrows_tweenXP2_ (420,0.5)
        for i = 0,3 do
            if  alha_blat then
                noteTweenAlpha("NoteAlpha"..i, i, 1, 0.01)
            else
                noteTweenAlpha("NoteAlpha"..i, i, 0.2, 0.01)
            end
            if  getPropertyFromGroup('opponentStrums', i, 'scale.x') < 0.69 then
                setPropertyFromGroup('opponentStrums', i, 'scale.x', getPropertyFromGroup('opponentStrums', i, 'scale.x')+0.05)
                setPropertyFromGroup('opponentStrums', i, 'scale.y', getPropertyFromGroup('opponentStrums', i, 'scale.y')+0.05)
            end
            if  getPropertyFromGroup('playerStrums', i, 'scale.x') >=playerArrowScale then
                setPropertyFromGroup('playerStrums', i, 'scale.x', getPropertyFromGroup('playerStrums', i, 'scale.x')-0.05)
                setPropertyFromGroup('playerStrums', i, 'scale.y', getPropertyFromGroup('playerStrums', i, 'scale.y')-0.05)
            end
        end
        for i = 4,7 do 
            if alha_blat then
                noteTweenAlpha("NoteAlpha"..i, i, 0.2, 0.01)  
            else 
                noteTweenAlpha("NoteAlpha"..i, i, 1, 0.01) 
            end 
        end
    else
        arrows_tweenXP1_(420, 0.5)
        arrows_tweenYP2 (defaultPlayerStrumY0,0.5)
        arrows_tweenYP1 (defaultPlayerStrumY0-down_mowe,0.5)
        arrows_tweenXP2 (420,0.5)
        for i = 0,3 do
            noteTweenAlpha("NoteAlpha"..i, i, 0.4, 0.01)
            if  getPropertyFromGroup('opponentStrums', i, 'scale.x') >=playerArrowScale then
                setPropertyFromGroup('opponentStrums', i, 'scale.x', getPropertyFromGroup('opponentStrums', i, 'scale.x')-0.05)
                setPropertyFromGroup('opponentStrums', i, 'scale.y', getPropertyFromGroup('opponentStrums', i, 'scale.y')-0.05)
            end
            if  getPropertyFromGroup('playerStrums', i, 'scale.x') < 0.69 then
                setPropertyFromGroup('playerStrums', i, 'scale.x', getPropertyFromGroup('playerStrums', i, 'scale.x') + 0.05)
                setPropertyFromGroup('playerStrums', i, 'scale.y', getPropertyFromGroup('playerStrums', i, 'scale.y') + 0.05)
            end
        end 
        for i = 4,7 do
            noteTweenAlpha("NoteAlpha"..i, i, 1, 0.01)
        end
    end
end


function onUpdate(elapsed)

    if difficultyName ~= 'Easy' then
        -- debugPrint(1)
        if curStep == 1600 then
            woof_idi_nah (true,true)
        end
        if curStep == 1662 then
            woof_idi_nah (false)
        end
        if curStep == 1728 then
            woof_idi_nah (true)
        end
        if curStep == 1792 then
            woof_idi_nah (false)
        end
        if curStep == 1856 then
            arrows_tweenYP2 (defaultPlayerStrumY0,0.5)
            arrows_tweenXP2 (420,0.5)
            arrows_tweenYP1 (defaultPlayerStrumY0,0.5)
            arrows_tweenXP1 (420,0.5)
            for i = 0,3 do
                if  getPropertyFromGroup('opponentStrums', i, 'scale.x') < 0.69 then
                    setPropertyFromGroup('opponentStrums', i, 'scale.x', getPropertyFromGroup('opponentStrums', i, 'scale.x')+0.05)
                    setPropertyFromGroup('opponentStrums', i, 'scale.y', getPropertyFromGroup('opponentStrums', i, 'scale.y')+0.05)
                end
            end
            for i = 0,3 do
                noteTweenAlpha("NoteAlpha"..i, i, 0.1, 0.01)
            end
        end
    end
end






















function arrows_tweenXP1 (X,time)
    noteTweenX("NoteMove0", 0, X, time, 'circInOut')
    noteTweenX("NoteMove1", 1, X+112, time, 'circInOut')
    noteTweenX("NoteMove2", 2, X+224, time, 'circInOut')
    noteTweenX("NoteMove3", 3, X+336, time, 'circInOut')
end


function arrows_tweenXP2 (X,time)
    noteTweenX("NoteMove4", 4, X, time, 'circInOut')
    noteTweenX("NoteMove5", 5, X+112, time, 'circInOut')
    noteTweenX("NoteMove6", 6, X+224, time, 'circInOut')
    noteTweenX("NoteMove7", 7, X+336, time, 'circInOut')
end

function arrows_tweenXP2_ (X,time)
    noteTweenX("NoteMove4x", 4, X+60, time, 'circInOut')
    noteTweenX("NoteMove5x", 5, X+132, time, 'circInOut')
    noteTweenX("NoteMove6x", 6, X+204, time, 'circInOut')
    noteTweenX("NoteMove7x", 7, X+276, time, 'circInOut')
end

function arrows_tweenXP1_ (X,time)
    noteTweenX("NoteMove0x", 0, X+60, time, 'circInOut')
    noteTweenX("NoteMove1x", 1, X+132, time, 'circInOut')
    noteTweenX("NoteMove2x", 2, X+204, time, 'circInOut')
    noteTweenX("NoteMove3x", 3, X+276, time, 'circInOut')
end

function arrows_tweenYP1 (Y,time)
    noteTweenY("NoteMove0y", 0, Y, time, 'circInOut')
    noteTweenY("NoteMove1y", 1, Y, time, 'circInOut')
    noteTweenY("NoteMove2y", 2, Y, time, 'circInOut')
    noteTweenY("NoteMove3y", 3, Y, time, 'circInOut')
end

function arrows_tweenYP2 (Y,time)
    noteTweenY("NoteMove4y", 4, Y, time, 'circInOut')
    noteTweenY("NoteMove5y", 5, Y, time, 'circInOut')
    noteTweenY("NoteMove6y", 6, Y, time, 'circInOut')
    noteTweenY("NoteMove7y", 7, Y, time, 'circInOut')
end