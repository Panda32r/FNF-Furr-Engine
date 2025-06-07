package backend;

import objects.FurrCamera;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;

class MusicBeatState extends FlxState
{
    private var lastBeat:Float = 0;
	private var lastStep:Float = 0;

	private var totalBeats:Int = 0;
	private var totalSteps:Int = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;
    
    private var curSection:Int = 0;
    private var stepsToDo:Int = 0;

    public var controls(get, never):Controls;
	private function get_controls()
	{
		return Controls.instance;
	}
    
    override function create()
    {
        super.create();
    }

    override function update(elapsed:Float)
    {
        var oldStep:Int = curStep;
        everyStep();
    
        updateCurStep();
        curBeat = Math.round(curStep / 4);

        if( oldStep != curStep )
           {
				if(PlayState.SONG != null)
				{
					if (oldStep < curStep)
						updateSection();
					else
						rollbackSection();
				}

				if (curStep % 4 == 0)
            		beatHit();
			}
        // trace(Conductor.songPosition);
        super.update(elapsed);
    }

    private function everyStep():Void
    {
        if (Conductor.songPosition > lastStep + Conductor.StepBit - Conductor.safeZoneOffset
            || Conductor.songPosition < lastStep + Conductor.safeZoneOffset)
        {
            if (Conductor.songPosition > lastStep + Conductor.StepBit)
            {
                stepHit();
            }
        }
    }

    private function updateCurStep():Void
    {
       curStep = Math.floor(Conductor.songPosition / Conductor.StepBit);
    }

	public function stepHit():Void
    {
        totalSteps += 1;
        lastStep += Conductor.StepBit;
    }
    
    public function beatHit():Void
    {
        lastBeat += Conductor.Bit;
        totalBeats += 1;
    }

    //Всё что находиться снизу по взоимственно с Psych Engine
    private function updateSection():Void
	{
		if(stepsToDo < 1) stepsToDo = Math.round(getBeatsOnSection() * 4);
		while(curStep >= stepsToDo)
		{

			curSection++;
			if( curSection > PlayState.SONG.notes.length - 1)
				curSection = PlayState.SONG.notes.length - 1;
			var beats:Float = getBeatsOnSection();
			stepsToDo += Math.round(beats * 4);
			sectionHit();
		}
	}

	private function rollbackSection():Void
	{
		if(curStep < 0) return;

		var lastSection:Int = curSection;
		curSection = 0;
		stepsToDo = 0;
		for (i in 0...PlayState.SONG.notes.length)
		{
			if (PlayState.SONG.notes[i] != null)
			{
				stepsToDo += Math.round(getBeatsOnSection() * 4);
				if(stepsToDo > curStep) break;
				
				curSection++;
			}
		}

		if(curSection > lastSection) sectionHit();
	}

    public function sectionHit():Void
	{
        // trace('section Hit!');
	}

    function getBeatsOnSection()
	{
		var val:Null<Float> = 4;
		if(PlayState.SONG != null && PlayState.SONG.notes[curSection] != null) val = PlayState.SONG.notes[curSection].sectionBeats;
		return val == null ? 4 : val;
	}

    public var _furrCameraInitialized:Bool = false;
    
    public function initFurrCamera():FurrCamera
	{
		var camera = new FurrCamera();
		FlxG.cameras.reset(camera);
		FlxG.cameras.setDefaultDrawTarget(camera, true);
		FlxG.cameras.bgColor = FlxColor.BLACK;
		_furrCameraInitialized = true;
		//trace('initialized psych camera ' + Sys.cpuTime());
		return camera;
	}

    public static function switchState(nextState:FlxState = null) 
    {
		if(nextState == null) nextState = FlxG.state;
		if(nextState == FlxG.state)
		{
			resetState();
			return;
		}

		if(FlxTransitionableState.skipNextTransIn) FlxG.switchState(nextState);
		else startTransition(nextState);
		FlxTransitionableState.skipNextTransIn = false;
	}

	public static function resetState() 
    {
		if(FlxTransitionableState.skipNextTransIn) FlxG.resetState();
		else startTransition();
		FlxTransitionableState.skipNextTransIn = false;
	}
    public static function startTransition(nextState:FlxState = null)
	{
		if(nextState == null)
			nextState = FlxG.state;

		FlxG.state.openSubState(new CustomFadeTransition(0.5, false));
		if(nextState == FlxG.state)
			CustomFadeTransition.finishCallback = function() FlxG.resetState();
		else
			CustomFadeTransition.finishCallback = function() FlxG.switchState(nextState);
	}
}