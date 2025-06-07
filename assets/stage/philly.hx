
// var dancers = [];
var city;
var phillyStreet;
// var phillyLightsColors = ['#FF31A2', '#FF31FD', '#FFFB33', '#FFFD45', '#FFFBA6'];
var phillyLightsColors = [0xFF31A2FD, 0xFF31FD8C, 0xFFFB33F5, 0xFFFD4531, 0xFFFBA633];
var phillyLights;
var curLight = -1;
// Color('#FFFFFF');
function onCreate() {
    trace('Its stage for week 3!!');

    var bg = new Sprite(-100, 0);
    loadImage(bg, 'stages/philly/sky.png');
    bg.antialiasing = true;
    bg.cameras = [camGame];
    bg.scrollFactor.set(0.1, 0.1);
    add(bg);

    city = new Sprite(-10, 0);
    loadImage(city, 'stages/philly/city.png');
    // city.setGraphicSize(Std.int(city.width * 0.85));
    city.cameras = [camGame];
    city.scrollFactor.set(0.3, 0.3);
    city.antialiasing = true;
    city.updateHitbox();
	add(city);

    phillyLights = new Sprite(city.x, city.y);
    loadImage(phillyLights, 'stages/philly/window.png');
    phillyLights.cameras = [camGame];
    phillyLights.scrollFactor.set(0.3, 0.3);
    phillyLights.antialiasing = true;
    phillyLights.updateHitbox();
    phillyLights.alpha = 0;
    add(phillyLights);

    var streetBehind = new Sprite(-40, 50);
    loadImage(streetBehind, 'stages/philly/behindTrain.png');
    streetBehind.antialiasing = true;
    streetBehind.cameras = [camGame];
	add(streetBehind);

    phillyStreet = new Sprite(-40, 50);
    loadImage(phillyStreet, 'stages/philly/street.png');
    phillyStreet.antialiasing = true;
    phillyStreet.cameras = [camGame];
	add(phillyStreet);

}

function onBeatHit() {
    if (curBeat % 4 == 0)
    {
        if(curLight < phillyLightsColors.length - 1)
            curLight += 1;
        else
            curLight = 0;
        phillyLights.color = phillyLightsColors[curLight];
		phillyLights.alpha = 1;
    }
}

function onUpdate(elapsed) {
    if (phillyLights.alpha > 0)
        phillyLights.alpha = lerp(0, phillyLights.alpha, exp(-elapsed * 1.5 ));
    else
        phillyLights.alpha = 0;
}