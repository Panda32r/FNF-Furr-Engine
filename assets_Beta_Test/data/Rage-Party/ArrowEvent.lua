local playerArrowScale = 0.4

function onUpdatePost()

        if curStep == 0 then 
                arrows_tweenXP1 (2000,0.01)
                arrows_tweenXP2 (2000,0.01)   
        end

        if curStep == 136 then
               arrows_tweenXP1 (420,1)
               note_angle(1080,1)
        end

        if curStep == 218 then
                arrows_tweenXP1 (92,0.5)
                arrows_tweenXP2 (732,0.5)
                note_angle(1080,1)
        end
        if difficultyName ~= 'Easy' then
                if curStep == 432 then
                        arrows_tweenXP1 (420,0.5)
                        arrows_tweenXP2 (420,0.5)
                        arrows_tween_alphaP2 (1,0.5)
                        arrows_tween_alphaP1 (1,0.5)
                end

                if curStep == 496 then
                        arrows_tween_alphaP2 (1,0.1)
                        arrows_tween_alphaP1 (0.5,0.1)
                end

                if curStep == 560 then
                        arrows_tween_alphaP2 (1,0.1)
                        arrows_tween_alphaP1 (1,0.1)
                end

                if curStep == 624 then
                        arrows_tween_alphaP2 (1,0.1)
                        arrows_tween_alphaP1 (0.5,0.1)
                end

                if curStep == 624 then
                        arrows_tween_alphaP2 (1,0.1)
                        arrows_tween_alphaP1 (0,0.1)
                end

                if curStep == 752 then
                        arrows_tween_alphaP1 (0.2,0.1)
                end

                if curStep == 816 then
                        arrows_tweenXP1 (92,1)
                        arrows_tweenXP2 (732,1)
                        arrows_tween_alphaP2 (1,0.1)
                        arrows_tween_alphaP1 (1,0.1)
                end

                if curStep == 1088 then
                        arrows_tweenXP1 (420,0.5)
                        arrows_tweenXP2 (420,0.5)
                        arrows_tween_alphaP2 (1,0.5)
                        arrows_tween_alphaP1 (1,0.5)
                end

                if curStep == 1152 then
                        arrows_tween_alphaP2 (1,0.1)
                        arrows_tween_alphaP1 (0.2,0.1)
                end

                if curStep == 1216 then
                        arrows_tween_alphaP2 (1,0.1)
                        arrows_tween_alphaP1 (1,0.1)
                end

                if curStep == 1280 then
                        arrows_tween_alphaP2 (1,0.1)
                        arrows_tween_alphaP1 (0.2,0.1)
                end
        end
        
        if curStep == 1366 then
                arrows_tweenYP1 (800,1.5)
                arrows_tweenYP2 (800,1.5)
                arrows_tween_alphaP2 (1,0.1)
                arrows_tween_alphaP1 (1,0.1)

        end

        if curStep == 1416 then
                arrows_tweenXP1 (92,0.01)
                arrows_tweenXP2 (732,0.01)
        end

        if curStep == 1464 then
                if downscroll then
                        arrows_tweenYP1 (570,0.5)
                else
                        arrows_tweenYP1 (50,0.5)
                end
        end

        if curStep == 1480 then
                if downscroll then
                        arrows_tweenYP2 (570,0.5)
                else
                        arrows_tweenYP2 (50,0.5)
                end
        end
        if difficultyName ~= 'Easy' then
                if curStep == 1920 then 
                        arrows_right (0.5)
                        arrows_tween_alphaP1(1,0.5)
                end
                if curStep == 1984 then 
                        arrows_left (0.5)
                end
                if curStep == 2048 then 
                        arrows_right (0.5)
                end
        end
end

function arrows_left (time)
        noteTweenX("NoteMove0", 0, 732, time, 'circInOut')
        noteTweenX("NoteMove1", 1, 844, time, 'circInOut')
        noteTweenX("NoteMove2", 2, 956, time, 'circInOut')
        noteTweenX("NoteMove3", 3, 1068, time, 'circInOut')



        noteTweenX("NoteMove4", 4, 92, time, 'circInOut')
        noteTweenX("NoteMove5", 5, 204, time, 'circInOut')
        noteTweenX("NoteMove6", 6, 316, time, 'circInOut')
        noteTweenX("NoteMove7", 7, 428, time, 'circInOut')
end

function arrows_right (time)
        noteTweenX("NoteMove4", 4, 732, time, 'circInOut')
        noteTweenX("NoteMove5", 5, 844, time, 'circInOut')
        noteTweenX("NoteMove6", 6, 956, time, 'circInOut')
        noteTweenX("NoteMove7", 7, 1068, time, 'circInOut')



        noteTweenX("NoteMove0", 0, 92, time, 'circInOut')
        noteTweenX("NoteMove1", 1, 204, time, 'circInOut')
        noteTweenX("NoteMove2", 2, 316, time, 'circInOut')
        noteTweenX("NoteMove3", 3, 428, time, 'circInOut')
end

function arrows_middle (time)
        noteTweenX("NoteMove4", 4, 420, time, 'circInOut')
        noteTweenX("NoteMove5", 5, 532, time, 'circInOut')
        noteTweenX("NoteMove6", 6, 644, time, 'circInOut')
        noteTweenX("NoteMove7", 7, 756, time, 'circInOut')



        noteTweenX("NoteMove0", 0, 92, time, 'circInOut')
        noteTweenX("NoteMove1", 1, 204, time, 'circInOut')
        noteTweenX("NoteMove2", 2, 956, time, 'circInOut')
        noteTweenX("NoteMove3", 3, 1068, time, 'circInOut')
end

function note_angle(angle,time)
        noteTweenAngle('playrotate0', 4, angle, time, 'circInOut')
        noteTweenAngle('playrotate1', 5, angle, time, 'circInOut')
        noteTweenAngle('playrotate2', 6, angle, time, 'circInOut')
        noteTweenAngle('playrotate3', 7, angle, time, 'circInOut')
                
        noteTweenAngle('playrotate4', 0, angle, time, 'circInOut')
        noteTweenAngle('playrotate5', 1, angle, time, 'circInOut')
        noteTweenAngle('playrotate6', 2, angle, time, 'circInOut')
        noteTweenAngle('playrotate7', 3, angle, time, 'circInOut')
end

function arrows_tweenXP1 (X,time)
        noteTweenX("NoteMove0", 0, X, time, 'circInOut')
        noteTweenX("NoteMove1", 1, X+112, time, 'circInOut')
        noteTweenX("NoteMove2", 2, X+224, time, 'circInOut')
        noteTweenX("NoteMove3", 3, X+336, time, 'circInOut')
end

function arrows_tweenXP1_ (X,time)
        noteTweenX("NoteMove0", 0, X, time, 'circInOut')
        noteTweenX("NoteMove1", 1, X, time, 'circInOut')
        noteTweenX("NoteMove2", 2, X, time, 'circInOut')
        noteTweenX("NoteMove3", 3, X, time, 'circInOut')
end

function arrows_tweenXP2 (X,time)
        noteTweenX("NoteMove4", 4, X, time, 'circInOut')
        noteTweenX("NoteMove5", 5, X+112, time, 'circInOut')
        noteTweenX("NoteMove6", 6, X+224, time, 'circInOut')
        noteTweenX("NoteMove7", 7, X+336, time, 'circInOut')
end

function arrows_tweenYP1 (Y,time)
        noteTweenY("NoteMove0", 0, Y, time, 'circInOut')
        noteTweenY("NoteMove1", 1, Y, time, 'circInOut')
        noteTweenY("NoteMove2", 2, Y, time, 'circInOut')
        noteTweenY("NoteMove3", 3, Y, time, 'circInOut')
end

function arrows_tweenYP2 (Y,time)
        noteTweenY("NoteMove4", 4, Y, time, 'circInOut')
        noteTweenY("NoteMove5", 5, Y, time, 'circInOut')
        noteTweenY("NoteMove6", 6, Y, time, 'circInOut')
        noteTweenY("NoteMove7", 7, Y, time, 'circInOut')
end
function arrows_tween_alphaP2 (Alpha,time)
        noteTweenAlpha("NoteAlpha4", 4, Alpha, time)
        noteTweenAlpha("NoteAlpha5", 5, Alpha, time)
        noteTweenAlpha("NoteAlpha6", 6, Alpha, time)
        noteTweenAlpha("NoteAlpha7", 7, Alpha, time)
        setProperty('holdCoverBlue.alpha',Alpha)
        setProperty('holdCoverPurple.alpha',Alpha)
        setProperty('holdCoverGreen.alpha',Alpha)
        setProperty('holdCoverRed.alpha',Alpha)
end

function arrows_tween_alphaP1 (Alpha,time)
        noteTweenAlpha("NoteAlpha0", 0, Alpha, time)
        noteTweenAlpha("NoteAlpha1", 1, Alpha, time)
        noteTweenAlpha("NoteAlpha2", 2, Alpha, time)
        noteTweenAlpha("NoteAlpha3", 3, Alpha, time)
        setProperty('holdCoverBlue_op.alpha',Alpha)
        setProperty('holdCoverPurple_op.alpha',Alpha)
        setProperty('holdCoverGreen_op.alpha',Alpha)
        setProperty('holdCoverRed_op.alpha',Alpha)
end

function arrows_down()
        setPropertyFromClass('ClientPrefs', 'downScroll', true);
end

function arrows_up()
        setPropertyFromClass('ClientPrefs', 'downScroll', false);
end

function onCreatePost()
        for i = 0, getProperty('opponentStrums.length')-1 do
                setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_assets_Lycur');
        end
        for i = 0, getProperty('unspawnNotes.length')-1 do
                if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
                        setPropertyFromGroup('unspawnNotes', i, 'texture','NOTE_assets_Lycur');
                end      
                if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'bf_note' then
                        setPropertyFromGroup('unspawnNotes', i, 'scale.x', playerArrowScale)
                        setPropertyFromGroup('unspawnNotes', i, 'scale.y', playerArrowScale)
                end
        end
end


function onUpdate(elapsed)
        if difficultyName ~= 'Easy' then
                if curStep == 1440 then
                        for i = 0, getProperty('unspawnNotes.length')-1 do
                                if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
                                        setPropertyFromGroup('unspawnNotes', i, 'texture','NOTE_assets_Panda');
                                end      
                                if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'bf_note' then
                                        setPropertyFromGroup('unspawnNotes', i, 'scale.x', playerArrowScale)
                                        setPropertyFromGroup('unspawnNotes', i, 'scale.y', playerArrowScale)
                                end
                        end  
                end
        end
end