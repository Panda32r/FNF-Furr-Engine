package backend;

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
        everyStep();
    
        updateCurStep();
        curBeat = Math.round(curStep / 4);
        
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
    
            if (totalSteps % 4 == 0)
                beatHit();
        }
    
        public function beatHit():Void
        {
            lastBeat += Conductor.Bit;
            totalBeats += 1;
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