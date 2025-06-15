local Zoom = false

function onBeatHit()
    if curBeat >= 40 then
        Tween_Hud_down(5,0.2)
        Hud_angle(1,0.5)
    end
    
    if curBeat >= 108 then
        Tween_Hud_down(10,0.2)
        Hud_angle(4,0.5)
        Hud_Zoom(true) 
    end
    
    if curBeat >= 171 then
        Tween_Hud_down(0,0.2)
        Hud_angle(0,0.5)
        Hud_Zoom(false)
    end

    if curBeat >= 208 then
        Tween_Hud_down(10,0.2)
        Hud_angle(2,0.5)   
    end

    if curBeat >= 272 then
        Tween_Hud_down(25,0.2)
        Hud_angle(4,0.5)
        Hud_Zoom(true)  
    end

    if curBeat >= 336 then
        Tween_Hud_down(5,0.2)
        Hud_angle(0,0.5)
        Hud_Zoom(false)       
    end

    if curBeat >= 399 then
        Tween_Hud_down(20,0.2)
        Hud_angle(2,0.5)
        Hud_Zoom(true)
    end

    if curBeat >= 528 then
        Tween_Hud_down(0,0.2)
        Hud_angle(0,0.5)
        Hud_Zoom(false)
        
    end
end

function onTimerCompleted(tag)
    if tag == 'bop' then
        doTweenY('tuin', 'camHUD', -5, 0.2,'circOut');
    end 
    if curBeat >= 108 then
        if tag == 'bop' then
            doTweenY('tuin', 'camHUD', -10, 0.5,'circOut');
        end
    end
    if curBeat >= 171 then
        if tag == 'bop' then
            doTweenY('tuin', 'camHUD', 0, 0.5,'circOut');
        end
    end
    if curBeat >= 208 then
        if tag == 'bop' then
            doTweenY('tuin', 'camHUD', -10, 0.5,'circOut');
        end
    end
    if curBeat >= 272 then
        if tag == 'bop' then
            doTweenY('tuin', 'camHUD', -25, 0.5,'circOut');
        end
    end
    if curBeat >= 336 then
        if tag == 'bop' then
            doTweenY('tuin', 'camHUD', -5, 0.5,'circOut');
        end
    end
    if curBeat >= 399 then
        if tag == 'bop' then
            doTweenY('tuin', 'camHUD', -20, 0.5,'circOut');
        end
    end
    if curBeat >= 528 then
        if tag == 'bop' then
            doTweenY('tuin', 'camHUD', 0, 0.5,'circOut');
        end
    end
end

function Hud_angle(angle,time)
    if curBeat %2 == 1 then
        setProperty('camHUD.angle', angle)
        doTweenAngle('camturn1', 'camHUD', 0, time, 'circOut')
    end
    if curBeat %2 == 0 then
        setProperty('camHUD.angle', angle*(-1))
        doTweenAngle('camturn1', 'camHUD', 0, time, 'circOut')
    end
end
function Hud_Zoom(Zoom)
    if Zoom then
        if curBeat %2 == 1 then 
                doTweenZoom('screenHUDZoom', 'camHUD', 0.95, 0.05);
                doTweenZoom('screenZoom', 'camGame', getProperty("defaultCamZoom")+0.05, 0.05, 'circInOut');
        end
        if curBeat %2 == 0 then 
                doTweenZoom('screenHUDZoom', 'camHUD', 1.1, 0.05);
                doTweenZoom('screenZoom', 'camGame', getProperty("defaultCamZoom")+0.05, 0.05, 'circInOut');
        end
    else
        if curBeat %2 == 1 then 
                doTweenZoom('screenHUDZoom', 'camHUD', 1, 0.05);
                doTweenZoom('screenZoom', 'camGame', getProperty("defaultCamZoom"), 0.05, 'circInOut');
        end
        if curBeat %2 == 0 then 
                doTweenZoom('screenHUDZoom', 'camHUD', 1, 0.05);
                doTweenZoom('screenZoom', 'camGame', getProperty("defaultCamZoom"), 0.05, 'circInOut');
        end
    end
end
function Tween_Hud_down (tween,time)
    doTweenY('tuin', 'camHUD', tween, time,'circOut');
    runTimer('bop', 0.1, 1)
end
