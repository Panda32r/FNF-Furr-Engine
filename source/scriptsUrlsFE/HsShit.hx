package scriptsUrlsFE;

import flixel.tweens.FlxEase;
import haxe.io.Path;
import scriptsUrlsFE.TweenEaseAll;

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
                intShit.variables.set("Bf", game.boyfriend);
                intShit.variables.set("Gf", game.gf);
                intShit.variables.set("defaultCamZoom", game.defaultCamZoom);
                intShit.variables.set("camGame", game.camGame);
                intShit.variables.set("camHUD", game.camHUD);
                intShit.variables.set("camDead", game.camDead);
                intShit.variables.set("camOther", game.camOther);
                intShit.variables.set("add", game.add);
                intShit.variables.set("playerStrums", game.playerStrums);
                intShit.variables.set("dadStrums", game.dadStrums);
                intShit.variables.set("spleshPlayer", game.spleshPlayer);
                intShit.variables.set("unspawnNotes", game.unspawnNotes);
                intShit.variables.set("startingSong", game.startingSong);
                // intShit.variables.set("global", {});
            }
        intShit.variables.set("Sprite", FlxSprite);
        intShit.variables.set("doTween", FlxTween.tween);
        intShit.variables.set("Color", FlxColor.fromString);
        intShit.variables.set("lerp", FlxMath.lerp);
        intShit.variables.set("exp", Math.exp);
        intShit.variables.set("ease", TweenEaseAll.SelectEase);
        intShit.variables.set("Array", Array);

        intShit.variables.set("allEase", TweenEaseAll.getAllEaseNames());

        intShit.variables.set("loadImage", 
                                function(sprite:FlxSprite, path:String) {
                                        var spr = BitmapData.fromFile('assets/images/'+ path );
                                        sprite.loadGraphic(spr);
                                });
        intShit.variables.set("loadAnimImage", 
                                function(sprite:FlxSprite, path:String) {
                                        var imgpng = BitmapData.fromFile('assets/images/'+ path + '.png');
                                        var imgxml = File.getContent('assets/images/' + path + '.xml');
                                        var tex = FlxAtlasFrames.fromSparrow(imgpng, imgxml);
                                        sprite.frames = tex;
                                });

        intShit.variables.set("noteTweenBfX", 
                                function(?tag:String, key:Int, value:Float, time:Float, ease:String = 'linear') {
                                        doTweenNotePlayer(key, {x: value}, time, ease, tag);
                                });     
        intShit.variables.set("noteTweenBfY", 
                                function(?tag:String, key:Int, value:Float, time:Float, ease:String = 'linear') {
                                        doTweenNotePlayer(key, {y: value}, time, ease, tag);
                                });  
        intShit.variables.set("noteTweenDadX", 
                                function(?tag:String, key:Int, value:Float, time:Float, ease:String = 'linear') {
                                        doTweenNoteOpponent(key, {x: value}, time, ease, tag);
                                });  
        intShit.variables.set("noteTweenDadY", 
                                function(?tag:String, key:Int, value:Float, time:Float, ease:String = 'linear') {
                                        doTweenNoteOpponent(key, {y: value}, time, ease, tag);
                                });

        intShit.variables.set("doTweenAlpha", 
                                function(?tag:String, spr:Dynamic, value:Float, time:Float, ease:String = 'linear') {
                                        doTweenAlpha(spr, {alpha: value}, time, ease, tag);
                                });

        intShit.variables.set("doTweenX", 
                                function(?tag:String, spr:Dynamic, value:Float, time:Float, ease:String = 'linear') {
                                        doTween(spr, {x: value}, time, ease, tag);
                                });
        intShit.variables.set("doTweenY", 
                                function(?tag:String, spr:Dynamic, value:Float, time:Float, ease:String = 'linear') {
                                        doTween(spr, {y: value}, time, ease, tag);
                                });

    }

    public function doTweenNotePlayer(key:Int, data:Dynamic, time:Float, easeFlx:String, tag:String) 
    {
        trace('Tween Startit!!');
        var spr:Dynamic = PlayState.instance.playerStrums.members[key % PlayState.instance.playerStrums.length];
        var sprSpl:Dynamic = PlayState.instance.spleshPlayer.members[key % PlayState.instance.spleshPlayer.length];
        if(tag != null)
        {
            FlxTween.tween(spr, data, time, {
                ease: TweenEaseAll.SelectEase(easeFlx),
                onComplete: function(twn:FlxTween) {
                    game.callForScript("onTweenCompleted", tag);
                }
            });
            // FlxTween.tween(sprSp, data, time, {ease: TweenEaseAll.SelectEase(easeFlx)});
        }
        else
        {
            FlxTween.tween(spr, data, time, {ease: TweenEaseAll.SelectEase(easeFlx)});
            // FlxTween.tween(sprSp, data, time, {ease: TweenEaseAll.SelectEase(easeFlx)});
        }
        FlxTween.tween(sprSpl, data, time, {ease: TweenEaseAll.SelectEase(easeFlx)});
    }

    
    public function doTweenNoteOpponent(key:Int, data:Dynamic, time:Float, easeFlx:String, tag:String) 
    {
        trace('Tween Startit!!');
        var spr:Dynamic = PlayState.instance.dadStrums.members[key % PlayState.instance.dadStrums.length];
        if(tag != null)
        {
            FlxTween.tween(spr, data, time, {
                ease: TweenEaseAll.SelectEase(easeFlx),
                onComplete: function(twn:FlxTween) {
                    game.callForScript("onTweenCompleted", tag);
                }
            });
            // FlxTween.tween(sprSp, data, time, {ease: TweenEaseAll.SelectEase(easeFlx)});
        }
        else
        {
            FlxTween.tween(spr, data, time, {ease: TweenEaseAll.SelectEase(easeFlx)});
            // FlxTween.tween(sprSp, data, time, {ease: TweenEaseAll.SelectEase(easeFlx)});
        }
    }

    public function doTweenAlpha(spr:Dynamic, data:Dynamic, time:Float, easeFlx:String, tag:String) {
        if(tag != null)

            FlxTween.tween(spr, data, time, {
                ease: TweenEaseAll.SelectEase(easeFlx),
                onComplete: function(twn:FlxTween) {
                    game.callForScript("onTweenCompleted", tag);
                }
            });

        else

            FlxTween.tween(spr, data, time, {ease: TweenEaseAll.SelectEase(easeFlx)});

    }

    public function doTween(spr:Dynamic, data:Dynamic, time:Float, easeFlx:String, tag:String) {
        if(tag != null)

            FlxTween.tween(spr, data, time, {
                ease: TweenEaseAll.SelectEase(easeFlx),
                onComplete: function(twn:FlxTween) {
                    game.callForScript("onTweenCompleted", tag);
                }
            });

        else

            FlxTween.tween(spr, data, time, {ease: TweenEaseAll.SelectEase(easeFlx)});

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
