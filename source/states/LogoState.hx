package states;

import flixel.FlxState;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;

class LogoState extends FlxState
{
 private var head:FlxSprite;
 private var text1:FlxSprite;
 private var text2:FlxSprite;

 private var camFollow:FlxObject;

 private var camOther:FlxCamera;

    override public function create():Void
	{
        super.create();
        ClientSetings.loadPrefs();

        camOther = new FlxCamera();
        camOther.bgColor = FlxColor.BLACK;
        FlxG.cameras.reset(camOther);
        camOther.zoom = 1;

        if(!ClientSetings.data.skipLogoEngine)
        {
            camFollow = new FlxObject(0, 0);

            camFollow.setPosition(FlxG.width/2, FlxG.height/2);
            add(camFollow);

            FlxG.camera.follow(camFollow, LOCKON, 0.04);

            var cadrs = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38];
            head = new FlxSprite(-0,-550);
            var headTex= FlxAtlasFrames.fromSparrow('assets/images/LogoEngine/Logo_head.png', 'assets/images/LogoEngine/Logo_head.xml');
            head.frames = headTex;
            head.animation.addByIndices('LogoBoop', 'head_finel_anim0', cadrs, "", 24, false);
            // head.animation.addByPrefix('LogoBoop', 'head_finel_anim0');
            head.animation.play('LogoBoop');
            add(head);

            text1 = new FlxSprite(620,-450);
            var text1Tex= FlxAtlasFrames.fromSparrow('assets/images/LogoEngine/Logo_Furr.png', 'assets/images/LogoEngine/Logo_Furr.xml');
            text1.frames = text1Tex;
            text1.animation.addByIndices('LogoBoop', 'text_tween20', cadrs, "", 24, false);
            // text1.animation.addByPrefix('LogoBoop', 'text_tween20');
            text1.animation.play('LogoBoop');
            add(text1);

            text2 = new FlxSprite(530,200);
            var text2Tex= FlxAtlasFrames.fromSparrow('assets/images/LogoEngine/Logo_engine.png', 'assets/images/LogoEngine/Logo_engine.xml');
            text2.frames = text2Tex;
            text2.animation.addByIndices('LogoBoop', 'Text_tween10', cadrs, "", 24, false);
            // text2.animation.addByPrefix('LogoBoop', 'Text_tween10');
            text2.animation.play('LogoBoop');
            add(text2);
        }
        else
        {
            FlxG.switchState(new TitleState());
        }
        
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
        if(!ClientSetings.data.skipLogoEngine)
            if (head.animation.curAnim.finished)
            {
                movetCam();
                if (camOther.zoom >= 0.5)
                    camOther.zoom -= 0.015;
                switchState(new TitleState());
            }

    }

    function movetCam()
    {
        camFollow.setPosition(FlxG.width/2, -1000);	
    }

    public static function switchState(nextState:FlxState = null) 
        {
            if(nextState == null) nextState = FlxG.state;
            if(nextState == FlxG.state)
            {
                resetState();
                return;
            }
    
            if(FlxTransitionableState.skipNextTransIn) FlxG.switchState(nextState);
            else startTransition(nextState);
            FlxTransitionableState.skipNextTransIn = false;
        }
    
        public static function resetState() 
        {
            if(FlxTransitionableState.skipNextTransIn) FlxG.resetState();
            else startTransition();
            FlxTransitionableState.skipNextTransIn = false;
        }
        public static function startTransition(nextState:FlxState = null)
        {
            if(nextState == null)
                nextState = FlxG.state;
    
            FlxG.state.openSubState(new CustomFadeTransition(0.5, false));
            if(nextState == FlxG.state)
                CustomFadeTransition.finishCallback = function() FlxG.resetState();
            else
                CustomFadeTransition.finishCallback = function() FlxG.switchState(nextState);
        }
}