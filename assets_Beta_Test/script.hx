var white = null;
var whiteHUD = null;
var black1 = null;
var black2 = null;
function onCreate() {
    if(curSong == 'Sirokou')
    { 
    white = new Sprite();
    white.makeGraphic (1280, 720,Color('#FFFFFF'));
    white.x = 0;
    white.y = 0;
    white.alpha = 0;
    white.cameras = [camHUD];
    add(white);
    }
    if(curSong == 'You Cant Run (Pico Mix)')
    { 
    whiteHUD = new Sprite();
    whiteHUD.makeGraphic (1280, 720,Color('#FFFFFF'));
    whiteHUD.x = 0;
    whiteHUD.y = 0;
    whiteHUD.alpha = 0;
    whiteHUD.cameras = [camHUD];
    add(whiteHUD);

    white = new Sprite();
    white.makeGraphic (3000, 3000,Color('#FFFFFF'));
    white.x = -1000;
    white.y = -1000;
    white.alpha = 1;
    white.cameras = [camGame];
    add(white);

    black1 = new Sprite();
    black1.makeGraphic (1280, 400,Color('#000000'));
    black1.x = 0;
    black1.y = -300;
    black1.alpha = 1;
    black1.cameras = [camHUD];
    add(black1);

    black2 = new Sprite();
    black2.makeGraphic (1280, 400,Color('#000000'));
    black2.x = 0;
    black2.y = 600;
    black2.alpha = 1;
    black2.cameras = [camHUD];
    add(black2);
    }
}

function onCreatePost() {
    trace(curSong);
    if(curSong == 'You Cant Run (Pico Mix)')
    { 
        Dad.color = Color('#000000');
        Gf.color = Color('#000000');
        Bf.color = Color('#000000');
    }

    for( i in 0 ... unspawnNotes.length)
    {
        if (Dad.name == 'dog' || Dad.name == 'Panda')
        {
            if(!unspawnNotes[i].mustPress)
                unspawnNotes[i].textyre = 'NOTE_assets_Lycur';
        }
        if(unspawnNotes[i].noteType == 'Nots_eat' || unspawnNotes[i].noteType == 'Nots_eat_test-meh')
        {
            unspawnNotes[i].textyre = 'NOTE_eat';
            unspawnNotes[i].ignoreNote = true;
        }
            unspawnNotes[i].reloadNote();

    }
}

var hudBlack = false;
function onStepHit() {
    if(curSong == 'Sirokou')
    {    
        if(curStep == 495)
            white.alpha = 1;
        if(curStep == 799)
            white.alpha = 1;
        if(curStep == 1839)
            white.alpha = 1;
        if(curStep == 2079)
            white.alpha = 1;
        if(curStep == 2351)
            white.alpha = 1;
        
    }
    if(curSong == 'You Cant Run (Pico Mix)')
    {    
        if(curStep == 31)
        {
            hudBlack = true;
            whiteHUD.alpha = 1;
            white.alpha = 0;
            Dad.color = Color('#FFFFFF');
            Gf.color = Color('#FFFFFF');
            Bf.color = Color('#FFFFFF');
        }
        if(curStep == 79)
        {
            whiteHUD.alpha = 1;
        }
        if(curStep == 95)
        {
            defaultCamZoom = 0.95;
        }
        if(curStep == 279)
        {
            defaultCamZoom = 1.1;
        }
        if(curStep == 287)
        {
            defaultCamZoom = 0.95;
        }
        if(curStep == 479)
        {
            hudBlack = false;
            Gf.visible = false;
            whiteHUD.alpha = 1;
        }
        if(curStep == 607)
        {
            whiteHUD.alpha = 1;
        }
        if(curStep == 735)
        {
            hudBlack = true;
            Gf.visible = true;
            whiteHUD.alpha = 1;
        }
        if(curStep == 863)
        {
            whiteHUD.alpha = 1;
        }
    }
}

function onUpdatePost(elapsed) {
}

function onUpdate(elapsed) {
    if(curSong == 'Sirokou')
    { 
        if (white.alpha > 0)
            white.alpha = lerp(0, white.alpha, exp(-elapsed * 2 ));
    }
    if(curSong == 'You Cant Run (Pico Mix)')
    { 
        if (whiteHUD.alpha > 0)
            whiteHUD.alpha = lerp(0, whiteHUD.alpha, exp(-elapsed * 1 ));
        if(hudBlack)
        {
            // black2.y = 650;
            // black1.y = -350;
            if (black2.y != 650)
                black2.y = lerp(650, black2.y, exp(-elapsed * 9 ));
            if (black1.y != -350)
                black1.y = lerp(-350, black1.y, exp(-elapsed * 9 ));
        }
        else
        {
            // black2.y = 650;
            // black1.y = -350;
            if (black2.y != 600)
                black2.y = lerp(600, black2.y, exp(-elapsed * 9 ));
            if (black1.y != -300)
                black1.y = lerp(-300, black1.y, exp(-elapsed * 9 ));
        }
    }
    // trace(elapsed);
}

function onBeatHit() {
    if(curSong == 'Sirokou')
    {   
        if (curStep > 798)
            if (curStep < 1838)
                {
                    Gf.animation.stop();
                    Gf.playAnim('scared');
                }
        if (curStep > 2350)
        {
            Gf.animation.stop();
            Gf.playAnim('scared');
        }
    }
}