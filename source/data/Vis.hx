package data;

#if funkin.vis
import funkin.vis.dsp.SpectralAnalyzer;
#end

class Vis extends FlxSpriteGroup{

    public var NUM_BARS:Int                 = 53;

    public var snd(default, set):FlxSound   = null;

    #if funkin.vis
	public var analyzer:SpectralAnalyzer    = null;
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
	}
	#end
}