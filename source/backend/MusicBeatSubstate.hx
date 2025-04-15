package backend;

import flixel.FlxSubState;

class MusicBeatSubstate extends FlxSubState
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
}