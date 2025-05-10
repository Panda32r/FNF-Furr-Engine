package states;

import backend.EventJson;
import openfl.media.Sound;
import backend.Song;
import backend.Stagebg;
import charectors.BF;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;
import objects.MyStrumNote;
import objects.Note;
import objects.HealthIcon;
import objects.Section.SwagSection;
import states.LevelSelect;
import states.ResultState;
import scriptsUrlsFE.HsShit;

import lime.app.Application;

class PlayState extends MusicBeatState
{
	public static var instance:PlayState;
	var HScript:HsShit;

	public var rSong:RandomSongForDemo = new RandomSongForDemo();
	public static var demo:Bool = false;

	public var NOTE_Y:Int = 25;
	public var NOTE_Y_DOWNSCROLL:Int = FlxG.height - 190;
	public var strumsBlocked:Array<Bool> = [];

	public var noteKillOffset:Float = 350;

	public static var songName:String = 'Fresh';
	public static var SONG:SwagSong = null;
	public static var EVENT:EventFiles = null;
	public static var ratingStuff:Array<Dynamic> = [
		['You Suck!', 0.2], //From 0% to 19%
		['Shit', 0.4], //From 20% to 39%
		['Bad', 0.5], //From 40% to 49%
		['Bruh', 0.6], //From 50% to 59%
		['Meh', 0.69], //From 60% to 68%
		['Nice', 0.7], //69%
		['Good', 0.8], //From 70% to 79%
		['Great', 0.9], //From 80% to 89%
		['Sick!', 1], //From 90% to 99%
		['Perfect!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];

	public var generatedMusic:Bool = false;
	public var danceGF:Bool = false;

	public var camGame:FlxCamera;
	public var camHUD:FlxCamera;
	public var camDead:FlxCamera;

	public var boifrend:BF;
	public var Dad:BF;
	public var gf:BF;
	public var deadBf:BF;
	public var iconP1:HealthIcon;
	public var iconP2:HealthIcon;

	public var singAnim:Array<String> = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];
	public var missAnim:Array<String> = ['singLEFTmiss', 'singDOWNmiss', 'singUPmiss', 'singRIGHTmiss'];
	public var BG:FlxSprite;

	public var startTimer:FlxTimer;
	public var startingSong:Bool = false;
	public var startedCountdown:Bool = false;

	public var music:FlxSound;
	public var inst:FlxSound;
	public var voicesOp:FlxSound;
	public var voicesPl:FlxSound;

	
	public var curSong:String;
	
	public var textcurBeat:FlxText;
	public var textCurSong:FlxText;

	private var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var strumLineNotes:FlxTypedGroup<MyStrumNote> = new FlxTypedGroup<MyStrumNote>();
	private var playerStrums:FlxTypedGroup<MyStrumNote> = new FlxTypedGroup<MyStrumNote>();
	private var dadStrums:FlxTypedGroup<MyStrumNote> = new FlxTypedGroup<MyStrumNote>();

	private var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	private var camZooming:Bool = false;

	public var defaultCamZoom:Float = 1.05;
	public var camZoomingDecay:Float = 1;

	private var camFollow:FlxObject;

	public var boyfriendCameraOffset:Array<Float> = null;
	public var DadCameraOffset:Array<Float> = null;
	public var girlfriendCameraOffset:Array<Float> = null;

	public static var debag:Bool = false;

	public var health:Float = 0.5;
	public var scoreTxt: FlxText;
	public var score:Int = 0;
	public var combo:Int = 0;
	public var miss:Int = 0;

	var Nowplaying:FlxText;
	var bgBlac:FlxSprite;
	var bgBlue:FlxSprite;

	

	var randomScore:Int;//Хотите собрать максимум очков?
	// молитесь у бога рандома  :)


	private var keysArray:Array<String>;

	public var debugTxt:FlxText;

	public var stage:Stagebg;

	var eventData:Array<Events>;
	var eventOn:Bool = false;
	var timerTxt:FlxText;

	#if debag
	var curStepTxt:FlxText;
	var timeClik:FlxText;
	#end
	
	override public function create():Void
	{	
		//Так блять я конечно ебал ваши скрипты но они очень нужны, прям пиздец как нужны
		instance = this;
		//Я ЕБАЛ ЭТИ СКРИПТЫ ЕБАНЫЕ ПУСКАЙ ИДУТ НАХУЙ 
		initHxScript('assets/script.hx');
		debag = ClientSetings.data.botPlay;
		

		if (demo)
			debag = true;

		super.create();
		
		//Масив для упращения кода 
		keysArray = [
			'note_left',
			'note_down',
			'note_up',
			'note_right'
		];

		// curSong = holnah.randSong;

		//загружаем файл уровня 
		if (SONG == null)
			SONG = Song.loadFromJson(songName,songName);
		// else
			// SONG = Song.loadFromJson(curSong,curSong);
		if (EVENT == null)
			EVENT = EventJson.loadJson(songName);
		// trace(EVENT.event);

		if (SONG.player3 == null)
				SONG.player3 = 'gf';
		
		trace (SONG.bpm);

		startingSong = true;
		Conductor.songPosition = -Conductor.Bit * 5 + Conductor.offset;

		//Камеры игры
		camGame = new FlxCamera();
		camGame.bgColor = FlxColor.BLACK;
		FlxG.cameras.reset(camGame);
		camGame.zoom = 0.5;
		setForScript('camGame', camGame);

		camDead = new FlxCamera();
        camDead.bgColor = FlxColor.BLACK; 
		camDead.visible = false;
        camDead.x = 0;
        camDead.y = 0;
        FlxG.cameras.add(camDead);
		setForScript('camDead', camDead);

		camHUD = new FlxCamera();
        camHUD.bgColor = FlxColor.TRANSPARENT; 
        camHUD.width = FlxG.width;
        camHUD.height = FlxG.height;
        camHUD.x = 0;
        camHUD.y = 0;
        FlxG.cameras.add(camHUD);
		setForScript('camHUD', camHUD);
		
		debugTxt = new FlxText(0, 0, 160, 'Debug');
		debugTxt.setFormat('assets/fonts/vcr.ttf', 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		debugTxt.scrollFactor.set();
		debugTxt.borderSize = 1.25;
		debugTxt.cameras = [camHUD];
		debugTxt.x = (FlxG.width - debugTxt.width) / 2;
		debugTxt.y = ClientSetings.data.downScroll ? 90 : 60;
		
		

		#if debag
		curStepTxt = new FlxText(60, 300, 100, 'Step');
		curStepTxt.setFormat('assets/fonts/vcr.ttf', 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		curStepTxt.scrollFactor.set();
		curStepTxt.borderSize = 1.25;
		curStepTxt.cameras = [camHUD];

		add(curStepTxt);

		timeClik = new FlxText(FlxG.width/2 + 300, 300, 100, '');
		timeClik.setFormat('assets/fonts/vcr.ttf', 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeClik.scrollFactor.set();
		timeClik.cameras = [camHUD];

		add(timeClik);
		#end
		// Спавн основных стрелок
		generateStaticArrows(0,'NOTE_assets_Lycur');
		generateStaticArrows(1);

		//Сбор инормации с .json файла уровня 
		generateSong(curSong);

		// add(stage.BgStage);

		stage.spriteGroup.cameras = [camGame];
		add(stage.spriteGroup);

		callForScript("onCreate");

		//Код предназначеный чтоб делать окно прозрачным 
		// var bg_alhpa:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(24 , 24, 24));
        // if (defaultCamZoom < 1)
        //     bg_alhpa.scale.scale(1 / defaultCamZoom);
        // bg_alhpa.scrollFactor.set();
        // bg_alhpa.cameras = [camGame];
        // add(bg_alhpa);
        // FlxTransWindow.getWindowsTransparent();

		// if(girlfriendCameraOffset == null)
			girlfriendCameraOffset = [gf.getMidpoint().x + gf.xPosCam + stage.gf_cam_pos[0], gf.getMidpoint().y + gf.yPosCam + stage.gf_cam_pos[1]];

		// if(DadCameraOffset == null)
			DadCameraOffset = [Dad.getMidpoint().x + Dad.xPosCam + stage.dad_cam_pos[0], Dad.getMidpoint().y + Dad.yPosCam + stage.dad_cam_pos[1]];

		// if(boyfriendCameraOffset == null)
			boyfriendCameraOffset = [boifrend.getMidpoint().x - boifrend.xPosCam - stage.bf_cam_pos[0], boifrend.getMidpoint().y + boifrend.yPosCam + stage.bf_cam_pos[1]];

		var camPos:FlxPoint = FlxPoint.get(girlfriendCameraOffset[0], girlfriendCameraOffset[1]);

		if (SONG.song == 'Tutorial')
		{
			Dad.visible = false;
			DadCameraOffset = girlfriendCameraOffset;
		}
		camFollow = new FlxObject(0, 0);

		camFollow.setPosition(camPos.x, camPos.y);
		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.04);
		camDead.follow(camFollow, LOCKON, 0.04);

		// Текст который стоит удалить
		// var text = new FlxText(0, 20, 100, "Blat ybeite mena, ia hochy cdoxnyt viebite mena nahyi gde nado stjlko vsaoi hyiti sdelat hto ahyet i ne vstat Version Engine 6.0 Hto nax axyeno idy");
		// add(text);
		// text.cameras = [camHUD];

		add(gf);
		gf.cameras = [camGame];

		add(Dad);
		Dad.cameras = [camGame];

		add(boifrend);
		boifrend.cameras = [camGame];

		add(deadBf);
		deadBf.cameras = [camDead];

		if(Dad.notFound)
			{add(Dad.notFoundPathJson); Dad.notFoundPathJson.cameras = [camGame];}
		if(boifrend.notFound)
			{add(boifrend.notFoundPathJson); boifrend.notFoundPathJson.cameras = [camGame];}
		if(gf.notFound)
			{add(gf.notFoundPathJson); gf.notFoundPathJson.cameras = [camGame];}

		notes.cameras = [camHUD];

		
		strumLine = new FlxSprite(0, !ClientSetings.data.downScroll ? NOTE_Y : NOTE_Y_DOWNSCROLL).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();

		strumLineNotes.cameras = [camHUD];
		add(strumLineNotes);

		add(notes);

		// trace(Dad.xPosCam);
		// trace(Dad.yPosCam);
		// trace(boifrend.xPosCam);
		// trace(boifrend.yPosCam);

		startCountdown();

		timer();

		scoreTxt_and_BG();

		healthBar();

		nowPlay();

		add(debugTxt);

		if (!demo)
			debugTxt.text = debag ? 'BotPlay' : '' ;
		else
			debugTxt.text = 'Demo';
		// trace(holnah.randSong);
		callForScript("onCreatePost");
	}

	var youDead:Bool = false;
	var startDead:Bool = false;
	var deadSfx:FlxSound;
	var deadSong:FlxSound;
	var deadEndNow:Bool = false;
	var sped:Float;
	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// if (controls.justReleased('note_up'))
		// 	trace('1');

		//Зум камер
		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, Math.exp(-elapsed * 3.125 * camZoomingDecay * 1));
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, Math.exp(-elapsed * 3.125 * camZoomingDecay * 1));
		}

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += elapsed * 1000;
				if (Conductor.songPosition >= 0)
				startSong();

			}
		}
		else
		{
			Conductor.songPosition = inst.time;
			// trace('beat ' + totalBeats);
			// trace('step ' + totalSteps);
		}
		
		//Создание нот в правельной последовательности
		if (unspawnNotes[0] != null)
		{

			while (unspawnNotes.length > 0 && unspawnNotes[0].strumTime - Conductor.songPosition < 1500)
				{
					var dunceNote:Note = unspawnNotes[0];
					notes.insert(0, dunceNote);

					var index:Int = unspawnNotes.indexOf(dunceNote);
					unspawnNotes.splice(index, 1);
				}
		}
		
		if (generatedMusic && !youDead)
		{
			callForScript("onUpdate", elapsed);

			ChekKey();
			notes.forEachAlive(function(daNote:Note)
			{
				if(!ClientSetings.data.downScroll )
					daNote.active = daNote.visible = daNote.y > FlxG.height ? false : true ;
				else
					daNote.active = daNote.visible = daNote.y > FlxG.height + 350 ? false : true ;

				//Скорость прокрутки стрелак
				if (!ClientSetings.data.downScroll) 
					sped = strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * PlayState.SONG.speed);
				else 
					sped = strumLine.y + (Conductor.songPosition - daNote.strumTime) * (0.45 * PlayState.SONG.speed);

				if (ClientSetings.data.downScroll)
					if (daNote.isSustainNote)
					sped -= ((daNote.frameHeight * daNote.scale.y) - (Note.swagWidth / 2));

				daNote.y = sped;

				//Бот нажимает клавиши опонента
				if (!daNote.mustPress && daNote.wasGoodHit && !daNote.ignoreNote)
					opponentNoteHit(daNote);

				//Бот нажимает со с стороны игрока
				if (debag && daNote.canBeHit && (daNote.isSustainNote || daNote.strumTime <= Conductor.songPosition) && !daNote.ignoreNote)
					goodNoteHit(daNote);	

				if (!debag && daNote.tooLate && !daNote.missNote && !daNote.ignoreNote)
				{
					// invalidateNote(daNote);
					noteMiss(daNote);
					// trace('note miss');
				}

				if (Conductor.songPosition - daNote.strumTime > noteKillOffset && !daNote.isSustainNote)
				{
					daNote.active = daNote.visible = false;
					invalidateNote(daNote);
					// trace('note dell');
				}
				
				

				// if(daNote.mustPress && daNote.isSustainNote)
					// daNote.clipToStrumNote();

			});

			timerTxt.text = Math.floor(Conductor.songPosition / 60000) + ':' + Math.floor((Conductor.songPosition % 60000)/ 1000) +'/'+  Math.floor(inst.length / 60000) + ':' + Math.floor((inst.length % 60000)/ 1000);
		
			if(!demo)
			{
				if (controls.justPressed('PAUSE')){SongEnd();}
				if(controls.justPressed('RESET')){health = 0;}
			}
			else
			{
				if (controls.justPressed('EXIT_DEMO'))
				{
					demo = false;
					SongEnd();
				}
			}
			
			// if (eventOn)
			// 	chekEvent(eventData);
				
			updateScoreText();
			movetCam();

			if (debag)
				debugModText();
			
			// healthDad.scale.set(health, 1);
			// healthDad.width = 720 * (1 - health);
			// healthDad.makeGraphic(Std.int(720 * (1 - health)), 16,FlxColor.fromRGB(Dad.healthbar_colors[0], Dad.healthbar_colors[1], Dad.healthbar_colors[2]));		
			if (health <= 0)
				youDead = true;


			updateIcons(elapsed);
			callForScript("onUpdatePost", elapsed);

		}

		if (youDead)
		{
			inst.pause();
			if (voicesOp.playing) {
				voicesOp.pause();
			}
			if (voicesPl.playing) {
				voicesPl.pause();
			}
			
			if (!startDead)
			{
				camDead.visible = true;
				camHUD.visible = false;
				deadSfx.play();
				deadBf.playAnim('firstDeath');

				deadSfx.onComplete = function() 
				{
					if(!deadEndNow)
					{
						deadSong.play();
						deadBf.playAnim('deathLoop');
					}
				}
				startDead = true;
			}
			
			if (controls.justPressed('ACCEPT') && !deadEndNow)
			{
				deadEndNow = true;
				deadSong.pause();
				deadBf.playAnim('deathConfirm');
				var confirmSong:FlxSound = FlxG.sound.play("assets/music/gameOverEnd.ogg");
            	// confirmSong.onComplete = function() 
                    // MusicBeatState.switchState(new PlayState());
			}
			if (controls.justPressed('BACK') && !deadEndNow)
			{
				if (deadSong.playing) {
					deadSong.pause();
				}
				if (deadSfx.playing) {
					deadSfx.pause();
				}
				SongEnd();
			}

			if (deadEndNow)
				if (deadBf.alpha > 0)
				{
					deadBf.alpha -= 0.005;
				}
				else
					MusicBeatState.switchState(new PlayState());
		}
		
	}

	function startCountdown():Void
	{
		Conductor.songPosition -= Conductor.Bit * 5;

		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.Bit / 1000, function(tmr:FlxTimer)
		{
			Dad.animation.stop();
			boifrend.animation.stop();
			Dad.playAnim('idle');
			boifrend.playAnim('idle');
			if (!danceGF)
			{gf.playAnim('danceLeft'); danceGF = true;}
			else
			{gf.playAnim('danceRight'); danceGF = false;}

			startedCountdown = true;
			// Conductor.songPosition = 0;
			Conductor.songPosition -= Conductor.Bit * 5;

			switch (swagCounter)
			{
				case 0:
					FlxG.sound.play('assets/sounds/intro3.ogg', 0.6);
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic('assets/images/ready.png');
					ready.scrollFactor.set();
					ready.screenCenter();
					ready.cameras = [camHUD];
					ready.y = ready.y - 120; 
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.Bit / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play('assets/sounds/intro2.ogg', 0.6);
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic('assets/images/set.png');
					set.scrollFactor.set();
					set.screenCenter();
					set.cameras = [camHUD];
					set.y = set.y - 120; 
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.Bit / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play('assets/sounds/intro1.ogg', 0.6);
				case 3:
					var go:FlxSprite = new FlxSprite().loadGraphic('assets/images/go.png');
					go.scrollFactor.set();
					go.screenCenter();
					go.cameras = [camHUD];
					go.y = go.y - 120; 
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.Bit / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play('assets/sounds/introGo.ogg', 0.6);
				case 4:
					Conductor.songPosition = -300;
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);
	}

	function startSong():Void
	{
		trace('Song Start!!');
		startingSong = false;
		inst.play();
		inst.onComplete = SongEnd;
		if (voicesOp.length > 0)
			voicesOp.play();
		if (voicesPl.length > 0)
			voicesPl.play();

	}
	
	override function stepHit() 
	{
		super.stepHit();
		if (eventOn)
			chekEvent(eventData);
		#if debug
		curStepTxt.text = 'Step ' + curStep;
		#end
		setForScript("curStep", curStep);
		callForScript("onStepHit");
	}

	override function beatHit() 
	{
		super.beatHit();
	
		// if (boifrend.animation.curAnim.finished && curBeat % 2 == 0 &&
		// 	!(controls.holdPressed('note_left') ||controls.holdPressed('note_up') 
		// 	|| controls.holdPressed('note_down') || controls.holdPressed('note_right')))

		iconP1.scale.set(1.2, 1.2);
		iconP2.scale.set(1.2, 1.2);

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (boifrend.animation.curAnim.finished && curBeat % 2 == 0)	
		{
			boifrend.animation.stop();
			boifrend.playAnim('idle');
		}

		if (Dad.animation.curAnim.finished && curBeat % 2 == 0)
		{
			Dad.animation.stop();
			Dad.playAnim('idle');
		}

		if (gf.animation.curAnim.finished || gf.animation.name == 'danceLeft' || gf.animation.name == 'danceRight' || gf.animation.name == 'idle')	
		{
			if (!danceGF)
			{
				if (!(gf.hasAnimation('idle')))
				{gf.animation.stop();gf.playAnim('danceLeft'); danceGF = true;}
				else
				{gf.animation.stop();gf.playAnim('idle'); danceGF = true;}
			}
			else
			{gf.animation.stop();gf.playAnim('danceRight'); danceGF = false;}
				
		}

		if (curBeat % 4 == 0 && zoomCamBit == 0)
			camerasZoom();
		if (zoomCamBit > 0 && curBeat % zoomCamBit == 0 )
			camerasZoom();

		setForScript("curBeat", curBeat);
		callForScript("onBeatHit");
	}


	function SongEnd() 
	{
		
		if (!demo)
		{
			ResultState.Score = score;
			ResultState.Sick = Sick;
			ResultState.Good = Good;
			ResultState.Bad = Bad;
			ResultState.Shit = Shit;
			ResultState.hits = totalPlayed;
			MusicBeatState.switchState(new ResultState());
		}
		else
		{

			PlayState.SONG = Song.loadFromJson(rSong.randSong,rSong.randSong);
            PlayState.EVENT = EventJson.loadJson(rSong.randSong);
            PlayState.songName = rSong.randSong;

			MusicBeatState.switchState(new PlayState());
		}

		// EVENT = null;
		// SONG = null;
	}


	private function generateStaticArrows(player:Int, textur:String = 'NOTE_assets'):Void
	{
		for (i in 0...4)
		{
			var targetAlpha:Float = 1;
		
			var babyArrow:MyStrumNote = new MyStrumNote(0, !ClientSetings.data.downScroll ? NOTE_Y : NOTE_Y_DOWNSCROLL, i, player, textur);

			babyArrow.alpha = 0;
			FlxTween.tween(babyArrow, { alpha: targetAlpha}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			babyArrow.alpha = targetAlpha;

			if (player == 1)
				playerStrums.add(babyArrow);
			else
			{
				dadStrums.add(babyArrow);
			}

			strumLineNotes.add(babyArrow);
			babyArrow.playerPosition();
		}
	}

	var cacheImg = [];
	private function generateSong(dataPath:String):Void
	{
			var songData = SONG;
			if (EVENT.event.length > 0)
				{eventData = EVENT.event; eventOn = true;}
			else 
				eventOn = false;
			
			if (eventOn)
				for (cachesImg in 0 ... eventData.length)
				{
					if (eventData[cachesImg].eventName == 'charactersChange')
						cacheImg.push('assets/images/'+ eventData[cachesImg].value2 + '.png');
				}
			trace(cacheImg);
			for(spriteCaches in cacheImg)
				FlxG.bitmap.add(spriteCaches);
			
			// trace(eventData[0]);
			trace( 'Bf charector ' + songData.player1);
			trace( 'Dad charector ' + songData.player2);
			trace( 'Gf charector ' + songData.player3);
			trace( 'bpm ' + songData.bpm);
			Conductor.changeBPM(songData.bpm);

			curSong = songData.song;
			setForScript("curSong", curSong);

			trace(songData.song);
			// if (SONG.needsVoices)
			// 	vocals = new FlxSound().loadEmbedded("assets/music/" + curSong + "_Voices" + TitleState.soundExt);
			// else
			// 	vocals = new FlxSound();
	
			// FlxG.sound.list.add(vocals);

			inst = FlxG.sound.load(Sound.fromFile("assets/songs/"+ songName +"/Inst.ogg"), 1, false);


			var voicesOpPath:String = "assets/songs/" + songName + "/Voices-Opponent.ogg";
			var voicesPlPath:String = "assets/songs/" + songName + "/Voices-Player.ogg";
			var voicesPath:String = "assets/songs/" + songName + "/Voices.ogg";

			if (FileSystem.exists(voicesOpPath))
				voicesOp = new FlxSound().loadEmbedded(Sound.fromFile(voicesOpPath));
			else
				voicesOp = new FlxSound();

			if (FileSystem.exists(voicesPlPath))
				voicesPl = new FlxSound().loadEmbedded(Sound.fromFile(voicesPlPath));
			else
				voicesPl = new FlxSound();
			
			if (voicesPl.length == 0)
				if (FileSystem.exists(voicesPath))
					voicesPl.loadEmbedded(Sound.fromFile(voicesPath));

			FlxG.sound.list.add(voicesOp);
			FlxG.sound.list.add(voicesPl);


			var deadSfxPath:String = 'assets/sounds/fnf_loss_sfx.ogg';
			var deadSongPath:String = 'assets/music/gameOver.ogg';

			if (FileSystem.exists(deadSfxPath))
				deadSfx = new FlxSound().loadEmbedded(Sound.fromFile(deadSfxPath));
			if (FileSystem.exists(deadSongPath))
				deadSong = new FlxSound().loadEmbedded(Sound.fromFile(deadSongPath));
			
			if (SONG.song != 'Tutorial')
				camZooming = true;

			stage = new Stagebg(songData.stage);

			Dad = new BF(stage.dad_pos[0], stage.dad_pos[1], songData.player2, false, true);
			setForScript("Dad", Dad);
			
			gf = new BF(stage.gf_pos[0], stage.gf_pos[1], songData.player3, false, true);
			setForScript("Gf", gf);
	
			boifrend = new BF(stage.bf_pos[0], stage.bf_pos[1], songData.player1);
			setForScript("Bf", boifrend);

			// if(girlfriendCameraOffset == null)
			girlfriendCameraOffset = [gf.getMidpoint().x + gf.xPosCam + stage.gf_cam_pos[0], gf.getMidpoint().y + gf.yPosCam + stage.gf_cam_pos[1]];

			// if(DadCameraOffset == null)
			DadCameraOffset = [Dad.getMidpoint().x + Dad.xPosCam + stage.dad_cam_pos[0], Dad.getMidpoint().y + Dad.yPosCam + stage.dad_cam_pos[1]];

			// if(boyfriendCameraOffset == null)
			boyfriendCameraOffset = [boifrend.getMidpoint().x - boifrend.xPosCam - stage.bf_cam_pos[0], boifrend.getMidpoint().y + boifrend.yPosCam + stage.bf_cam_pos[1]];

			deadBf = new BF(stage.bf_pos[0], stage.bf_pos[1], 'bf-dead');

			defaultCamZoom = stage.camZoom;
			setForScript("defaultCamZoom", defaultCamZoom);

			camDead.zoom = defaultCamZoom;
			if (boifrend.flipX)
				boifrend.flipX = false;
			else
				boifrend.flipX = true;

			if (deadBf.flipX)
				deadBf.flipX = false;
			else
				deadBf.flipX = true;

			if (SONG.player2 == 'camellia')
				{Dad.flipX = false;}


			notes = new FlxTypedGroup<Note>();
			notes.cameras = [camHUD];
			// add(notes);
			unspawnNotes = [];
			var noteData:Array<SwagSection>;
	
			// NEW SHIT
			noteData = songData.notes;
	
			var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
			
			var oldNote:Note = null;
			var daBpm:Int = Conductor.bpm;
			for (section in noteData)
			{
				if (section.changeBPM && daBpm != section.bpm)
					daBpm = section.bpm;
	
				for (i in 0 ... section.sectionNotes.length)
				{
					final songNotes: Array<Dynamic> = section.sectionNotes[i];
					var daStrumTime:Float = songNotes[0];
					var daNoteData:Int = Std.int(songNotes[1] % 4);
					var gottaHitNote:Bool ;
					var noteType:String = songNotes[3];
					if (SONG.format == 'psych_v1' || SONG.format == 'psych_v1_convert')
						gottaHitNote = (songNotes[1] < 4);
					else
					{
						gottaHitNote = section.mustHitSection;

						if (songNotes[1] > 3)
						{
							gottaHitNote = !section.mustHitSection;
						}
					}
					
					// if (unspawnNotes.length > 0)
					// 	oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
					// else
					// 	oldNote = null;
	
					var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote);
					swagNote.noteType = noteType;
					swagNote.mustPress = gottaHitNote;
					swagNote.sustainLength = songNotes[2];
					swagNote.scrollFactor.set(0, 0);
	
					var susLength:Float = swagNote.sustainLength;
	
					susLength = susLength / Conductor.StepBit;
					unspawnNotes.push(swagNote);

					var curStepCrochet:Float = 60 / daBpm * 1000 / 4.0;
					final roundSus:Int = Math.round(swagNote.sustainLength / curStepCrochet);
					for (susNote in 0...roundSus)
					{
						oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
	
						var sustainNote:Note = new Note(daStrumTime + (Conductor.StepBit * susNote) + Conductor.StepBit, daNoteData, oldNote, true);
						sustainNote.scrollFactor.set();
						unspawnNotes.push(sustainNote);
	
						sustainNote.mustPress = gottaHitNote;
	
						if (sustainNote.mustPress)
						{
							sustainNote.x += FlxG.width / 2 + 35; // смещение трейла длинной ноты 
						}
						else
						{
							sustainNote.x += 40;
						}
					}
	
					swagNote.mustPress = gottaHitNote;
					if (swagNote.mustPress)
					{
						swagNote.x += FlxG.width / 2 - 25; // смещение стрелки 
					}
					else
					{
						swagNote.x += -20;
					}
					
					
				}
				daBeats += 1;
			}
	
			trace(unspawnNotes.length);
			// playerCounter += 1;
	
			unspawnNotes.sort(sortByTime);

			for(i in 0 ... unspawnNotes.length)
			{
				var key = unspawnNotes[i].noteData;
				if(!unspawnNotes[i].mustPress)
				{
						//unspawnNotes[i].textyre = 'NOTE_assets_Lycur';
						unspawnNotes[i].reloadNote();
						unspawnNotes[i].x = dadStrums.members[key].x + (dadStrums.members[key].width - unspawnNotes[i].width) / 2;
						
						if(unspawnNotes[i].isSustainNote)
							unspawnNotes[i].x = dadStrums.members[key].x + (dadStrums.members[key].width - unspawnNotes[i].width) / 2;
							// unspawnNotes[i].x -= 17;
						if(!ClientSetings.data.opponentStrums)
							unspawnNotes[i].alpha =  0;
				}
				if(unspawnNotes[i].mustPress)
				{
					//unspawnNotes[i].textyre = 'NOTE_assets_Lycur';
					unspawnNotes[i].reloadNote();
					unspawnNotes[i].x = playerStrums.members[key].x + (playerStrums.members[key].width - unspawnNotes[i].width) / 2;
					if(unspawnNotes[i].isSustainNote)
						unspawnNotes[i].x = playerStrums.members[key].x + (playerStrums.members[key].width - unspawnNotes[i].width) / 2;
				}
			}

	
			generatedMusic = true;
			// trace('LOADED FROM JSON: ' + songData.notes);
	}

	public static function sortByTime(Obj1:Dynamic, Obj2:Dynamic):Int
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	function sortByShit(Obj1:Note, Obj2:Note):Int
		{
			if (Obj1.lowPriority && !Obj2.lowPriority)
				return 1;
			else if (!Obj1.lowPriority && Obj2.lowPriority)
				return -1;
	
			return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
		}

	function goodNoteHit(note:Note):Void
	{

		if (note.wasGoodHit) return;

		health += 0.012;
		if (health >= 1)
			health = 1;
		if (health >= 1)
			healthDad.visible = false;
		else
			healthDad.visible = true;
		// if (health < 1)
		// 	healthDad.x += 4.37;
		note.wasGoodHit = true;

		randomScore = Std.random(100);

		voicesPl.volume = 1;
		var hitTime = Math.round((Conductor.songPosition - note.strumTime )*100) / 100;
		if (!note.isSustainNote)
		{
			totalPlayed++;
			combo++;
			#if debag
			timeClik.text = '$hitTime'  ;
			#end
			ratingHit(hitTime);
		}
		if (combo <= 250)
			score += 150;
		else if (combo <= 350)
			score += 200;
		else if (combo <= 400)
			score += 250 + randomScore;
		else if (combo <= 1000)
			score += 300 + randomScore;
		else if (combo >= 1000)
			score += 500 + randomScore;
				
		boopScoreText();
		// trace('combo' + combo+' score '+score);
		// note.
		if (note.noteType == "GF Sing")
		{
			if(gf.not_hold_play_animation)
				if (!note.isSustainNote)
					gf.playAnim(singAnim[note.noteData], true);
			if(!(gf.not_hold_play_animation))
				gf.playAnim(singAnim[note.noteData], true);
		}

		if (note.noteType == "Hey!")
			boifrend.playAnim('hey', true);

		if (note.noteType != "No Animation" && note.noteType != "GF Sing"  && note.noteType != "Hey!")
			boifrend.playAnim(singAnim[note.noteData], true);
		if (note.prevNote.noteType != "No Animation" && note.prevNote.noteType != "GF Sing"  && note.prevNote.noteType != "Hey!")
			boifrend.playAnim(singAnim[note.noteData], true);

		if(!debag)
		{
			var spr = playerStrums.members[note.noteData];
			if(spr != null) spr.playAnim('confirm', true);
		}
		else strumPlayAnim(false, Std.int(Math.abs(note.noteData)), Conductor.StepBit * 1.25 / 1000 / 1);
		
		// if(!note.isSustainNote) invalidateNote(note);

		invalidateNote(note);

		healthDad.makeGraphic(Std.int(720 * (1 - health)), 16,FlxColor.fromRGB(Dad.healthbar_colors[0], Dad.healthbar_colors[1], Dad.healthbar_colors[2]));
	}
	
	function opponentNoteHit(note:Note) {

		if (voicesOp.length <= 0)
			voicesPl.volume = 1;

		if (ClientSetings.data.healthDown)
			if (health > 0.05)
				health -= 0.009;

		if (health >= 1)
			healthDad.visible = false;
		else
			healthDad.visible = true;

		if (SONG.song == 'Tutorial' || note.noteType == "GF Sing")
		{
			if(gf.not_hold_play_animation)
				if (!note.isSustainNote)
					gf.playAnim(singAnim[note.noteData], true);
			if(!(gf.not_hold_play_animation))
				gf.playAnim(singAnim[note.noteData], true);
		}

		if (note.noteType == "Hey!")
			Dad.playAnim('hey', true);

		if (note.noteType != "No Animation" && note.noteType != "GF Sing" && note.noteType != "Hey!")
			{
				// if(Dad.not_hold_play_animation)
				// 	if (!note.isSustainNote)
				// 		Dad.playAnim(singAnim[note.noteData], true);
				// if(!(Dad.not_hold_play_animation))
				// 	Dad.playAnim(singAnim[note.noteData], true);
				Dad.playAnim(singAnim[note.noteData], true);
			}

		strumPlayAnim(true, Std.int(Math.abs(note.noteData)), Conductor.StepBit * 1.25 / 1000 / 1);

		// if(!note.isSustainNote) invalidateNote(note);
		invalidateNote(note);

		healthDad.makeGraphic(Std.int(720 * (1 - health)), 16,FlxColor.fromRGB(Dad.healthbar_colors[0], Dad.healthbar_colors[1], Dad.healthbar_colors[2]));
	}

	public function invalidateNote(note:Note):Void {
		note.kill();
		notes.remove(note, true);
		note.destroy();
	}

	function movetCam() 
	{

		if(noTweenCamB)
		{
			DadCameraOffset = girlfriendCameraOffset;
			boyfriendCameraOffset = girlfriendCameraOffset;
		}
		var sec:Int = Std.int(curStep / 16);


		if (generatedMusic && PlayState.SONG.notes[sec] != null)
		{
			if (curBeat % 4 == 0)
			{
				// trace(PlayState.SONG.notes[sec].mustHitSection);
			}
			if (camFollow.x != Dad.getMidpoint().x + 150 && !PlayState.SONG.notes[sec].mustHitSection)
			{
				camFollow.setPosition(DadCameraOffset[0] + 150, DadCameraOffset[1] - 100);

				if (SONG.song.toLowerCase() == 'tutorial')
				{
					tweenCamIn();
				}
			}
	
			if (PlayState.SONG.notes[sec].mustHitSection && camFollow.x != boifrend.getMidpoint().x - 100)
			{
				camFollow.setPosition(boyfriendCameraOffset[0] - 100, boyfriendCameraOffset[1] - 100);
	
				if (SONG.song.toLowerCase() == 'tutorial')
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.StepBit * 4 / 1000), {ease: FlxEase.elasticInOut});
				}
			}
		}		
	}

	function tweenCamIn():Void
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.StepBit * 4 / 1000), {ease: FlxEase.elasticInOut});
	
	function updateScoreText() 
	{
		#if !neko
		scoreTxt.text = 'Score : ' + score + ' | Combo : ' + combo + ' | Misses : '+ miss + ' | Rating : '  + (Math.round(ratingPercent * 100 * 100) / 100)+ '%' + ' - ' + ratingName + ' ('+ AssessmentName+')';
			scoreBG.makeGraphic(scoreTxt.text.length * 13, 30,FlxColor.fromString('#000000'));
			scoreBG.screenCenter(X);
			scoreBG.updateHitbox();
		#end
	}
	
	var scoreTxtTween:FlxTween;
	var scoreBgTween:FlxTween;
	function boopScoreText() 
	{
		// scoreBG.makeGraphic(scoreTxt.text.length * 13, 30,FlxColor.fromString('#000000'));
		// scoreBG.screenCenter(X);
		// scoreBG.updateHitbox();

		if(scoreTxtTween != null)
			scoreTxtTween.cancel();

		scoreTxt.scale.set(1.075, 1.075);
		scoreTxtTween = FlxTween.tween(scoreTxt.scale, {x: 1, y: 1}, 0.2, {
			onComplete: function(twn:FlxTween) {
				scoreTxtTween = null;
			}
		});

		// if(scoreBgTween != null)
		// 	scoreBgTween.cancel();

		// scoreBG.scale.set(1.075, 1.075);
		// scoreBgTween = FlxTween.tween(scoreBG.scale, {x: 1, y: 1}, 0.2, {
		// 	onComplete: function(twn:FlxTween) {
		// 		scoreBgTween = null;
		// 	}
		// });
	}

	function nowPlay():Void 
	{
		textCurSong = new FlxText(-500,125,0, curSong);
		textCurSong.setFormat('assets/fonts/vcr.ttf', 25, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		textCurSong.scrollFactor.set();
		textCurSong.borderSize = 1.25;
		textCurSong.cameras = [camHUD];

		Nowplaying = new FlxText(-500,90,0, 'Now playing');
		Nowplaying.setFormat('assets/fonts/vcr.ttf', 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		Nowplaying.scrollFactor.set();
		Nowplaying.borderSize = 1.25;
		Nowplaying.cameras = [camHUD];


		bgBlac = new FlxSprite (-500,45);
		bgBlac.makeGraphic (300, 150,FlxColor.BLACK);
		bgBlac.cameras = [camHUD];

		bgBlue = new FlxSprite (-500,45);
		bgBlue.makeGraphic (300, 150,FlxColor.BLUE);
		bgBlue.cameras = [camHUD];

		add(bgBlue);
		add(bgBlac);
		add(textCurSong);
		add(Nowplaying);
		nowPlayTween();
	}
	public var scoreBG:FlxSprite;
	function scoreTxt_and_BG():Void
	{
		scoreTxt = new FlxText(0, FlxG.height - 60, FlxG.width, "Yes", 20);
		scoreTxt.setFormat('assets/fonts/vcr.ttf', 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		scoreTxt.borderSize = 1.25;
		scoreTxt.cameras = [camHUD];

		scoreBG = new FlxSprite(0, scoreTxt.y - 5);
		scoreBG.makeGraphic (scoreTxt.text.length * 250, 30,FlxColor.fromString('#000000'));
		scoreBG.cameras = [camHUD];
		scoreBG.alpha = 0.7;
		scoreBG.screenCenter(X);

		add(scoreBG);
		add(scoreTxt);
	}

	public var healthBg:FlxSprite;
	public var healthDad:FlxSprite;
	public var healthBf:FlxSprite;
	var HEALTBAR_Y:Int = 590;
	var HEALTBAR_Y_DOWNSCROLL:Int = 55;
	public dynamic function updateIconsScale(elapsed:Float)
	{
		var mult:Float = FlxMath.lerp(1, iconP1.scale.x, Math.exp(-elapsed * 9 ));
		iconP1.scale.set(mult, mult);
		iconP1.updateHitbox();

		var mult:Float = FlxMath.lerp(1, iconP2.scale.x, Math.exp(-elapsed * 9 ));
		iconP2.scale.set(mult, mult);
		iconP2.updateHitbox();
	}
	public function updateIcons(elapsed:Float)
	{
		if (iconP1.iSize == 2)
			iconP1.animation.curAnim.curFrame = (Std.int(health*100) < 20) ? 1 : 0;
		else
			iconP1.animation.curAnim.curFrame = (Std.int(health*100) < 20) ? 1 : (Std.int(health*100) > 80) ? 2 : 0;
		
		if (iconP2.iSize == 2)
			iconP2.animation.curAnim.curFrame = (Std.int(health*100) > 80) ? 1 : 0  ; 
		else
			iconP2.animation.curAnim.curFrame = (Std.int(health*100) > 80) ? 1 : (Std.int(health*100) < 20) ? 2 : 0  ; 
	
		midllPosIcon = healthBf.x + ((healthBf.width - 150) * (1 - health)) + 50;
		if(Std.int(iconP1.x * 100) != Std.int(midllPosIcon * 100))
		{
			iconP1.x = FlxMath.lerp(midllPosIcon, iconP1.x, Math.exp(-elapsed * 9 ));
			iconP2.x = iconP1.x - 120;
		}

		updateIconsScale(elapsed);
	}
	var midllPosIcon:Float = 0;
	function healthBar():Void
	{
		
		healthBg = new FlxSprite(0, !ClientSetings.data.downScroll ? HEALTBAR_Y : HEALTBAR_Y_DOWNSCROLL);
		healthBg.makeGraphic (740, 25,FlxColor.fromString('#000000'));
		healthBg.cameras = [camHUD];
		healthBg.scrollFactor.set();
		healthBg.screenCenter(X);
		
		healthDad = new FlxSprite(healthBg.x + 10 , healthBg.y + 4);
		healthDad.makeGraphic(Std.int(720 * (1 - health)), 16,FlxColor.fromRGB(Dad.healthbar_colors[0], Dad.healthbar_colors[1], Dad.healthbar_colors[2]));
		healthDad.cameras = [camHUD];
		healthDad.scrollFactor.set();
		

		healthBf = new FlxSprite(0, healthBg.y + 4);
		healthBf.makeGraphic (720, 16,FlxColor.fromRGB(boifrend.healthbar_colors[0], boifrend.healthbar_colors[1], boifrend.healthbar_colors[2]));
		healthBf.cameras = [camHUD];
		healthBf.scrollFactor.set();
		healthBf.screenCenter(X);

		iconP1 = new HealthIcon('bf', true);
		iconP1.y = healthBg.y - 75;
		iconP1.cameras = [camHUD];
		midllPosIcon = healthBf.x + ((healthBf.width - iconP1.width) * (1 - health)) + 50;
		iconP1.x = midllPosIcon;

		iconP2 = new HealthIcon('cat', false);
		iconP2.y = healthBg.y - 75;
		iconP2.cameras = [camHUD];
		iconP2.x = iconP1.x - 120;

		
		add(healthBg);
		add(healthBf);
		add(healthDad);

		add(iconP2);
		add(iconP1);
		
	}

	function nowPlayTween() {
		FlxTween.tween(textCurSong, { x: 30, y: 125 }, (Conductor.StepBit * 4 / 1000) , {ease: FlxEase.bounceOut, startDelay: 3 })
			.then(FlxTween.tween(textCurSong, { x: -500 }, 1, { ease: FlxEase.bounceOut, startDelay: 3}));
		FlxTween.tween(Nowplaying, { x: 20, y: 90 }, (Conductor.StepBit * 4 / 1000) , {ease: FlxEase.bounceOut, startDelay: 3 })
			.then(FlxTween.tween(Nowplaying, { x: -500 }, 1, { ease: FlxEase.bounceOut, startDelay: 3}));	
		FlxTween.tween(bgBlue, { x: 30, y: 45 }, (Conductor.StepBit * 4 / 1000) , {ease: FlxEase.bounceOut, startDelay: 3 })
			.then(FlxTween.tween(bgBlue, { x: -500 }, 1, { ease: FlxEase.bounceOut, startDelay: 3}));
		FlxTween.tween(bgBlac, { x: 0, y: 45 }, (Conductor.StepBit * 4 / 1000) , {ease: FlxEase.bounceOut, startDelay: 3 })
			.then(FlxTween.tween(bgBlac, { x: -500 }, 1, { ease: FlxEase.bounceOut, startDelay: 3} ));
	}

	function timer() {
		timerTxt = new FlxText(0, 0, FlxG.width, '00:00');
		timerTxt.setFormat('assets/fonts/vcr.ttf', 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timerTxt.scrollFactor.set();
		timerTxt.borderSize = 1.25;
		timerTxt.cameras = [camHUD];

		add(timerTxt);
	}


	var alphaText:Bool = true;
	function debugModText() {
		if (alphaText){
			debugTxt.alpha -= 0.01;
		}
		else
		{
			debugTxt.alpha += 0.01;
		}
		if (debugTxt.alpha == 0){
			alphaText=false;
		}
		else if (debugTxt.alpha == 1)
		{
			alphaText=true;
		}
	}

	function strumPlayAnim(isDad:Bool, key:Int, time:Float) 
	{
		var spr:MyStrumNote = null;
		if(isDad) {
			spr = dadStrums.members[key];
		} else {
			spr = playerStrums.members[key];
		}

		if(spr != null) {
			spr.playAnim('confirm', true);
			spr.resetAnim = time;
		}
	}

	public function noteMiss(daNote:Note) {
		daNote.missNote = true;
		voicesPl.volume = 0;
		pressMiss(daNote.noteData, daNote.isSustainNote);
	}
	public function pressMiss(key:Int, isHoldNota:Bool) {
		health -= 0.03;
		totalPlayed++;
		healthDad.visible = true;
		if (health <= 0)
			health = 0;
		if (!isHoldNota)
			FlxG.sound.play("assets/sounds/missnote"+ (Std.random(2)+1) +".ogg", 0.15);
		boifrend.playAnim(missAnim[key], true);
		miss++;
		score-= 12;
		combo = 0;
		healthDad.makeGraphic(Std.int(720 * (1 - health)), 16,FlxColor.fromRGB(Dad.healthbar_colors[0], Dad.healthbar_colors[1], Dad.healthbar_colors[2]));
		totalNotesHit += 0;
		ratingPercent = Math.min(1, Math.max(0, totalNotesHit / totalPlayed));
	}

	var iEvent:Int = 0;
	private function chekEvent(evData:Array<Events>) 
	{
		if (curStep == evData[iEvent].step)
		{
			if(evData[iEvent].eventName == "PlayAnimate")
			{
				playAnimate(evData[iEvent].value1 , evData[iEvent].value2);
			}
			if(evData[iEvent].eventName == "charactersChange")
			{
				charactersChange(evData[iEvent].value1 , evData[iEvent].value2);
				trace('characters Change');
			}
			if(evData[iEvent].eventName == "noTweenCam")
			{
				noTweenCam(evData[iEvent].value1 , evData[iEvent].value2);
				trace('no Move Camera');
			}
			if(evData[iEvent].eventName == "camerasZoom")
			{
				camerasZoom(evData[iEvent].value1 , evData[iEvent].value2);
				trace('cameras Zoom');
			}
			if(evData[iEvent].eventName == "bitZoom")
			{
				bitZoom(evData[iEvent].value1 , evData[iEvent].value2);
				trace('cameras Zoom');
			}		
			if(evData[iEvent].eventName == "defZoom")
			{
				defZoom(evData[iEvent].value1 , evData[iEvent].value2);
				trace('defolt zoom');
			}	
			
			iEvent = iEvent < evData.length - 1 ? iEvent + 1 : evData.length - 1;
		}
	}
	private function charactersChange(v1:String, v2:String) 
	{
		switch (v1)
		{
			case 'bf':
				boifrend.personagaChange(v2);
				boyfriendCameraOffset = [boifrend.getMidpoint().x - boifrend.xPosCam - stage.bf_cam_pos[0], boifrend.getMidpoint().y + boifrend.yPosCam + stage.bf_cam_pos[1]];
				if (boifrend.flipX)
					boifrend.flipX = false;
				else
					boifrend.flipX = true;
				healthBf.color = FlxColor.fromRGB(boifrend.healthbar_colors[0], boifrend.healthbar_colors[1], boifrend.healthbar_colors[2]);
			case 'dad':
				Dad.personagaChange(v2);
				DadCameraOffset = [Dad.getMidpoint().x + Dad.xPosCam + stage.dad_cam_pos[0], Dad.getMidpoint().y + Dad.yPosCam + stage.dad_cam_pos[1]];
				healthDad.color = FlxColor.fromRGB(Dad.healthbar_colors[0], Dad.healthbar_colors[1], Dad.healthbar_colors[2]);
			case 'gf':
				gf.personagaChange(v2);
				girlfriendCameraOffset = [gf.getMidpoint().x + gf.xPosCam + stage.gf_cam_pos[0], gf.getMidpoint().y + gf.yPosCam + stage.gf_cam_pos[1]];

		}	
	}
	private function playAnimate(v1:String, v2:String)
	{
		switch (v1)
		{
			case 'bf':
				boifrend.animation.stop();
				boifrend.playAnim(v2);
			case 'dad':
				Dad.animation.stop();
				Dad.playAnim(v2);
			case 'gf':
				gf.animation.stop();
				gf.playAnim(v2);		
		}		
	}
	public var noTweenCamB:Bool = false;
	private function noTweenCam(v1:String = 'false', v2:String) {
		if (v1 == 'false')
			noTweenCamB = false;
		if (v1 == 'true')
			noTweenCamB = true;
	}
	private function camerasZoom(v1:String = "1", v2:String = "1") {
		if (camZooming && FlxG.camera.zoom < 1.35 )
		{
			FlxG.camera.zoom += 0.015 * Std.parseFloat(v1);
			camHUD.zoom += 0.03 * Std.parseFloat(v2);
		}	
	}
	private var zoomCamBit:Int = 0;
	private function bitZoom(v1:String = "0", v2:String)
		zoomCamBit = Std.parseInt(v1);

	private function defZoom(v1:String = "0", v2:String = "0")
	{
		if (Std.parseFloat(v1) == 0)
		{
			defaultCamZoom = stage.camZoom;
			setForScript("defaultCamZoom", defaultCamZoom);
		}
		else
		{
			defaultCamZoom = Std.parseFloat(v1);
			setForScript("defaultCamZoom", defaultCamZoom);
		}
	}


	public function ChekKey():Void
	{
		var holdArray:Array<Bool> = [];
		var pressArray:Array<Bool> = [];
		var releaseArray:Array<Bool> = [];

		for (key in keysArray)
		{

			pressArray.push(controls.justPressed(key));
			holdArray.push(controls.holdPressed(key));
			releaseArray.push(controls.justReleased(key));
		}

		//нажата ли клавиша
		if (pressArray.contains(true))
			for (i in 0...pressArray.length)
				if(pressArray[i])
					keyPresed(i);

		if (generatedMusic)
			{
				if (notes.length > 0) {
					for (n in notes) { // I can't do a filter here, that's kinda awesome
						var canHit:Bool = (n != null && n.canBeHit
							&& n.mustPress && !n.tooLate && !n.wasGoodHit && !n.blockHit );
	
						if (canHit && n.isSustainNote) {
							var released:Bool = !holdArray[n.noteData];
	
							if (!released)
								goodNoteHit(n);
						}
					}
				}
			}
		
		// trace(releaseArray[1]);
		//Отпущена ли клавиша
		if( releaseArray.contains(true))
			for (i in 0...releaseArray.length)
				if(releaseArray[i])
					keyReleased(i);
	}

	public function keyPresed(key:Int) {
		if(debag) return;

		var lastTime:Float = Conductor.songPosition;

		// if(Conductor.songPosition >= 0) Conductor.songPosition = FlxG.sound.music.time + Conductor.offset;

		// obtain notes that the player can hit
		var noteHitBlat: Array<Note> = notes.members.filter(function(n:Note):Bool {
			var canHit:Bool = n != null && !strumsBlocked[n.noteData] && n.canBeHit && n.mustPress && !n.tooLate && !n.wasGoodHit && !n.blockHit;
			return canHit && n.noteData == key && !n.isSustainNote;
		});
		noteHitBlat.sort(sortByShit);

		if (noteHitBlat.length  != 0){
			var iaEbalEtiNots:Note =  noteHitBlat[0];

			if (noteHitBlat.length > 1) {
				var doubleNote:Note = noteHitBlat[1];

				if (iaEbalEtiNots.noteData == doubleNote.noteData)
				{
					// если до ноты осталось 0 мс, то мы ее удаляем
					if (Math.abs(doubleNote.strumTime - iaEbalEtiNots.strumTime) < 1.0)
						invalidateNote(doubleNote);
					else if (doubleNote.strumTime < iaEbalEtiNots.strumTime)
					{
						// replace the note if its ahead of time (or at least ensure "doubleNote" is ahead)
						iaEbalEtiNots = doubleNote;
					}
				}
			}
			if (!iaEbalEtiNots.ignoreNote)
					goodNoteHit(iaEbalEtiNots);
			else
			{
				pressMiss(key,false);
				invalidateNote(iaEbalEtiNots);
			}
				
		}
		else
			if (!ClientSetings.data.ghostTap)
				pressMiss(key,false);

		
		var spr:MyStrumNote = playerStrums.members[key];
		if(strumsBlocked[key] != true && spr != null && spr.animation.curAnim.name != 'confirm')
		{
			spr.playAnim('pressed');
			spr.resetAnim = 0;
		}

		Conductor.songPosition = lastTime;

	}


	// Отпущена ли клавиша
	private function keyReleased(key:Int)
	{
		if(debag || !startedCountdown || key < 0 || key >= playerStrums.length) return;

		
		var spr:MyStrumNote = playerStrums.members[key];
		if(spr != null)
		{
			spr.playAnim('static');
			spr.resetAnim = 0;
		}
	}

	public var totalPlayed:Int = 0;
	public var ratingPercent:Float;
	public var totalNotesHit:Float = 0.0;
	public var ratingName:String = '?';
	public var Sick:Int = 0;
    public var Good:Int = 0;
    public var Bad:Int = 0;
    public var Shit:Int = 0;
	var Assessment:Array<String> = ['PFC', 'SFC' , 'GFC', 'FC', 'BFC', 'SDCB', 'Clear'];
	var AssessmentName:String = '?';
	function ratingHit(timeHit:Float) {
        var rating = new FlxSprite();
		var path:String = "assets/images/sick.png";
		if (timeHit >= 0)
		{
			if (timeHit <= ClientSetings.data.sickHit)
			{
				path = "assets/images/sick.png";
				totalNotesHit += 1;
				Sick += 1;
			}
			else if (timeHit <= ClientSetings.data.goodHit)
			{
				path = "assets/images/good.png";
				totalNotesHit += 0.67;
				Good += 1;
			}
			else if (timeHit <= ClientSetings.data.badHit)
			{
				path = "assets/images/bad.png";
				totalNotesHit += 0.34;
				Bad += 1;
			}
			else
			{
				path = "assets/images/shit.png";
				totalNotesHit += 0.05;
				Shit += 1;
			}
		}
		else
		{
			if (timeHit >= ClientSetings.data.sickHit *(-1))
			{
				path = "assets/images/sick.png";
				totalNotesHit += 1;
				Sick += 1;
			}
			else if (timeHit >= ClientSetings.data.goodHit *(-1))
			{
				path = "assets/images/good.png";
				totalNotesHit += 0.67;
				Good += 1;
			}
			else if (timeHit >= ClientSetings.data.badHit *(-1))
			{
				path = "assets/images/bad.png";
				totalNotesHit += 0.34;
				Bad += 1;
			}
			else
			{
				path = "assets/images/shit.png";
				totalNotesHit += 0.05;
				Shit += 1;
			}
		}
		ratingPercent = Math.min(1, Math.max(0, totalNotesHit / totalPlayed));
		for (i in 0...ratingStuff.length - 1)
			if(ratingPercent <= ratingStuff[i][1])
				ratingName = ratingStuff[i][0];
		for(i in 0 ... Assessment.length)
		{
			if (Good < 1 && Bad < 1 && Shit < 1)
				AssessmentName = Assessment[1];
			else if (Bad < 1 && Shit < 1)
				AssessmentName = Assessment[2];
			else if (Shit < 1)
				AssessmentName = Assessment[3];
			else if (Shit > 0)
				AssessmentName = Assessment[4];
			if (miss > 0 && miss <= 10)
				AssessmentName = Assessment[5];
			if (miss > 10)
				AssessmentName = Assessment[6];
		}
        rating.loadGraphic(path);
        rating.scale.x = 0.7;
        rating.scale.y = 0.7;
        rating.x = 700;
        rating.y = 500;
		rating.acceleration.y = 550 * 1 * 1;
		rating.velocity.y -= FlxG.random.int(140, 175) * 1;
		rating.velocity.x -= FlxG.random.int(0, 10) * 1;
		rating.antialiasing = true;
        rating.updateHitbox();
        add(rating);
        rating.cameras = [camGame];

		var comboSpr = new FlxSprite();
		comboSpr.loadGraphic("assets/images/combo.png");
        comboSpr.scale.x = 0.5;
        comboSpr.scale.y = 0.5;
        comboSpr.x = 150 + rating.x;
        comboSpr.y = 80 + rating.y;
		comboSpr.acceleration.y = 550 * 1 * 1;
		comboSpr.velocity.y -= FlxG.random.int(140, 175) * 1;
		comboSpr.velocity.x -= FlxG.random.int(0, 10) * 1;
		comboSpr.antialiasing = true;
        comboSpr.updateHitbox();
		if (combo >= 10 || combo == 0)
        	add(comboSpr);
        comboSpr.cameras = [camGame];


		var daLoop:Int = 0;
		var xThing:Float = 0;

		var separatedScore:String = Std.string(combo).lpad('0', 3);
		for (i in 0...separatedScore.length)
		{
			var numScore:FlxSprite = new FlxSprite();
			numScore.loadGraphic("assets/images/num" + Std.parseInt(separatedScore.charAt(i)) + ".png");
			// trace("assets/images/num" + Std.parseInt(separatedScore.charAt(i)) + ".png");
			numScore.scale.x = 0.6;
			numScore.scale.y = 0.6;
			numScore.x = (43 * daLoop) - 90 + rating.x;
			numScore.y += 80 + rating.y;
			numScore.acceleration.y = FlxG.random.int(200, 300) * 1 * 1;
			numScore.velocity.y -= FlxG.random.int(140, 160) * 1;
			numScore.velocity.x = FlxG.random.float(-5, 5) * 1;
			numScore.antialiasing = true;
			numScore.cameras = [camGame];
			numScore.updateHitbox();
			if (combo >= 10 || combo == 0)
				add(numScore);

			FlxTween.tween(numScore, {alpha: 0}, 0.2 / 1, {
				onComplete: function(tween:FlxTween)
				{
					numScore.destroy();
				},
				startDelay: Conductor.Bit * 0.002 / 1
			});

			daLoop++;
			if(numScore.x > xThing) xThing = numScore.x;
		}
        FlxTween.tween(rating, {alpha: 0}, 0.2 / 1, {
			onComplete: function(tween:FlxTween)
				{
					rating.destroy();
				},
			startDelay: Conductor.Bit * 0.001 / 1
		});
		FlxTween.tween(comboSpr, {alpha: 0}, 0.2 / 1, {
			onComplete: function(tween:FlxTween)
				{
					comboSpr.destroy();
				},
			startDelay: Conductor.Bit * 0.001 / 1
		});
    }

	function initHxScript(file:String) {
		try
		{
			HScript = new HsShit();
			var scriptsString:String = HScript.loadScriptFile(file);
			// trace(scriptsString);
			try 
			{
				var scriptPar = HScript.parShit.parseString(scriptsString);
				// trace(scriptPar);
				HScript.loadScript(scriptPar);
			}
			catch (e:Dynamic)
			{
				trace("Ошибка в скрипте : ", e);
				onErrorScript(e);
			}
		}
		catch (e:Dynamic)
		{
			trace("Ошибка инцализации скрипта : ", e);
			onErrorScript(e);
		}
	}
	function setForScript(variable:String, arg:Dynamic) 
	{
		HScript.intShit.variables.set(variable, arg);
	}

	//Эта поебень предназначена для синхранизации переменых скриптов и игры нахуй
	//Для чего я взялся за скрипты, я в душе не ебу
	//Бля ещё надо придумать как спрайты созданные в скрипте добовлять в игру 
	function callForScript(nameFunction:String, arg:Dynamic = null) 
	{
		try
		{
			if (HScript.intShit.variables.exists(nameFunction)) 
			{
				if (arg != null)
					HScript.intShit.variables.get(nameFunction)(arg);
				else
					HScript.intShit.variables.get(nameFunction)();
			}	
		}
		catch (e:Dynamic)
		{
			trace("Ошибка инцилизации функции : ", e);
			onErrorScript(e);
		}
	}

	private function onErrorScript(e:Dynamic):Void {
        e.preventDefault(); // Предотвращаем стандартное поведение (например, краш)
        
		var errorMsg = "CRASH: " + Std.string(e);
		

        var errorMsg:String = "Произошла критическая ошибка:\n";
        
        if (e != null) {
            errorMsg += Std.string(e) + "\n\nStack Trace:\n" + haxe.CallStack.toString(haxe.CallStack.exceptionStack());
        } else {
            errorMsg += "Неизвестная ошибка.";
        }

        sys.io.File.saveContent("crash_log.txt", errorMsg); // Запись в файл

        // Выводим окно с ошибкой
        Application.current.window.alert(errorMsg, "Error!");
		Sys.exit(1);
    }
}
	