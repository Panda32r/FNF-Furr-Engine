package states;

class ResultState extends MusicBeatState
{
    public static var hits:Int = 100;
    public static var Sick:Int = 99;
    public static var Good:Int = 129;
    public static var Bad:Int = 10;
    public static var Shit:Int = 1;
    public static var Score:Int = 100000;
    public static var ratingPercent:Float = 0.0;
    public static var rating:FlxText;
    public static var ratingText:Array<String> = ['P', 'S' , 'G', 'B'];
    public static var ratingComboText:Array<String> = ['PFC', 'SFC' , 'GFC', 'FC', 'SDCB', 'Clear'];

    public var camGame:FlxCamera;
	public var camHUD:FlxCamera;

    var HitTxt:FlxText;
    var curSickTxt:FlxText;
    var curGoodTxt:FlxText;
    var curBadTxt:FlxText;
    var curShitTxt:FlxText;
    var curScoreTxt:FlxText;

    override public function create():Void
    {
        super.create();
        camGame = new FlxCamera();
		camGame.bgColor = FlxColor.fromString('#FFD863');
		FlxG.cameras.reset(camGame);
		camGame.zoom = 0.5;

		camHUD = new FlxCamera();
        camHUD.bgColor = FlxColor.TRANSPARENT; 
        camHUD.width = FlxG.width;
        camHUD.height = FlxG.height;
        camHUD.x = 0;
        camHUD.y = 0;
        FlxG.cameras.add(camHUD);

        HitTxt = new FlxText(120, 100);
		HitTxt.setFormat('assets/fonts/Menu_Font.ttf', 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        HitTxt.scrollFactor.set();
        HitTxt.borderSize = 2.25;
        HitTxt.text = 'Hit 000';
		HitTxt.borderSize = 1.25;
		HitTxt.cameras = [camHUD];
        add(HitTxt);

        curSickTxt = new FlxText(120, 200);
		curSickTxt.setFormat('assets/fonts/Menu_Font.ttf', 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        curSickTxt.scrollFactor.set();
        curSickTxt.borderSize = 2.25;
        curSickTxt.text = 'Sick 000';
		curSickTxt.borderSize = 1.25;
		curSickTxt.cameras = [camHUD];
        add(curSickTxt);

        curGoodTxt = new FlxText(120, 300);
		curGoodTxt.setFormat('assets/fonts/Menu_Font.ttf', 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        curGoodTxt.scrollFactor.set();
        curGoodTxt.borderSize = 2.25;
        curGoodTxt.text = 'Good 000';
		curGoodTxt.borderSize = 1.25;
		curGoodTxt.cameras = [camHUD];
        add(curGoodTxt);

        curBadTxt = new FlxText(120, 400);
		curBadTxt.setFormat('assets/fonts/Menu_Font.ttf', 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        curBadTxt.scrollFactor.set();
        curBadTxt.borderSize = 2.25;
        curBadTxt.text = 'Bad 000';
		curBadTxt.borderSize = 1.25;
		curBadTxt.cameras = [camHUD];
        add(curBadTxt);

        curShitTxt = new FlxText(120, 500);
		curShitTxt.setFormat('assets/fonts/Menu_Font.ttf', 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        curShitTxt.scrollFactor.set();
        curShitTxt.borderSize = 2.25;
        curShitTxt.text = 'Shit 000';
		curShitTxt.borderSize = 1.25;
		curShitTxt.cameras = [camHUD];
        add(curShitTxt);

        curScoreTxt = new FlxText(120, 600);
		curScoreTxt.setFormat('assets/fonts/Menu_Font.ttf', 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        curScoreTxt.scrollFactor.set();
        curScoreTxt.borderSize = 2.25;
        curScoreTxt.text = 'Score 000';
		curScoreTxt.borderSize = 1.25;
		curScoreTxt.cameras = [camHUD];
        add(curScoreTxt);

        curShitTxt.antialiasing = true;
        curBadTxt.antialiasing = true;
        curGoodTxt.antialiasing = true;
        curSickTxt.antialiasing = true;
        HitTxt.antialiasing = true;

    }

    var pressEnter:Bool = false;
    var shot:Float = 0;
    var fullHit:Bool = false;
    var fullSick:Bool = false;
    var fullGood:Bool = false;
    var fullBad:Bool = false;
    var fullShit:Bool = false;
    override public function update(elapsed:Float)
    {
        if (Std.int(shot) < hits && !fullHit && !fullSick)
        {
            shot = FlxMath.lerp(shot, hits, Math.exp(-elapsed * 9 ));
            HitTxt.text = 'Hit ' + Std.int(shot);
        }
        if (Std.int(shot) >= hits && !fullHit)
            {fullHit = true; shot = 0;}

        if (Std.int(shot) < Sick && fullHit && !fullSick)
        {
            shot = FlxMath.lerp(shot, Sick, Math.exp(-elapsed * 9 ));
            curSickTxt.text = 'Sick ' + Std.int(shot);
        }
        if (Std.int(shot) >= Sick && fullHit && !fullSick)
             {fullSick = true; shot = 0;}

        if (Std.int(shot) < Good && fullHit && fullSick && !fullGood)
        {
            shot = FlxMath.lerp(shot, Good, Math.exp(-elapsed * 9 ));
            curGoodTxt.text = 'Good ' + Std.int(shot);
        }
        if (Std.int(shot) >= Good && fullHit && fullSick && !fullGood)
             {fullGood = true; shot = 0;}

        if (Std.int(shot) < Bad && fullHit && fullSick && fullGood && !fullBad)
        {
            shot = FlxMath.lerp(shot, Bad, Math.exp(-elapsed * 9 ));
            curBadTxt.text = 'Bad ' + Std.int(shot);
        }
        if (Std.int(shot) >= Bad && fullHit && fullSick && fullGood && !fullBad)
             {fullBad = true; shot = 0;}

        if (Std.int(shot) < Shit && fullHit && fullSick && fullGood && fullBad && !fullShit)
        {
            shot = FlxMath.lerp(shot, Shit, Math.exp(-elapsed * 9 ));
            curShitTxt.text = 'Shit ' + Std.int(shot);
        }
        if (Std.int(shot) >= Shit && fullHit && fullSick && fullGood && fullBad && !fullShit)
             {fullShit = true; shot = 0;}

        if (fullHit && fullSick && fullGood && fullBad && fullShit)
        {
            curScoreTxt.text = 'Score ' + Score;
        }




        super.update(elapsed);
        if (controls.justPressed('ACCEPT') && !pressEnter)
            {
                LevelSelect.isCurStep = curStep = 0;
                LevelSelect.iSCurBeat = curBeat = 0;
    
                LevelSelect.isTotalSteps = totalSteps = 0;
                LevelSelect.isTotalBeats = totalBeats = 0;
    
                LevelSelect.islastStep = lastStep = 0;
                LevelSelect.islastBeat = lastBeat = 0;

                FlxG.sound.playMusic(AssetPaths.freakyMenu__ogg, 0.3);
                pressEnter = true;
                var mySound:FlxSound = FlxG.sound.play("assets/sounds/confirmMenu.ogg", 0.4);
                mySound.onComplete = function() 
                        MusicBeatState.switchState(new LevelSelect());
            }
    }
    
}