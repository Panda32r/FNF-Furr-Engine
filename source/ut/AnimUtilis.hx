package ut;

class AnimUtilis {
    
    public static function addOffset(animOffsets:Map<String, Array<Dynamic>>, name:String, x:Float = 0, y:Float = 0)
    {
        animOffsets[name] = [x, y];
    }
}