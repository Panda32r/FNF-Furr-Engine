
var dancers = [];
function onCreate() {
    trace('Its stage for week 4!!');

    var bg = new Sprite(-120, -50);
    loadImage(bg, 'stages/limo/limoSunset.png');
    // bg.x -= 120;
    // bg.y -= 50;
    bg.antialiasing = true;
    bg.scrollFactor.set(0.1, 0.1);
    bg.cameras = [camGame];
    add(bg);

    var limoBg = new Sprite(-150, 550);
    loadAnimImage(limoBg, 'stages/limo/bgLimo');
    limoBg.animation.addByPrefix('idle', 'background limo pink', 24, true);
    limoBg.animation.play('idle');
    limoBg.scrollFactor.set(0.4, 0.4);
    // limoBg.x -= 150;
    // limeBg.y += 550;
    limoBg.antialiasing = true;
    limoBg.cameras = [camGame];
    add(limoBg);

    var limoDrive = new Sprite(-150, 550);
    loadAnimImage(limoDrive, 'stages/limo/limoDrive');
    limoDrive.animation.addByPrefix('idle', 'Limo stage', 24, true);
    limoDrive.animation.play('idle');
    limoDrive.cameras = [camGame];
    limoDrive.antialiasing = true;
    limoDrive.scrollFactor.set(1,1);
    // limoDrive.y += 550;
    // limoDrive.x -= 150;
    add(limoDrive);

    for(i in 0 ... 5)
    {
        var dancersSpr = new Sprite((370 * i) + 320 + limoBg.x, limoBg.y - 400);
        loadAnimImage(dancersSpr, 'stages/limo/limoDancer');
        dancersSpr.animation.addByIndices('leftDance', 'bg dancer sketch PINK', [0,1,2,3,4,5,6,7,8,9,10,11,12,13], '', 24, false);
        dancersSpr.animation.addByIndices('RightDance', 'bg dancer sketch PINK', [15,16,17,18,19,20,21,22,23,24,25,26,27,28], '', 24, false);
        dancersSpr.animation.addByIndices('idle', 'bg dancer sketch PINK', [13,14]);
        dancersSpr.animation.play('idle');
        dancersSpr.antialiasing = true;
        dancersSpr.cameras = [camGame];
        dancersSpr.scrollFactor.set(0.4, 0.4);
        add(dancersSpr);
        dancers.push(dancersSpr);
    }
}
var dance = false;
function onBeatHit() {
    for (dancersSpr in dancers)
    {
        if(dance)
        { 
            dancersSpr.animation.play('leftDance');
        }
        else
        {
            dancersSpr.animation.play('RightDance');
        }
    }
    dance = !dance;
}