package backend;


class SavePosSongNotGamplay 
{
    public static var isCurStep:Int = 0;
    public static var iSCurBeat:Int = 0;

    public static var isTotalSteps:Int = 0;
    public static var isTotalBeats:Int = 0;

    public static var islastStep:Float = 0;
    public static var islastBeat:Float = 0;    

    public static function loadPos(curStep:Int, curBeat:Int, totalSteps:Int, totalBeats:Int, lastStep:Float, lastBeat:Float) 
    {
        curStep = isCurStep;
        curBeat = iSCurBeat;

        totalSteps = isTotalSteps;
        totalBeats = isTotalBeats;

        lastStep = islastStep;
        lastBeat = islastBeat;
        
    }

    public static function savePos(curStep:Int, curBeat:Int, totalSteps:Int, totalBeats:Int, lastStep:Float, lastBeat:Float) 
    {
        isCurStep = curStep;
        iSCurBeat = curBeat;

        isTotalSteps = totalSteps;
        isTotalBeats = totalBeats;

        islastStep = lastStep;
        islastBeat = lastBeat;
        
    }

    public static function defaltPos(curStep:Int, curBeat:Int, totalSteps:Int, totalBeats:Int, lastStep:Float, lastBeat:Float) 
    {
        isCurStep = curStep = 0;
        iSCurBeat = curBeat = 0;

        isTotalSteps = totalSteps = 0;
        isTotalBeats = totalBeats = 0;

        islastStep = lastStep = 0;
        islastBeat = lastBeat = 0;
        
    }
}