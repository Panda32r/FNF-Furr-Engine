package states;

import charectors.CharectorsWinState;
import flixel.text.FlxBitmapText;
import flixel.text.FlxBitmapFont;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import openfl.media.Sound;

class ResultState extends MusicBeatState
{
    public static var Sick:Int = 0;
    public static var Good:Int = 0;
    public static var Bad:Int = 0;
    public static var Shit:Int = 0;
    public static var Score:Int = 0;
    private var scoreUp:Int = 0;
    public static var Miss:Int = 0;
    public static var MaxCombo:Int = 0;
    public static var rating:FlxText;
    public static var ratingText:Array<String> = ['P', 'S' , 'G', 'B'];
    public static var ratingComboText:Array<String> = ['PFC', 'SFC' , 'GFC', 'FC', 'SDCB', 'Clear'];

    public var camGame:FlxCamera;
	public var camHUD:FlxCamera;


    var curScoreTxt:FlxText;
    var HitTxt:FlxBitmapText;
    var MaxComboTxt:FlxBitmapText;
    var MissTxt:FlxBitmapText;
    var curSickTxt:FlxBitmapText;
    var curGoodTxt:FlxBitmapText;
    var curBadTxt:FlxBitmapText;
    var curShitTxt:FlxBitmapText;
    var scoreSpr:FlxSprite;
    var scoreSprGroup:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
    var scoreSprArray:Array<FlxSprite> = [];


    public static var hits:Int = 0;
    public static var priceHits:Float = 0;
    var retingPercent:Float = 0.0;
    var precentTextSpr:FlxSprite;
    var precentNumText:FlxBitmapText;


    var soundSystemSpr:FlxSprite;
    var ratingsSpr:FlxSprite;


    var charectorsAtlas:CharectorsWinState = null;
    var charectors2Atlas:CharectorsWinState = null;

    var songIntro:FlxSound = null;
    var song:FlxSound = null;

    override public function create():Void
    {
        super.create();

		retingPercent = Math.min(1, Math.max(0, priceHits / hits));

        camGame = new FlxCamera();
		camGame.bgColor = FlxColor.fromString('#FFD863');
		FlxG.cameras.reset(camGame);
		camGame.zoom = 1;

		camHUD = new FlxCamera();
        camHUD.bgColor = FlxColor.TRANSPARENT; 
        camHUD.width = FlxG.width;
        camHUD.height = FlxG.height;
        camHUD.x = 0;
        camHUD.y = 0;
        FlxG.cameras.add(camHUD);

        #if !neko
        if(retingPercent * 100 > 91)
        {        
            charectorsAtlas = new CharectorsWinState(1329, 429, 'bf', 'EXCELLENT');
            charectorsAtlas.cameras = [camGame];
            charectorsAtlas.visible = false;
            add(charectorsAtlas);
            charectorsAtlas.anim.onComplete.add(() -> {charectorsAtlas.anim.play(null, true, false, 29);});

            songIntro = new FlxSound().loadEmbedded(Sound.fromFile('assets/music/resultsEXCELLENT/resultsEXCELLENT-intro.ogg'));
            song = new FlxSound().loadEmbedded(Sound.fromFile('assets/music/resultsEXCELLENT/resultsEXCELLENT.ogg'));
            FlxG.sound.list.add(songIntro);
			FlxG.sound.list.add(song);

            songIntro.play();
            songIntro.onComplete = function(){song.play(true);};
        }
        if(retingPercent * 100 > 81 && retingPercent * 100 < 92)
        {
            charectorsAtlas = new CharectorsWinState(929, 363, 'bf', 'GREAT','bf');
            charectorsAtlas.cameras = [camGame];
            charectorsAtlas.visible = false;
            charectorsAtlas.anim.onComplete.add(() -> {charectorsAtlas.anim.play(null, true, false, 15);});

            charectors2Atlas = new CharectorsWinState(802, 331, 'bf', 'GREAT','gf');
            charectors2Atlas.cameras = [camGame];
            charectors2Atlas.visible = false;
            charectors2Atlas.anim.onComplete.add(() -> {charectors2Atlas.anim.play(null, true, false, 9);});
        
            song = new FlxSound().loadEmbedded(Sound.fromFile('assets/music/resultsNORMAL/resultsNORMAL.ogg'));
            FlxG.sound.list.add(song);

            song.play(true);
            // song.onComplete = function(){song.play();};

            add(charectors2Atlas);
            add(charectorsAtlas);
            
        }
        #end
       

        var texNumber:FlxBitmapFont = FlxBitmapFont.fromAngelCode('assets/images/ResultState/tallieNumber_0.png', 'assets/images/ResultState/tallieNumber.fnt');
        
        var texFonts:FlxBitmapFont = FlxBitmapFont.fromAngelCode('assets/images/ResultState/oh_0.png', 'assets/images/ResultState/oh.fnt');

        HitTxt = new FlxBitmapText(texNumber);
        HitTxt.x = 316;
        HitTxt.y = 138;
        HitTxt.scrollFactor.set();
        HitTxt.text = '';
		HitTxt.cameras = [camHUD];

        MaxComboTxt = new FlxBitmapText(texNumber);
        MaxComboTxt.x = 316;
        MaxComboTxt.y = 200;
        MaxComboTxt.scrollFactor.set();
        MaxComboTxt.text = '';
		MaxComboTxt.cameras = [camHUD];

        MissTxt = new FlxBitmapText(texNumber);
        MissTxt.x = 220;
        MissTxt.y = 486;
        MissTxt.scrollFactor.set();
        MissTxt.text = '';
		MissTxt.cameras = [camHUD];
        

        curSickTxt = new FlxBitmapText(texNumber);
        curSickTxt.x = 222;
        curSickTxt.y = 262;
        curSickTxt.scrollFactor.set();
        curSickTxt.text = '';
		curSickTxt.cameras = [camHUD];

        curGoodTxt = new FlxBitmapText(texNumber);
        curGoodTxt.x = 186;
        curGoodTxt.y = 312;
        curGoodTxt.scrollFactor.set();
        curGoodTxt.text = '';
		curGoodTxt.cameras = [camHUD];
        

        curBadTxt = new FlxBitmapText(texNumber);
        curBadTxt.x = 144;
        curBadTxt.y = 376;
        curBadTxt.scrollFactor.set();
        curBadTxt.text = '';
		curBadTxt.cameras = [camHUD];

        curShitTxt = new FlxBitmapText(texNumber);
        curShitTxt.x = 174;
        curShitTxt.y = 434;
        curShitTxt.scrollFactor.set();
        curShitTxt.text = '';
		curShitTxt.cameras = [camHUD];

        var precentNumber:FlxBitmapFont = FlxBitmapFont.fromAngelCode('assets/images/ResultState/clearPercent/NumbersSmall_0.png', 'assets/images/ResultState/clearPercent/NumbersSmall.fnt');

        precentNumText = new FlxBitmapText(precentNumber);
        precentNumText.x = 812;
        precentNumText.y = 385;
        precentNumText.scrollFactor.set();
        precentNumText.scale.set(1.5, 1.5);
        precentNumText.text = '0';
		precentNumText.cameras = [camHUD];

        curScoreTxt = new FlxText(120, 600);
		curScoreTxt.setFormat('assets/fonts/Menu_Font.ttf', 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        curScoreTxt.scrollFactor.set();
        curScoreTxt.borderSize = 2.25;
        curScoreTxt.visible = false;
        curScoreTxt.text = 'Score 000';
		curScoreTxt.borderSize = 1.25;
		curScoreTxt.cameras = [camHUD];

        curShitTxt.antialiasing = ClientSetings.data.antialiasing;
        curBadTxt.antialiasing = ClientSetings.data.antialiasing;
        curGoodTxt.antialiasing = ClientSetings.data.antialiasing;
        curSickTxt.antialiasing = ClientSetings.data.antialiasing;
        HitTxt.antialiasing = ClientSetings.data.antialiasing;
        MaxComboTxt.antialiasing = ClientSetings.data.antialiasing;
        MissTxt.antialiasing = ClientSetings.data.antialiasing;
        precentNumText.antialiasing = ClientSetings.data.antialiasing;


        var topStripe:FlxSprite = new FlxSprite();
            topStripe.loadGraphic("assets/images/ResultState/topBarBlack.png");
            topStripe.updateHitbox();
            topStripe.antialiasing =  ClientSetings.data.antialiasing;
            topStripe.scrollFactor.set(0, 0);
            topStripe.cameras = [camHUD];
            add(topStripe);

        var resultSpr:FlxSprite = new FlxSprite();
        var texResult = FlxAtlasFrames.fromSparrow('assets/images/ResultState/results.png', 'assets/images/ResultState/results.xml');
            resultSpr.frames = texResult;
            resultSpr.animation.addByPrefix('idle', 'results instance 1', 24, false);
            resultSpr.antialiasing =  ClientSetings.data.antialiasing;
            resultSpr.scrollFactor.set(0, 0);
            resultSpr.cameras = [camHUD];
            resultSpr.x -= 180;
            // resultSpr.screenCenter(X);
            resultSpr.animation.play('idle');
            add(resultSpr);

            soundSystemSpr = new FlxSprite();
        var texSoundSystem = FlxAtlasFrames.fromSparrow('assets/images/ResultState/soundSystem.png', 'assets/images/ResultState/soundSystem.xml');
            soundSystemSpr.frames = texSoundSystem;
            soundSystemSpr.animation.addByPrefix('idle', 'sound system', 24, false);
            soundSystemSpr.antialiasing =  ClientSetings.data.antialiasing;
            soundSystemSpr.scrollFactor.set(0, 0);
            soundSystemSpr.animation.play('idle');
            soundSystemSpr.cameras = [camHUD];
            soundSystemSpr.y -= 180;
            soundSystemSpr.x -= 20;
            add(soundSystemSpr);

            ratingsSpr = new FlxSprite();
        var texRatingsSpr = FlxAtlasFrames.fromSparrow('assets/images/ResultState/ratingsPopin.png', 'assets/images/ResultState/ratingsPopin.xml');
            ratingsSpr.frames = texRatingsSpr;
            ratingsSpr.animation.addByPrefix('idle', 'Categories', 24, false);
            ratingsSpr.antialiasing =  ClientSetings.data.antialiasing;
            ratingsSpr.scrollFactor.set(0, 0);
            ratingsSpr.visible = false;
            // ratingsSpr.animation.play('idle');
            ratingsSpr.cameras = [camHUD];
            ratingsSpr.y += 130;
            ratingsSpr.x -= 140;
            add(ratingsSpr); 

            scoreSpr = new FlxSprite();
        var texScoreSpr = FlxAtlasFrames.fromSparrow('assets/images/ResultState/scorePopin.png', 'assets/images/ResultState/scorePopin.xml');
            scoreSpr.frames = texScoreSpr;
            scoreSpr.animation.addByPrefix('idle', 'tally score0', 24, false);
            scoreSpr.antialiasing =  ClientSetings.data.antialiasing;
            scoreSpr.scrollFactor.set(0, 0);
            scoreSpr.visible = false;
            scoreSpr.cameras = [camHUD];
            scoreSpr.x -= 186;
            scoreSpr.y += 515;
            add(scoreSpr);
        
            precentTextSpr = new FlxSprite().loadGraphic("assets/images/ResultState/clearPercent/clearPercentText.png");
            precentTextSpr.scrollFactor.set(0, 0);
            precentTextSpr.visible = false;
            precentTextSpr.antialiasing =  ClientSetings.data.antialiasing;
            precentTextSpr.cameras = [camHUD];
            precentTextSpr.x += 790;
            precentTextSpr.y += 285;
            add(precentTextSpr);

        var daLoop:Int = 0;
        var separatedScore:String = Std.string(scoreUp).lpad('0', 10);
		for (i in 0...separatedScore.length)
		{
			var numScore:FlxSprite = new FlxSprite();
            var texNumScore = FlxAtlasFrames.fromSparrow('assets/images/ResultState/score-digital-numbers.png', 'assets/images/ResultState/score-digital-numbers.xml');
            numScore.frames = texNumScore;

            for(j in 0 ... 9)
                numScore.animation.addByPrefix('digital' + j, j + ' DIGITAL0', 24, false);

            numScore.animation.addByPrefix('DISABLED', 'DISABLED0', 24, false);
            numScore.animation.addByPrefix('GONE', 'GONE0', 24, false);
            numScore.animation.play('DISABLED');
            numScore.x = 60 +(70 * daLoop);
            numScore.y += 610; 
            numScore.visible = false;
            scoreSprArray.push(numScore);
            scoreSprGroup.add(numScore);
            // numScore.scale.x = 0.6;
            // numScore.scale.y = 0.6;
            // numScore.x = (43 * daLoop) - 90 + rating.x;
            // numScore.y += 80 + rating.y;

            daLoop++;
        }

        scoreSprGroup.cameras = [camHUD];
        add(scoreSprGroup);
        HitTxt.visible = false;
        curSickTxt.visible = false;
        curGoodTxt.visible = false;
        curBadTxt.visible = false;
        curShitTxt.visible = false;   
        MaxComboTxt.visible = false;
        MissTxt.visible = false;
        precentNumText.visible = false;
        
        add(HitTxt);
        add(curSickTxt);
        add(curGoodTxt);
        add(curBadTxt);
        add(curShitTxt);
        add(curScoreTxt);
        add(MaxComboTxt);
        add(MissTxt);
        add(precentNumText);

        white = new FlxSprite().makeGraphic (1280, 720,FlxColor.fromString('#FFFFFF'));
        add(white);
        white.alpha = 0;

    }

    var pressEnter:Bool = false;
    var shot:Float = 0;
    var fullHit:Bool = false;
    var fullScore:Bool = false;
    var fullScoreEnd:Bool = false;
    var fullHitEnd:Bool = false;
    var fullShit:Bool = false;
    var playAnimRatings:Bool = false;
    var playAnimRatings2:Bool = false;
    var playAnimRatings3:Bool = false;
    var alphaPrs:Bool = false;
    var white:FlxSprite;
    override public function update(elapsed:Float)
    {
        if(soundSystemSpr.animation.finished && !playAnimRatings)
        { 
            ratingsSpr.visible = true;
            ratingsSpr.animation.play('idle');
            playAnimRatings = true;
        }   
        if(playAnimRatings && ratingsSpr.animation.finished && !playAnimRatings2)
        {
            scoreSpr.visible = true;
            scoreSpr.animation.play('idle');
            playAnimRatings2 = true;
            precentTextSpr.visible = true;
            var separatedScore:String = Std.string(scoreUp).lpad('0', 10);
            for (i in 0...separatedScore.length)
		    {
                scoreSprArray[i].visible = true;
            }
        }
        if(playAnimRatings2 && scoreSpr.animation.finished && !playAnimRatings3)
        {
            playAnimRatings3 = true;
            HitTxt.visible = true;
            curSickTxt.visible = true;
            curGoodTxt.visible = true;
            curBadTxt.visible = true;
            curShitTxt.visible = true;
            MaxComboTxt.visible = true;
            MissTxt.visible = true;
            precentNumText.visible = true;
        }
        if(!fullHit && playAnimRatings3)
        {
            FlxTween.num(0, hits, 0.5, { ease: FlxEase.sineInOut },
                        (value:Float) -> {
                            shot = Math.floor(value);
                            HitTxt.text = '' + Std.int(shot);
                        })
            .then(FlxTween.num(0, MaxCombo, 0.5, { ease: FlxEase.sineInOut },
                        (value:Float) -> {
                            shot = Math.floor(value);
                            MaxComboTxt.text = '' + Std.int(shot);
                        })
            .then(FlxTween.num(0, Sick, 0.5, { ease: FlxEase.sineInOut },
                        (value:Float) -> {
                            shot = Math.floor(value);
                            curSickTxt.text = '' + Std.int(shot);
                        })
            .then(FlxTween.num(0, Good, 0.5, { ease: FlxEase.sineInOut },
                        (value:Float) -> {
                            shot = Math.floor(value);
                            curGoodTxt.text = '' + Std.int(shot);
                        })
            .then(FlxTween.num(0, Bad, 0.5, { ease: FlxEase.sineInOut },
                        (value:Float) -> {
                            shot = Math.floor(value);
                            curBadTxt.text = '' + Std.int(shot);
                        })
            .then(FlxTween.num(0, Shit, 0.5,  { ease: FlxEase.sineInOut },
                        (value:Float) -> {
                            shot = Math.floor(value);
                            curShitTxt.text = '' + Std.int(shot);
                        })
            .then(FlxTween.num(0, Miss, 0.5, { ease: FlxEase.sineInOut,
                        onComplete: function (twn:FlxTween) {
                            fullHitEnd = true;
                        } },
                        (value:Float) -> {
                            shot = Math.floor(value);
                            MissTxt.text = '' + Std.int(shot);
                        })
            ))))));
            var prc:Int = Std.int(retingPercent * 100) ;
            #if !debug
            FlxTween.num(0, prc, 2.5, { ease: FlxEase.sineInOut},
                        (value:Float) -> {
                            shot = Math.floor(value);
                            precentNumText.text = '' + Std.int(shot);
                            var mySound:FlxSound = FlxG.sound.play("assets/sounds/scrollMenu.ogg", 0.3);
                        });
            #else
            precentNumText.text = '100';
            #end

            fullHit = true;
        }
        if (fullHitEnd && !fullScore)
        {
            #if !neko
            if(charectorsAtlas != null)
            {
                charectorsAtlas.visible = true;
                charectorsAtlas.anim.play();
            }
            if(charectors2Atlas != null)
            {
                charectors2Atlas.visible = true;
                charectors2Atlas.anim.play();
            }
            #end

            
            white.alpha = 1;
            var mySound:FlxSound = FlxG.sound.play("assets/sounds/confirmMenu.ogg", 0.4);

            alphaPrs = true;
            FlxTween.num(0, Score, 0.5, { ease: FlxEase.sineInOut,
                        onComplete: function (twn:FlxTween) {
                            fullScoreEnd = true;
                        }},
                        (value:Float) -> {
                            shot = Math.floor(value);
                            scoreUp = Std.int(shot);
                        });
            fullScore = true;
        }

        if(white.alpha > 0)
            white.alpha = FlxMath.lerp(0, white.alpha, Math.exp(-elapsed * 9 ));

        if(fullScore && !fullScoreEnd)
        { 
            var separatedScore:String = Std.string(scoreUp).lpad('0', 10);
            for (i in 0...separatedScore.length)
		    {
                // scoreSprArray[i].visible = true;
                scoreSprArray[i].animation.play('digital' + Std.parseInt(separatedScore.charAt(i)));
            }
            curScoreTxt.text =  '' + scoreUp;

        }

        if(alphaPrs && precentNumText.alpha > 0)
        {
            precentNumText.alpha -= 0.01;
            precentTextSpr.alpha -= 0.01;
        }
        super.update(elapsed);
        if (controls.justPressed('ACCEPT') && !pressEnter)
            {
                FlxG.sound.playMusic('assets/music/freakyMenu.ogg', 0.3);

                pressEnter = true;
                var mySound:FlxSound = FlxG.sound.play("assets/sounds/confirmMenu.ogg", 0.4);
                mySound.onComplete = function() 
                        {
                            if (PlayState.songList.length == 0)
                                MusicBeatState.switchState(new LevelSelect());
                            else
                            {
                                MusicBeatState.switchState(new StoryState());
                                PlayState.songList = [];
                            }
                            Score = 0;
                            Sick = 0;
                            Good = 0;
                            Bad = 0;
                            Shit = 0;
                            hits = 0;
                            Miss = 0;
                            hits = 0;
                            priceHits = 0;
                        }
            }
    }
    
}