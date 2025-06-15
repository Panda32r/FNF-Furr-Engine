local colp=200

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
    -- for i = 0, colp do
    --         spawnParticl(i,'bite')
    --         spawnParticl(i,'notbite')
    -- end
end

function onUpdate()
    if  not lowQuality then
        if curStep == 1 then
            -- runTimer('Particl_Pizdez', 5, 0) 
            runTimer('particl_Pizdez', 15, 0)
            for i = 0, colp do
                particles(i,p2_colorHex)
            end
        end
        if curStep == 1440 then
            p2_color = getProperty('dad.healthColorArray')
            p2_colorHex = rgbToHex(p2_color[1], p2_color[2], p2_color[3])
        end
    end
end 

function onTimerCompleted(tag)
    if tag == 'particl_Pizdez' then
        if curStep <= 2112 then
            for i = 0, colp do
                particles(i,p2_colorHex)
            end
        end
    end 

    if tag == 'bop' then
        if curStep >= 432 and curStep <=682 then
            for i = 0, colp do
                particlesBite(i,p1_colorHex)
            end
        end
    end
    if tag == 'bop' then
        if curStep >= 1088 and curStep <= 1344  then
            for i = 0, colp do
                particlesBite(i,p1_colorHex)
            end
        end
    end
    if tag == 'bop' then
        if curStep >= 1600 and curStep <= 2112 then
            for i = 0, colp do
                particlesBite(i,p1_colorHex)
            end
        end
    end
end

function particles(i,color)
    g=math.random(0.6, 1)
    if g >0.9 then c = math.random(15,25) else c = math.random(8,13) end
    j=string.format('particl%02x',i)
    -- spawnParticl(i,'notbite')
    setProperty(string.format('particl%02x.x',i), math.random(-300,2000))
    setProperty(string.format('particl%02x.y',i), math.random(800,700))
    doTweenColor(string.format('colorp%02x',i),j,color,0.01,'linear')
    scaleObject(j, g, g)
    doTweenY(string.format('tweenpy%02x',i), j, -300, c, 'quadOut')
    doTweenX(string.format('tweenpx%02x',i), j, getProperty(string.format('particl%02x.x',i))+math.random(-300,300), c, 'quadOut')
    doTweenAlpha(string.format('tweenpA%02x',i), j, 0, c-5, 'linear')
    -- debugPrint(getProperty(string.format('particl%02x.x',i))) 
end

function particlesBite(i,color)
    g=math.random(0.6, 0.7)
    c = math.random(2,4) 
    j=string.format('particlBite%02x',i)
    -- spawnParticl(i,'bite')
    setProperty(string.format('particlBite%02x.x',i), math.random(-300,2000))
    setProperty(string.format('particlBite%02x.y',i), math.random(800,700))
    doTweenColor(string.format('colorpBite%02x',i),j,color,0.01,'linear')
    scaleObject(j, g, g)
    doTweenY(string.format('tweenpyBite%02x',i), j, -300, c, 'quadOut')
    doTweenX(string.format('tweenpxBite%02x',i), j, getProperty(string.format('particlBite%02x.x',i))+math.random(-300,300), c, 'quadOut')
    doTweenAlpha(string.format('tweenpABite%02x',i), j, 0, 0.5, 'linear')
    -- debugPrint(getProperty(string.format('particlBite%02x.x',i)), '#ff0000') 
end

function spawnParticl(i,sped)
    if sped == 'bite' then
        jb=string.format('particlBite%02x',i)
        makeLuaSprite( jb,  
                        'particle',
                        math.random(-300,2000),
                        math.random(800,700)
                     )
        addLuaSprite(jb, true)
    else
        j=string.format('particl%02x',i)
        makeLuaSprite( j,  
                        'particle',
                        math.random(-300,2000),
                        math.random(800,700)
                     ) 
        addLuaSprite(j, false)
    end
end