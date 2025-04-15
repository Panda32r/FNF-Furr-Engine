package backend;

class Conductor
{
    public static var bpm:Int = 100;
    public static var Bit:Float = ((60 / bpm) * 1000); //Считаем  биты в милисекунды 
    public static var StepBit:Float = Bit / 4; // Считаем шаги до каждово бита в милисекундах
    public static var songPosition:Float;
	public static var lastSongPos:Float;
	public static var offset:Float = 0;

    public static var safeFrames:Int = 10;
	public static var safeZoneOffset:Float = (safeFrames / 60) * 1000; // is calculated in create(), is safeFrames in milliseconds

    public function new() 
    {
    }

    public static function changeBPM(newBPM:Int)
    {
        bpm = newBPM;
        
        Bit = ((60 / bpm) * 1000);
        StepBit = Bit / 4;
    } 
    
}
