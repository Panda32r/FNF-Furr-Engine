package states;


import backend.RandomSongForDemo;
import charectors.CharectorsOther;
import flixel.util.FlxColor;
import states.ResultState;
import backend.Song;
import backend.EventJson;
import states.LevelSelect;

class TitleState extends MusicBeatState
{
    public var rSong:RandomSongForDemo = new RandomSongForDemo();

    public var gf:CharectorsOther;

    public var logo:FlxSprite;
    public var danceGF:Bool = false;
    public var song:FlxSound;

    public var camGame:FlxCamera;
    public var camHUD:FlxCamera;

    public var bg:FlxSprite;

    public var whileColor:FlxSprite;

    public var titleEnter:FlxSprite;
    var pressEnter:Bool = false;
    override public function create():Void 
    {
        super.create();

        // Conductor.songPosition = 0;
        camGame = new FlxCamera();
		camGame.bgColor = FlxColor.BLACK;
		FlxG.cameras.reset(camGame);
		// camGame.zoom = 0.72;
        
		camHUD = new FlxCamera();
        camHUD.bgColor = FlxColor.TRANSPARENT; 
        camHUD.width = FlxG.width;
        camHUD.height = FlxG.height;
        camHUD.x = 0;
        camHUD.y = 0;
        FlxG.cameras.add(camHUD);
    
        whileColor = new FlxSprite();
        whileColor.makeGraphic(FlxG.width, FlxG.height,FlxColor.fromString('#FFFFFF'));
		whileColor.cameras = [camHUD];
		whileColor.alpha = 1;
        add(whileColor);

        //Код предназначеный чтоб делать окно прозрачным 
        // var bg_alhpa:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(24 , 24, 24));
        // if (camGame.zoom < 1)
        //     bg_alhpa.scale.scale(1 / camGame.zoom);
        // bg_alhpa.scrollFactor.set();
        // bg_alhpa.cameras = [camGame];
        // add(bg_alhpa);
        // FlxTransWindow.getWindowsTransparent();

        // song = FlxG.sound.load(AssetPaths.freakyMenu__ogg, 1, false);


        gf = new CharectorsOther(500, 50, 'gf', 'TitleState');
        gf.updateHitbox();
        add(gf);
        gf.cameras = [camGame];


        logo = new FlxSprite(-100,-100);
        var logoTex= FlxAtlasFrames.fromSparrow('assets/images/TitleState/logoBumpin.png', 'assets/images/TitleState/logoBumpin.xml');
        logo.frames = logoTex;
        logo.animation.addByPrefix('LogoBoop', 'logo bumpin0');
        logo.animation.play('LogoBoop');
        add(logo);
        logo.cameras = [camGame];
        logo.antialiasing = true;

        titleEnter = new FlxSprite(50,FlxG.height - 150);
        var titleEnterTex= FlxAtlasFrames.fromSparrow('assets/images/TitleState/titleEnter.png', 'assets/images/TitleState/titleEnter.xml');
        titleEnter.frames = titleEnterTex;
        titleEnter.animation.addByPrefix('idle', 'ENTER IDLE0');
        titleEnter.animation.addByPrefix('freeze', 'ENTER FREEZE0');
        titleEnter.animation.addByPrefix('pressed', 'ENTER PRESSED0');
        titleEnter.animation.play('idle');
        add(titleEnter);
        titleEnter.cameras = [camGame];


        if (FlxG.sound.music == null)
        {
            FlxG.sound.playMusic(AssetPaths.freakyMenu__ogg, 1);
            // song.play();
        }

        if (FlxG.sound.music != null) 
            Conductor.songPosition = FlxG.sound.music.time;

        FlxG.sound.music.onComplete = SongEnd;

        Conductor.changeBPM(102);

        gf.playAnim('danceRight');

        curStep = LevelSelect.isCurStep;
        curBeat = LevelSelect.iSCurBeat;

        totalSteps = LevelSelect.isTotalSteps;
        totalBeats = LevelSelect.isTotalBeats;

        lastStep = LevelSelect.islastStep;
        lastBeat = LevelSelect.islastBeat;
    }

    var animEnter:Bool = false;
    override public function update(elapsed:Float) 
    {
        super.update(elapsed);

        if (whileColor.alpha > 0)
            whileColor.alpha -=0.01;
        if (controls.justPressed('ACCEPT') && !pressEnter)
        {
            pressEnter = true;
			whileColor.alpha = 1;
            if (!animEnter)
                titleEnter.animation.play('pressed');
            else
                titleEnter.animation.play('freeze');
            var mySound:FlxSound = FlxG.sound.play("assets/sounds/confirmMenu.ogg", 0.4);
            mySound.onComplete = function() 
                    MusicBeatState.switchState(new MeinMenu());
            LevelSelect.isCurStep = curStep;
            LevelSelect.iSCurBeat = curBeat;

            LevelSelect.isTotalSteps = totalSteps;
            LevelSelect.isTotalBeats = totalBeats;

            LevelSelect.islastStep = lastStep;
            LevelSelect.islastBeat = lastBeat;
                
        }
        if (FlxG.sound.music != null)
        {    // Conductor.songPosition = song.time;
            Conductor.songPosition = FlxG.sound.music.time;
        }
        if (controls.justPressed('BACK'))
            MusicBeatState.switchState(new MeinMenu());
    } 

    override function beatHit() 
        {
            super.beatHit();
                if (gf.animation.curAnim.finished || gf.animation.name == 'danceLeft' || gf.animation.name == 'danceRight')	
                {
                    if (!danceGF)
                    {gf.playAnim('danceLeft'); danceGF = true;logo.animation.play('static');}
                    else
                    {gf.playAnim('danceRight'); danceGF = false;logo.animation.play('static');}
                    // trace('Dance');
                }
        }

    function SongEnd() 
	{
        FlxG.sound.playMusic(AssetPaths.freakyMenu__ogg, 0);
        PlayState.SONG = Song.loadFromJson(rSong.randSong,rSong.randSong);
        PlayState.EVENT = EventJson.loadJson(rSong.randSong);
        PlayState.songName = rSong.randSong;
        PlayState.demo = true;
        MusicBeatState.switchState(new PlayState()); // Переход в игру
	}
}