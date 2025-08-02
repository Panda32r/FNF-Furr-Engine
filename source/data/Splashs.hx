package data;

typedef DataSpleshs = {
    var textyra:String;
    
    var size:Float;

    var left:Array<AnimSplash>;
    var down:Array<AnimSplash>;
    var up:Array<AnimSplash>;
    var right:Array<AnimSplash>;
}

typedef AnimSplash = {
    var anim:Array<String>;
    var offset:Array<Float>;
    var fps:Int;
}