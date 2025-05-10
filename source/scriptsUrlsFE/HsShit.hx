package scriptsUrlsFE;

class HsShit
{
    public var intShit:Interp;
    public var parShit:Parser;
    // var script:String;

    var game:PlayState = PlayState.instance;

    public function new() {

        intShit = new Interp();
        parShit = new Parser();

        // script = loadScriptFile(path);

        // intShit.variables.set("trace", trace);
        // trace('Create Dad for Script');
        // intShit.variables.set("Dad.x", game.Dad.x);
        if(game != null)
            @:privateAccess
            {
                intShit.variables.set("curSong", game.curSong);
                intShit.variables.set("curStep", game.curStep);
                intShit.variables.set("curBeat", game.curBeat);
                intShit.variables.set("Dad", game.Dad);
                intShit.variables.set("Bf", game.boifrend);
                intShit.variables.set("Gf", game.gf);
                intShit.variables.set("defaultCamZoom", game.defaultCamZoom);
                intShit.variables.set("camGame", game.camGame);
                intShit.variables.set("camHUD", game.camHUD);
                intShit.variables.set("camDead", game.camDead);
                intShit.variables.set("add", game.add);
                // intShit.variables.set("global", {});
            }
        intShit.variables.set("Sprite", FlxSprite);
        intShit.variables.set("Color", FlxColor.fromString);
        intShit.variables.set("lerp", FlxMath.lerp);
        intShit.variables.set("exp", Math.exp);
        // intShit.variables.set("FlxG", FlxG);
        // trace('Create function standart');
        intShit.variables.set("onCreatePost", function() {
            if (intShit.variables.exists("onCreatePost")) {
                intShit.variables.get("onCreatePost")();
            }
        });
        intShit.variables.set("onCreate", function() {
            if (intShit.variables.exists("onCreate")) {
                intShit.variables.get("onCreate")();
            }
        });
        intShit.variables.set("onUpdate", function(elapsed:Float) {
            if (intShit.variables.exists("onUpdate")) {
                intShit.variables.get("onUpdate")(elapsed);
            }
        });
        intShit.variables.set("onUpdatePost", function(elapsed:Float) {
            if (intShit.variables.exists("onUpdatePost")) {
                intShit.variables.get("onUpdatePost")(elapsed);
            }
        });
        intShit.variables.set("onStepHit", function() {
            if (intShit.variables.exists("onStepHit")) {
                intShit.variables.get("onStepHit")();
            }
        });
        intShit.variables.set("onBeatHit", function() {
            if (intShit.variables.exists("onBeatHit")) {
                intShit.variables.get("onBeatHit")();
            }
        });
    }

    public function loadScriptFile(path:String):String 
    {
        return File.getContent(path); // Читаем файл как текст
    }

    public function loadScript(script:Expr)
    {
        intShit.execute(script);
    }
}
