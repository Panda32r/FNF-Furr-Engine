package states;


import backend.RandomSongForDemo;
import charectors.BF;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.sound.FlxSound;
import flixel.util.FlxColor;
import states.PlayState;

class TitleState extends MusicBeatState
{
    public var rSong:RandomSongForDemo = new RandomSongForDemo();
    public var gf:BF;
    public var logo:FlxSprite;
    public var danceGF:Bool = false;
    public var song:FlxSound;

    public var camGame:FlxCamera;
    public var camHUD:FlxCamera;

    public var bg:FlxSprite;

    public var whileColor:FlxSprite;

    public var titleEnter:FlxSprite;
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

        bg = new FlxSprite();
        bg.loadGraphic("assets/images/menuBG.png"); // Загружаем изображение
        bg.setGraphicSize(FlxG.width, FlxG.height); // Растягиваем на весь экран
        bg.visible = false;
        bg.updateHitbox();
        bg.scrollFactor.set(0, 0); // Фон не должен двигаться при движении камеры
        add(bg);
        bg.cameras = [camGame];

        //Код предназначеный чтоб делать окно прозрачным 
        // var bg_alhpa:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(24 , 24, 24));
        // if (camGame.zoom < 1)
        //     bg_alhpa.scale.scale(1 / camGame.zoom);
        // bg_alhpa.scrollFactor.set();
        // bg_alhpa.cameras = [camGame];
        // add(bg_alhpa);
        // FlxTransWindow.getWindowsTransparent();

        // song = FlxG.sound.load(AssetPaths.freakyMenu__ogg, 1, false);

        gf = new BF(600, 100, 'gf');
        gf.setGraphicSize(563,526);
        gf.updateHitbox();
        add(gf);
        gf.cameras = [camGame];


        logo = new FlxSprite(-100,-100);
        var logoTex= FlxAtlasFrames.fromSparrow('assets/images/logoBumpin.png', 'assets/images/logoBumpin.xml');
        logo.frames = logoTex;
        logo.animation.addByPrefix('LogoBoop', 'logo bumpin0');
        logo.animation.play('LogoBoop');
        add(logo);
        logo.cameras = [camGame];

        titleEnter = new FlxSprite(50,FlxG.height - 150);
        var titleEnterTex= FlxAtlasFrames.fromSparrow('assets/images/titleEnter.png', 'assets/images/titleEnter.xml');
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

        // song.onComplete = SongEnd;

        Conductor.changeBPM(102);

        
    }

    var animEnter:Bool = false;
    override public function update(elapsed:Float) 
    {
        super.update(elapsed);

        if (whileColor.alpha > 0)
            whileColor.alpha -=0.01;
        if (controls.justPressed('ACCEPT'))
        {
			whileColor.alpha = 1;
            if (!animEnter)
                titleEnter.animation.play('pressed');
            else
                titleEnter.animation.play('freeze');
            var mySound:FlxSound = FlxG.sound.play("assets/sounds/confirmMenu.ogg", 0.4);
            mySound.onComplete = function() 
                    MusicBeatState.switchState(new LevelSelect());
            
                
        }
        if (FlxG.sound.music != null)
        {    // Conductor.songPosition = song.time;
            Conductor.songPosition = FlxG.sound.music.time;
        }
    } 

    override function beatHit() 
        {
            super.beatHit();
            if (curBeat % 1 == 0)
                if (gf.animation.curAnim.finished || gf.animation.name == 'danceLeft' || gf.animation.name == 'danceRight')	
                {
                    if (!danceGF)
                    {gf.animation.stop();gf.playAnim('danceLeft'); danceGF = true;logo.animation.play('static');}
                    else
                    {gf.animation.stop();gf.playAnim('danceRight'); danceGF = false;logo.animation.play('static');}
                }
        }

    function SongEnd() 
	{
        PlayState.curSong = rSong.randSong;
        PlayState.debag = true;
		MusicBeatState.switchState(new PlayState());
	}
}