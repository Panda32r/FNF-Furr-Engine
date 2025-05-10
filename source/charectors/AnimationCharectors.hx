package charectors;
 

typedef FilePersonaga = {

    var animations:Array<Anim>;
    
    var no_antialiasing:Bool;
    var image:String;
    var position:Array<Int>;
    var flip_x:Bool;
    var camera_position:Array<Int>;
    var scale:Float;
    var healthbar_colors:Array<Int>;
    var not_hold_play_animation:Bool;
}

typedef Anim = {
	var anim:String;
	var name:String;
	var fps:Int;
	var loop:Bool;
	var indices:Array<Int>;
	var offsets:Array<Int>;
}