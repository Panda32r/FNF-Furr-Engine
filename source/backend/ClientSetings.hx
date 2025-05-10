package backend;

import flixel.input.keyboard.FlxKey;

@:structInit class SaveData {
	public var downScroll:Bool = false;
	public var middleScroll:Bool = false;
	public var opponentStrums:Bool = true;
	public var ghostTap:Bool = false; 
	public var sickHit:Int = 45;
	public var goodHit:Int = 90;
	public var badHit:Int = 135;	
	public var skipLogoEngine:Bool = false;		
	public var botPlay:Bool = false;
	public var healthDown:Bool = false;
	public var FPSmax:Int = 60;
	public var antialiasing:Bool = true;
	public var unlimitFPS: Bool = false;
}

class ClientSetings
{
	public static var data:SaveData = {};
	public static var defaultData:SaveData = {};

    public static var keyBinds:Map<String, Array<FlxKey>> = 
	[	
		'note_up'		=> [J, UP],
		'note_left'		=> [D, LEFT],
		'note_down'		=> [F, DOWN],
		'note_right'	=> [K, RIGHT],

		'RESET'			=> [R],
		'ACCEPT'		=> [SPACE, ENTER],
		'BACK'			=> [BACKSPACE, ESCAPE],
		'PAUSE'			=> [ENTER, ESCAPE],
		'OPTIONS'		=> [CONTROL],

		'ui_up'			=> [W, UP],
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_right'		=> [D, RIGHT],

		'EXIT_DEMO'		=> [ENTER, ESCAPE, BACKSPACE, SPACE, CONTROL]
	];

	public static function loadPrefs() {
		for (key in Reflect.fields(data))
			if (Reflect.hasField(FlxG.save.data, key))
				Reflect.setField(data, key, Reflect.field(FlxG.save.data, key));

		if(data.FPSmax > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = data.FPSmax;
			FlxG.drawFramerate = data.FPSmax;
		}
		else
		{
			FlxG.drawFramerate = data.FPSmax;
			FlxG.updateFramerate = data.FPSmax;
		}
	}
	public static function saveSettings() {
		for (key in Reflect.fields(data))
			Reflect.setField(FlxG.save.data, key, Reflect.field(data, key));
	}
}