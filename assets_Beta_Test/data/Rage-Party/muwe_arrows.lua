

function onTimerCompleted(tag)
    if tag == 'arrows_tween21' then
        cancelTween("NoteMove4_1")
        cancelTween("NoteMove5_1")
        arrows_tweenYP21(defaultPlayerStrumY0+30, 0.02)
        noteTweenY("NoteMove4_1", 4, defaultPlayerStrumY0, 0.4, 'linear')
        noteTweenY("NoteMove5_1", 5, defaultPlayerStrumY0, 0.4, 'linear')
    end
    if tag == 'arrows_tween22' then
        cancelTween("NoteMove4_2")
        cancelTween("NoteMove5_2")
        arrows_tweenYP22(defaultPlayerStrumY0+30, 0.02)
        noteTweenY("NoteMove4_2", 6, defaultPlayerStrumY0, 0.4, 'linear')
        noteTweenY("NoteMove5_2", 7, defaultPlayerStrumY0, 0.4, 'linear')
    end
    if tag == 'arrows_tween12' then
        cancelTween("NoteMove2_2")
        cancelTween("NoteMove3_2")
        arrows_tweenYP12(defaultPlayerStrumY0+30, 0.02)
        noteTweenY("NoteMove2_2", 2, defaultPlayerStrumY0, 0.4, 'linear')
        noteTweenY("NoteMove3_2", 3, defaultPlayerStrumY0, 0.4, 'linear')
    end
    if tag == 'arrows_tween11' then
        cancelTween("NoteMove0_1")
        cancelTween("NoteMove1_1")
        arrows_tweenYP11(defaultPlayerStrumY0+30, 0.02)
        noteTweenY("NoteMove0_1", 0, defaultPlayerStrumY0, 0.4, 'linear')
        noteTweenY("NoteMove1_1", 1, defaultPlayerStrumY0, 0.4, 'linear')
    end
end
function onUpdate()
        if curBeat %2 == 1 then
            if curStep <= 1344 then
                if curStep >=432 and curStep <=688 then
                    runTimer('arrows_tween21', 0.05, 1)
                end
                if curStep >=960 then
                    runTimer('arrows_tween21', 0.05, 1)
                end
                if curStep <=688 then
                    runTimer('arrows_tween12', 0.05, 1)
                end
                if curStep >=832 then
                    runTimer('arrows_tween12', 0.05, 1)
                end
            end
            if curStep >= 1920 and curStep <= 2112 then
                runTimer('arrows_tween21', 0.05, 1)
                runTimer('arrows_tween12', 0.05, 1)
            end
        end
        if curBeat %2 == 0 then
             if curStep <= 1344 then
                if curStep >=432 and curStep <=688 then
                    runTimer('arrows_tween22', 0.05, 1)
                end
                if curStep >=960 then
                    runTimer('arrows_tween22', 0.05, 1)
                end
                if curStep <=688 then
                    runTimer('arrows_tween11', 0.05, 1)
                end
                if curStep >=832 then
                    runTimer('arrows_tween11', 0.05, 1)
                end
            end
            if curStep >= 1920 and curStep <= 2112 then
                runTimer('arrows_tween22', 0.05, 1)
                runTimer('arrows_tween11', 0.05, 1)
            end
        end
end
function arrows_tweenYP21 (Y,time)
        noteTweenY("NoteMove4y", 4, Y, time, 'circInOut')
        noteTweenY("NoteMove5y", 5, Y, time, 'circInOut')

end

function arrows_tweenYP22 (Y,time)

        noteTweenY("NoteMove6y", 6, Y, time, 'circInOut')
        noteTweenY("NoteMove7y", 7, Y, time, 'circInOut')
end

function arrows_tweenYP11 (Y,time)
        noteTweenY("NoteMove0y", 0, Y, time, 'circInOut')
        noteTweenY("NoteMove1y", 1, Y, time, 'circInOut')

end

function arrows_tweenYP12 (Y,time)

        noteTweenY("NoteMove2y", 2, Y, time, 'circInOut')
        noteTweenY("NoteMove3y", 3, Y, time, 'circInOut')
end

