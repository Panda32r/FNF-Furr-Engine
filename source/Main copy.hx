package;
#if !neko
#if windows
import debug.FPSCounter;
#end
#end
import flixel.FlxGame;
import openfl.display.Sprite;
import states.PlayState;
import states.TitleState;

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
		initialState: TitleState, // initial game state
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
	}

}

