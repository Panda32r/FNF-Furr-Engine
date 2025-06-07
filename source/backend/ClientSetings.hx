package backend;

import flixel.util.FlxSave;
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
	public var cacheSpr: Bool = false;
	public var songHit:Float = 0;

	public var glovOponent:Bool = true;
	public var hidHUD:Bool = false;
	public var hidCombo:Bool = false;
	public var comboCam:Array<String> = ['Game', 'Hud'];
	public var combocam:Int = 0;
	public var stileHPBarArray:Array<String> = ['Furr', 'Psych', 'Vanilla'];
	public var stileHPBarType:Int = 0;
	public var splashArray:Array<String> = ['Vanilla', 'Psych'];
	public var splashType:Int = 0;
	public var splashVisible:Bool = false;
	public var splashAlpha:Float = 0.6;
	public var visualizerVisible:Bool = false;
}

class ClientSetings
{
	public static var data:SaveData = {};
	public static var defaultData:SaveData;

    public static var keyBinds:Map<String, Array<FlxKey>> = 
	[	
		'note_up'		=> [J, UP],
		'note_left'		=> [D, LEFT],
		'note_down'		=> [F, DOWN],
		'note_right'	=> [K, RIGHT],

		'ui_up'			=> [W, UP],
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_right'		=> [D, RIGHT],

		'RESET'			=> [R, R],
		'ACCEPT'		=> [SPACE, ENTER],
		'BACK'			=> [BACKSPACE, ESCAPE],
		'PAUSE'			=> [ENTER, ESCAPE],
		'OPTIONS'		=> [CONTROL, CONTROL],

		'EXIT_DEMO'		=> [ENTER, ESCAPE, BACKSPACE, SPACE, CONTROL]
	];

	public static var keyBindsDef:Map<String, Array<FlxKey>> = [];

	public static function loadPrefs() {
		keyBindsDef = keyBinds;
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
	public static function loadSettingsControls() {
        var save = new FlxSave();
        save.bind('controls_v1');
        if (save.data.keyBinds != null) 
            keyBinds = save.data.keyBinds;
    }
	public static function saveSettingsControls() {
        var save = new FlxSave();
        save.bind('controls_v1'); 
        save.data.keyBinds = keyBinds;
        save.flush();
    }
	public static function saveSettings() {
		for (key in Reflect.fields(data))
			Reflect.setField(FlxG.save.data, key, Reflect.field(data, key));
	}
}