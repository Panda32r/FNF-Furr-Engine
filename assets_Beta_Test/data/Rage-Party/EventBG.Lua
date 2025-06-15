arrowtrue=false
local curStep_fat=0

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'Nots_eat' then
        arrowtrue=true
        if curStep >= 1440 and curStep <= 1599 then
            triggerEvent('Change Character', 'BF', 'Fat_cat_white')
            doTweenColor('bfcolor', 'boyfriend', p1_colorHex, 0.01, 'linear')
        end
        triggerEvent('Play Animation','WTF','BF')
    end
end

function onCreate()
    makeLuaSprite('black screen', '', -1700, -1000)
    makeGraphic('black screen', 4000, 3000, '000000')
    setProperty('black screen.alpha', 0)
    addLuaSprite('black screen', true)
end

function onUpdate()
    if curStep >= 1343 and curStep <= 1439 then
        if getProperty('black screen.alpha') < 1 then
            setProperty('black screen.alpha', getProperty('black screen.alpha')+0.0015)
        end
    end
    if curStep == 1440 then
        p2_color = getProperty('dad.healthColorArray')
        p2_colorHex = rgbToHex(p2_color[1], p2_color[2], p2_color[3])
        if arrowtrue then
            triggerEvent('Change Character', 'BF', 'Fat_cat_white')
        else
            triggerEvent('Change Character', 'BF', 'Cat_white')
        end
        if difficultyName ~= 'Easy' then
        triggerEvent('Change Character', 'Dad', 'Panda_white')
        end
        doTweenColor('bfcolor', 'boyfriend', p1_colorHex, 0.01, 'linear')
        doTweenColor('dadcolor', 'dad', p2_colorHex, 0.01, 'linear')
        doTweenColor('gfcolor', 'gf', '#000000', 0.01, 'linear')
        --doTweenColor('Dogscolor', 'Dogs', '#000000', 0.01, 'linear')
        doTweenColor('Mishacolor', 'Misha', '#000000', 0.01, 'linear')
        doTweenColor('Bobuksancolor', 'Bobuksan', '#000000', 0.01, 'linear')
        doTweenColor('Checolor', 'Che', '#000000', 0.01, 'linear')
        doTweenColor('reno_mencolor', 'reno_men', '#000000', 0.01, 'linear')
        doTweenColor('renocolor', 'reno', '#000000', 0.01, 'linear')
        setProperty('white screen.alpha', 1)
        setProperty('Misha.alpha', 1)
        setProperty('Che.alpha', 1)
        setProperty('light.alpha', 0)
        setProperty('light1.alpha', 0)
        
    end
    if curStep >= 1472 and getProperty('black screen.alpha') > 0 then
        setProperty('black screen.alpha', getProperty('black screen.alpha')-0.0015)
    end

    if curStep == 1599 then
        if arrowtrue then
            triggerEvent('Change Character', 'BF', 'Fat_cat')
        else
            triggerEvent('Change Character', 'BF', 'Cat_test')
        end
        if difficultyName ~= 'Easy' then
        triggerEvent('Change Character', 'Dad', 'Panda')
        end
        addLuaSprite('white screen', true)
        doTweenColor('bfcolor', 'boyfriend', '#FFFFFF', 0.01, 'linear')
        doTweenColor('dadcolor', 'dad', '#FFFFFF', 0.01, 'linear')
        doTweenColor('gfcolor', 'gf', '#FFFFFF', 0.01, 'linear')
        --doTweenColor('Dogscolor', 'Dogs', '#FFFFFF', 0.01, 'linear')
        doTweenColor('Mishacolor', 'Misha', '#FFF', 0.01, 'linear')
        doTweenColor('Bobuksancolor', 'Bobuksan', '#FFF', 0.01, 'linear')
        doTweenColor('Checolor', 'Che', '#FFF', 0.01, 'linear')
        doTweenColor('reno_mencolor', 'reno_men', '#fff', 0.01, 'linear')
        doTweenColor('renocolor', 'reno', '#fff', 0.01, 'linear')
        setProperty('white screen.alpha', 0)
        setProperty('light.alpha', 0.3)
        setProperty('light1.alpha', 0.3)
    end
end

function rgbToHex(r, g, b)
    red = r
    green =  g
    blue = b
    if r > 255 then red = 255 elseif r < 0 then red = 0 end
    if g > 255 then green = 255 elseif g < 0 then green = 0 end
    if b > 255 then blue = 255 elseif b < 0 then blue = 0 end
    return string.format('%02x%02x%02x', 
    math.floor(red),
    math.floor(green),
    math.floor(blue))
end

function onCreatePost()
    p1_color = getProperty('boyfriend.healthColorArray')
    p1_colorHex = rgbToHex(p1_color[1], p1_color[2], p1_color[3])
    p2_color = getProperty('dad.healthColorArray')
    p2_colorHex = rgbToHex(p2_color[1], p2_color[2], p2_color[3])
end