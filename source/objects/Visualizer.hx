package objects;

import funkin.vis.dsp.SpectralAnalyzer;


class Visualizer extends FlxSpriteGroup
{
    static final NUM_BARS:Int = 53;
    static final BAR_WIDTH:Int = 20;
    static final BAR_SPACING:Int = 5;
    static final MAX_HEIGHT:Float = 150;

    public var bars:Array<FlxSprite> = [];

    public var snd(default, set):FlxSound;

    #if funkin.vis
	var analyzer:SpectralAnalyzer;
	#end
    function set_snd(sound:FlxSound)
    {
        if (sound == null || !sound.exists) {
        snd = null;
        analyzer = null;
        return null;
        }
        trace(sound);
        snd = sound;
        trace(snd);
        #if funkin.vis
		initAnalyzer();
		#end
        return snd;
    }

    public function new(x:Float = 0, y:Float = 0, umb_lines:Int = 30)
    {
        super(x, y);
        // NUM_BARS = umb_lines;
        for (i in 0...NUM_BARS)
        {
            var bar = new FlxSprite();
            bar.makeGraphic(BAR_WIDTH, 1, FlxColor.WHITE);
            bar.x = i * (BAR_WIDTH + BAR_SPACING);
            bar.y = y;
            bar.origin.y = bar.height;
            add(bar);
            bars.push(bar);
        }
    }

    
    #if funkin.vis
    var levels:Array<Bar>;
    // var levelMax:Int = 0;
    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (analyzer == null) return;
        if (levels == null) levels = new Array<Bar>();
        
        // trace(analyzer);
        levels = analyzer.getLevels(levels);
        if (levels.length == 0) return;

        for (i in 0...bars.length)
        {
            if (i >= levels.length) break;
            
            var level = FlxMath.bound(levels[i].value * 1.5, 0, 1);
            bars[i].scale.y = level * MAX_HEIGHT;
            bars[i].updateHitbox();
            bars[i].offset.y = bars[i].height;
            
            bars[i].color = FlxColor.interpolate(
                FlxColor.BLUE, 
                FlxColor.RED, 
                level
            );
        }
    }
    #end
    #if funkin.vis
    //Я конечно хуй знает как оно работает, но оно работает 
	public function initAnalyzer()
	{
        @:privateAccess
        if (snd == null || snd._channel == null) 
        {
            trace("Sound or channel is null!");
            return;
        }
        
        try {
            @:privateAccess
            final audioSource = snd._channel.__audioSource;
            if (audioSource == null) 
            {
                trace("AudioSource is null!");
                return;
            }
            trace(audioSource.length);
            // Исправление для новых версий Lime
            analyzer = new SpectralAnalyzer(
                audioSource, // Используем буфер напрямую
                NUM_BARS,
                0.1,
                40
            );
            
            #if desktop
            analyzer.fftN = 256;
            #end
            
        } catch(e:Dynamic) {
            trace("Analyzer error: " + e);
        }

        
		// @:privateAccess
        // {
        //     trace(snd);
    	
        //     analyzer = new SpectralAnalyzer(snd._channel.__audioSource, NUM_BARS, 0.1, 40);
        // }
		// #if desktop
		// // On desktop it uses FFT stuff that isn't as optimized as the direct browser stuff we use on HTML5
		// // So we want to manually change it!
		// analyzer.fftN = 256;
		// #end
	}
	#end
}