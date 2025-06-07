
var dancers = [];
function onCreate() {
    trace('Its stage for week 2!!');

    var bg = new Sprite(-200, -100);
    loadAnimImage(bg, 'stages/spooky/halloween_bg');
    bg.animation.addByPrefix('idle', 'halloweem bg lightning strike', 24, true);
    bg.antialiasing = true;
    bg.cameras = [camGame];
    add(bg);
}

function onBeatHit() {
}