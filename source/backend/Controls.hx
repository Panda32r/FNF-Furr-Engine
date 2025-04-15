package backend;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class Controls {

    public var keyboardBinds:Map<String, Array<FlxKey>>;

		
	public function holdPressed(key:String) {
		var result:Bool = (FlxG.keys.anyPressed(keyboardBinds[key]) == true);
		return result;
	}
	public function justPressed(key:String) {
		var result:Bool = (FlxG.keys.anyJustPressed(keyboardBinds[key]) == true);
		return result;
	}
	public function justReleased(key:String) {
		var result:Bool = (FlxG.keys.anyJustReleased(keyboardBinds[key]) == true);
		return result;
	}

    public static var instance:Controls;
	public function new()
	{
		keyboardBinds = ClientSetings.keyBinds;
	}
}