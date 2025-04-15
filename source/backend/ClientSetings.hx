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
		'ui_right'		=> [D, RIGHT]
	];

	public static function loadPrefs() {
		for (key in Reflect.fields(data))
			if (Reflect.hasField(FlxG.save.data, key))
				Reflect.setField(data, key, Reflect.field(FlxG.save.data, key));
	}
	public static function saveSettings() {
		for (key in Reflect.fields(data))
			Reflect.setField(FlxG.save.data, key, Reflect.field(data, key));
	}
}