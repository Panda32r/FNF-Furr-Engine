package;
import lime.app.Application;
import states.LogoState;
#if !neko
#if windows
import debug.FPSCounter;
#end
#end
import flixel.FlxGame;
import openfl.display.Sprite;
import states.PlayState;
import states.TitleState;

import openfl.Lib;
import flash.events.UncaughtErrorEvent;

class Main extends Sprite
{	
	#if !neko
	#if windows
	public static var fpsVar:FPSCounter;
	#end
	#end
	var game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		zoom: -1.0, // game state bounds
		// initialState: TitleState, // initial game state

		#if !neko
		initialState:LogoState, // initial game state
		#end

		#if neko
		initialState:PlayState, // initial game state
		#end
		
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};


	public function new()
	{
		super();
		addChild(new FlxGame(game.width, game.height, game.initialState,  game.framerate, game.framerate, game.skipSplash, game.startFullscreen));
		#if !neko
		#if windows
		fpsVar = new FPSCounter(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		#end
		#end
		Controls.instance = new Controls();
		stage.color = null;

		// FlxG.game.focusLostFramerate = 60;
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);

	}

	private function onUncaughtError(e:UncaughtErrorEvent):Void {
        #if !neko
        e.preventDefault(); // Предотвращаем стандартное поведение (например, краш)
        
		var errorMsg = "CRASH: " + Std.string(e);
		

        var errorMsg:String = "Произошла критическая ошибка:\n";
        
        if (e != null) {
            errorMsg += Std.string(e) + "\n\nStack Trace:\n" + haxe.CallStack.toString(haxe.CallStack.exceptionStack());
        } else {
            errorMsg += "Неизвестная ошибка.";
        }

        sys.io.File.saveContent("crash_log.txt", errorMsg); // Запись в файл

        // Выводим окно с ошибкой
        Application.current.window.alert(errorMsg, "Error!");
		Sys.exit(1);
		#end
    }
}

