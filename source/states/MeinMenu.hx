package states;

import flixel.util.FlxTimer;

class MeinMenu extends MusicBeatState
{
    public var camGame:FlxCamera;
	public var camHUD:FlxCamera;

    var credits:FlxSprite;
    var freePlay:FlxSprite;
    var options:FlxSprite;
    var storyMode:FlxSprite;

    var menu:Array<String> = ['storymode', 'freeplay', 'credits', 'options'];
    var menuItems:Array<FlxSprite> = [];
    var select:Int = 0;
    var lerpSelected:Float = 0;
    override public function create():Void
    {
        super.create();
        camGame = new FlxCamera();
        camGame.bgColor = FlxColor.fromString('#FFD863');
        FlxG.cameras.reset(camGame);
        camGame.zoom = 1;
    
        camHUD = new FlxCamera();
        camHUD.bgColor = FlxColor.TRANSPARENT; 
        camHUD.width = FlxG.width;
        camHUD.height = FlxG.height;
        camHUD.x = 0;
        camHUD.y = 0;
        FlxG.cameras.add(camHUD);

        if (FlxG.sound.music != null) 
            Conductor.songPosition = FlxG.sound.music.time;

        FlxG.sound.music.onComplete = SongEnd;

        curStep = LevelSelect.isCurStep;
        curBeat = LevelSelect.iSCurBeat;

        totalSteps = LevelSelect.isTotalSteps;
        totalBeats = LevelSelect.isTotalBeats;

        lastStep = LevelSelect.islastStep;
        lastBeat = LevelSelect.islastBeat;

        var bg = new FlxSprite();
        bg.loadGraphic("assets/images/menuBG.png"); // Загружаем изображение
        bg.setGraphicSize(FlxG.width, FlxG.height); // Растягиваем на весь экран
        bg.updateHitbox();
        bg.scrollFactor.set(0, 0); // Фон не должен двигаться при движении камеры
        add(bg);
        bg.cameras = [camGame];

        CreateMenu();
        onSelectMenu();
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        if(controls.justPressed('ui_up'))
        {
            if (!(select <= 0))
                select--; 
            else
                select = menu.length - 1;
            onSelectMenu();
            // trace(select);
        }

        if(controls.justPressed('ui_down'))
        {
            if (!(select >= menu.length - 1))
               select++;
            else
                select = 0;
            onSelectMenu();
            // trace(select);
        }

        if (controls.justPressed('ACCEPT')) 
        {
            if (menu[select] == 'freeplay')
            {   
            var mySound:FlxSound = FlxG.sound.play("assets/sounds/confirmMenu.ogg", 0.4);
            mySound.onComplete = function() 
                { 

                    LevelSelect.isCurStep = curStep;
                    LevelSelect.iSCurBeat = curBeat;

                    LevelSelect.isTotalSteps = totalSteps;
                    LevelSelect.isTotalBeats = totalBeats;

                    LevelSelect.islastStep = lastStep;
                    LevelSelect.islastBeat = lastBeat;

                    FlxG.switchState(new LevelSelect());
                }
            }
            if (menu[select] == 'options')
            {   
            var mySound:FlxSound = FlxG.sound.play("assets/sounds/confirmMenu.ogg", 0.4);
            mySound.onComplete = function() 
                { 

                    LevelSelect.isCurStep = curStep;
                    LevelSelect.iSCurBeat = curBeat;

                    LevelSelect.isTotalSteps = totalSteps;
                    LevelSelect.isTotalBeats = totalBeats;

                    LevelSelect.islastStep = lastStep;
                    LevelSelect.islastBeat = lastBeat;
                }
                MusicBeatState.switchState(new OptinsState());
            }
            new FlxTimer().start(0.6, function(timer:FlxTimer) {
                trace("late 0.8 s!");
                menuEnd = true;
            });
        }

        if (!(menuEnd))
            onUpdateMenu(elapsed);
        else
            onCloseMenu(elapsed);

        if (controls.justPressed('BACK'))
        {
            MusicBeatState.switchState(new TitleState());
            LevelSelect.isCurStep = curStep;
            LevelSelect.iSCurBeat = curBeat;

            LevelSelect.isTotalSteps = totalSteps;
            LevelSelect.isTotalBeats = totalBeats;

            LevelSelect.islastStep = lastStep;
            LevelSelect.islastBeat = lastBeat;
        }
    }

    var thisStepEnd:Int = 0;

    function SongEnd()
    {
        trace('Тут мы будем пустыми чтоб по ржать)');
        curStep = 0;
        curBeat = 0;

        totalSteps = 0;
        totalBeats = 0;

        lastStep = 0;
        lastBeat = 0;
    }

    function CreateMenu()
    {
        for (i in 0 ... menu.length)
        {
            var item:FlxSprite = createMenuItem(menu[i], 70, (i * 120) + 50);
            // item.x = (i == 0) ? - 10: + 0;
            item.visible = true;
            item.antialiasing = true;
            add(item);
            item.cameras = [camHUD];
        }

    }

    function createMenuItem(name:String, x:Float, y:Float):FlxSprite
	{
		var item  = new FlxSprite(x, y);
        var itemTex = FlxAtlasFrames.fromSparrow('assets/images/Menu/'+ name +'.png', 'assets/images/Menu/'+ name +'.xml');
        item.frames = itemTex;
        item.animation.addByPrefix('idle', name +' idle0');
        item.animation.addByPrefix('select', name +' selected0');
        item.animation.play('idle');
        item.scale.set(0.8, 0.8);
		menuItems.push(item);
		return item;
	}
    function onSelectMenu():Void 
    {
        FlxG.sound.play("assets/sounds/scrollMenu.ogg", 0.4);
        for (i in 0...menuItems.length) 
            menuItems[i].animation.play((select == i) ? 'select' : 'idle');
    }

    var menuEnd:Bool = false;
    function onUpdateMenu(elapsed:Float = 0)
    {
        lerpSelected = FlxMath.lerp(select, lerpSelected, Math.exp(-elapsed * 9 ));
        for (i in 0...menuItems.length) 
        {
            // menuItems[i].y = ((i - lerpSelected ) * 120) + 50;
            if (i > select)
                menuItems[i].y = (i * 120) + (60 - lerpSelected);
            if (i < select)
                menuItems[i].y = (i * 120) + (60 + lerpSelected);
            if (i == select)
                menuItems[i].y = (i * 120) + (50 + lerpSelected);
        }
    }

    function onCloseMenu(elapsed:Float = 0)
    {
        lerpSelected = FlxMath.lerp(select, lerpSelected, Math.exp(-elapsed * 9 ));
        for (i in 0...menuItems.length) 
            menuItems[i].y += ((i - lerpSelected) * 20) + 50;
    }   
}