package objects;

import funkin.vis.dsp.SpectralAnalyzer.Bar;
import data.Vis;
import flxanimate.FlxAnimate;

class ABot extends Vis{

    //Было адаптированно с Psych Engine 

    final VIZ_MAX 							= 7; //ranges from viz1 to viz7
	final VIZ_POS_X:Array<Float> 			= [0, 59, 56, 66, 54, 52, 51];
	final VIZ_POS_Y:Array<Float> 			= [0, -8, -3.5, -0.4, 0.5, 4.7, 7];

	public var bg:FlxSprite					= null;
	public var vizSprites:Array<FlxSprite> 	= [];
	public var eyeBg:FlxSprite				= null;
	public var eyes:FlxAnimate				= null;
	public var speaker:FlxAnimate			= null;

	var volumes:Array<Float> 				= [];


    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);

        trace('Create ABot? Yes!!');

        var antialias = ClientSetings.data.antialiasing;
        
        NUM_BARS = VIZ_MAX;

		bg = new FlxSprite(90, 20).loadGraphic(Img.load('characters/abot/stereoBG'));
		bg.antialiasing = antialias;
		add(bg);

        trace('Create ABot? Yes!! YESSSSSS!!');

		var vizX:Float = 0;
		var vizY:Float = 0;
        var texABotViz = FlxAtlasFrames.fromSparrow(Img.load('characters/abot/aBotViz'), 'assets/images/characters/abot/aBotViz.xml');
		var vizFrames = texABotViz;
		for (i in 1...VIZ_MAX+1)
		{
			volumes.push(0.0);
			vizX += VIZ_POS_X[i-1];
			vizY += VIZ_POS_Y[i-1];
			var viz:FlxSprite = new FlxSprite(vizX + 140, vizY + 74);
			viz.frames = vizFrames;
			viz.animation.addByPrefix('VIZ', 'viz$i', 0);
			viz.animation.play('VIZ', true);
			viz.animation.curAnim.finish(); //make it go to the lowest point
			viz.antialiasing = antialias;
			vizSprites.push(viz);
			viz.updateHitbox();
			viz.centerOffsets();
			add(viz);
		}

		eyeBg = new FlxSprite(-30, 215).makeGraphic(1, 1, FlxColor.WHITE);
		eyeBg.scale.set(160, 60);
		eyeBg.updateHitbox();
		add(eyeBg);

        trace('Create Eyes!!');
		eyes = new FlxAnimate(0, 0);
        eyes = Img.loadAtlosAnimate('characters/abot/systemEyes');
		eyes.anim.addBySymbolIndices('lookleft', 'a bot eyes lookin', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17], 24, false);
		eyes.anim.addBySymbolIndices('lookright', 'a bot eyes lookin', [18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35], 24, false);
		eyes.anim.play('lookright', true);
		eyes.anim.curFrame = eyes.anim.length - 1;
		add(eyes);

        trace('Create Speaker!!');

		speaker = new FlxAnimate(0, 0);
        speaker = Img.loadAtlosAnimate('characters/abot/abotSystem');
		speaker.anim.addBySymbol('anim', 'Abot System', 24, false);
		speaker.anim.play('anim', true);
		speaker.anim.curFrame = speaker.anim.length - 1;
		speaker.antialiasing = antialias;
		add(speaker);

    }

    public function set_pos() {
        speaker.x -= 65;
		speaker.y -= 10;

        eyes.x -= 10;
        eyes.y += 230;
	}


    #if funkin.vis
	var levels:Array<Bar>					= null;
	var levelMax:Int 						= 0;
	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if(analyzer == null) return;

		levels = analyzer.getLevels(levels);
		var oldLevelMax = levelMax;
		levelMax = 0;
		for (i in 0...Std.int(Math.min(vizSprites.length, levels.length)))
		{
			var animFrame:Int = Math.round(levels[i].value * 5);
			animFrame = Std.int(Math.abs(FlxMath.bound(animFrame, 0, 5) - 5)); // shitty dumbass flip, cuz dave got da shit backwards lol!
		
			vizSprites[i].animation.curAnim.curFrame = animFrame;
			levelMax = Std.int(Math.max(levelMax, 5 - animFrame));
		}

		if(levelMax >= 4)
		{
			//trace(levelMax);
			if(oldLevelMax <= levelMax && (levelMax >= 5 || speaker.anim.curFrame >= 3))
				beatHit();
		}
	}
	#end

    public function beatHit()
	{
		speaker.anim.play('anim', true);
	}

    var lookingAtRight:Bool 				= true;
	public function lookLeft()
	{
		if(lookingAtRight) eyes.anim.play('lookleft', true);
		lookingAtRight = false;
	}
	public function lookRight()
	{
		if(!lookingAtRight) eyes.anim.play('lookright', true);
		lookingAtRight = true;
	}

}