package charectors;


import flixel.animation.FlxAnimation;
import haxe.Json;
import openfl.display.BitmapData;

import charectors.AnimationCharectors;

class CharectorsOther extends FlxSprite{
    public var animOffsets:Map<String, Array<Dynamic>>;
    public var tex:FlxAtlasFrames;
    public var imgpng:BitmapData;
    public var imgxml:String;
    public var xPosCam:Float = 0;
    public var yPosCam:Float = 0;
    public var xPos:Int = 0;
    public var yPos:Int = 0;
    public var stunned:Bool = false;
    public var healthbar_colors:Array<Int>;
    public var not_hold_play_animation:Bool = false;
    public var states:String;
    private var changa:Bool = false;
    private var x_changa:Int;
    private var y_changa:Int;
    private var daDad:Bool = false;
    public var name:String;

    
    public var notFoundPathJson:FlxText;
    public function  new(x:Float,y:Float,charactors:String,states:String,flipXCharectors:Bool = false, isDad:Bool = false) {
        super(x, y);
        notFoundPathJson = new FlxText(x + 60, y + 450, 200, '');
		notFoundPathJson.setFormat('assets/fonts/vcr.ttf', 18, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daDad = isDad;
        this.states = states;
        personagaChange(charactors,flipXCharectors);
        
    }

    public var notFound = false;
    public function personagaChange(charactors:String, flipXCharectors:Bool = false)  {
        name = charactors;
        var characterPath = 'assets/images/' + states + '/'+ charactors + '.json';
        trace(characterPath);
        if (!(FileSystem.exists(characterPath)))
        {
            notFoundPathJson.text = 'Not Found characters/' + charactors;
            notFound = true;
            if(daDad)
            {
                healthbar_colors = [255, 95, 95];
                characterPath = 'assets/characters/Catnew-op.json';
            }
            else
            {
                healthbar_colors = [116, 255, 95];
                characterPath = 'assets/characters/Catnew.json';
            }
        }
        else
        {
            notFound = false;
            notFoundPathJson.text = '';
        }

        var charactersJson = File.getContent(characterPath).trim();
        var character:AnimationCharectors.FilePersonaga = Json.parse(charactersJson);

        not_hold_play_animation = character.not_hold_play_animation;
            if (!changa)
                changa = true;
            else
            {
                x -= x_changa;
                y -= y_changa;
            }
            
            trace(character.image);
            if(!notFound)
            {
                imgpng = BitmapData.fromFile('assets/images/'+ states + '/'+ character.image + '.png');
                imgxml = File.getContent('assets/images/'+ states + '/' + character.image + '.xml');
            }
            else
            {
                imgpng = BitmapData.fromFile('assets/images/'+ character.image + '.png');
                imgxml = File.getContent('assets/images/' + character.image + '.xml');
            }
            if(states != "storymenu/props")
            {           
                xPosCam = character.camera_position[0];
                yPosCam = character.camera_position[1];
            }
            xPos = character.position[0];
            yPos = character.position[1];
            animOffsets = new Map<String, Array<Dynamic>>();
            scale.x = character.scale;
            scale.y = character.scale;
            tex = FlxAtlasFrames.fromSparrow(imgpng, imgxml);
            frames = tex;
            
            for (i in 0 ... character.animations.length)
            {
                var characterAnim:Anim = character.animations[i];
                // trace(characterAnim.anim);
                if (characterAnim.anim == 'singLEFT' || characterAnim.anim == 'singDOWN' || characterAnim.anim == 'singUP' || characterAnim.anim == 'singRIGHT')
                    characterAnim.indices = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14];
                if (characterAnim.indices.length > 0)
                    animation.addByIndices(characterAnim.anim, characterAnim.name, characterAnim.indices, "", characterAnim.fps, characterAnim.loop);
                else
                    animation.addByPrefix(characterAnim.anim, characterAnim.name, characterAnim.fps, characterAnim.loop);
                
                addOffset(characterAnim.anim, characterAnim.offsets[0], characterAnim.offsets[1]);
            }
            if (ClientSetings.data.antialiasing)
                antialiasing = !(character.no_antialiasing);
            else
                antialiasing = false;
        
            x += character.position[0];
            y += character.position[1];
            flipX = character.flip_x;
            
            if (hasAnimation('idle'))
                playAnim('idle');
            else
                if (hasAnimation('danceRight'))
                    playAnim('danceRight');
            
            x_changa = character.position[0];
            y_changa = character.position[1];
            
            if (notFound)
            {
                alpha = 0.7;
                color = FlxColor.BLACK;
            }
            else
            {
                healthbar_colors = character.healthbar_colors;
                alpha = 1;
                color = FlxColor.fromString('#FFFFFF');
            }
    }


    public function hasAnimation(animationName:String):Bool
    {
        // Проверяем, существует ли анимация с указанным именем
        var anim:FlxAnimation = animation.getByName(animationName);
        return anim != null;
    }

    public function addOffset(name:String, x:Float = 0, y:Float = 0)
    {
            animOffsets[name] = [x, y];
    }

    public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
        {
            
            animation.play(AnimName, Force, Reversed, Frame);
    
            var daOffset = animOffsets.get(animation.curAnim.name);
            if (animOffsets.exists(animation.curAnim.name))
            {
                offset.set(daOffset[0], daOffset[1]);
            }
        }
}
