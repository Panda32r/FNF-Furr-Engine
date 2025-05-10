package states;

class OptinsState extends MusicBeatState{

    static var selectCategories:Int = 0;
    public var optinsCategories:Array<String> = ['controls', 'graphics', 'preferences', 'visuals'];
    public var optionsPreferences:Array<String> = ['downScroll', 'middleScroll', 'opponentStrums', 'ghostTap', 'healthDown', 'botPlay', 'sickHit', 'goodHit', 'badHit', 'skipLogoEngine'];
    public var optionsGraphics:Array<String> = ['FPSmax', 'unlimitFPS', 'antialiasing'];
    public var options:Array<Dynamic> =[
        ['controls', 'NoN'],
        ['graphics', 'FPSmax', 'unlimitFPS', 'antialiasing'],
        ['preferences', 'downScroll', 'middleScroll', 'opponentStrums', 'ghostTap', 'healthDown', 'botPlay', 'sickHit', 'goodHit', 'badHit', 'skipLogoEngine'],
        ['visuals', 'NoN']
    ];
    var bg:FlxSprite;
    public var camCat:FlxCamera;
    public var camOther:FlxCamera;
    public var camOpt:FlxCamera;
    override public function create():Void
    {	
        super.create();
        
        camOther = new FlxCamera();
        camOther.bgColor = FlxColor.fromString('#FFD863');
        FlxG.cameras.reset(camOther);
        camOther.zoom = 1;
    
        camCat = new FlxCamera();
        camCat.bgColor = FlxColor.TRANSPARENT; 
        camCat.width = FlxG.width;
        camCat.height = FlxG.height;
        camCat.x = 0;
        camCat.y = 0;
        camCat.zoom = 1;
        FlxG.cameras.add(camCat);
        
        bg = new FlxSprite();
        bg.loadGraphic("assets/images/menuDesat.png"); // Загружаем изображение
        bg.setGraphicSize(FlxG.width, FlxG.height); // Растягиваем на весь экран
        bg.updateHitbox();
        bg.scrollFactor.set(0, 0); // Фон не должен двигаться при движении камеры
        add(bg);
        bg.color = FlxColor.fromString('#FFD863');
        bg.cameras = [camOther];

        createMenu();
        updateTextSelect();
    }
    var selectNow:Bool = false;
    var defaultCamZoom:Float = 0.6;
    var lerpSelectedX:Float = 0;
    var lerpSelectedY:Float = 0;
    var select:Int = 0;
    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        if (!selectNow)
        {
            if(controls.justPressed('ui_up'))
            {
                if (!(selectCategories <= 0))
                    selectCategories--; 
                else
                    selectCategories = optinsCategories.length - 1;
                updateTextSelect();
                // trace(select);
            }

            if(controls.justPressed('ui_down'))
            {
                if (!(selectCategories >= optinsCategories.length - 1))
                    selectCategories++;
                else
                    selectCategories = 0;
                updateTextSelect();
                // trace(select);
            }

            if (controls.justPressed('ACCEPT')) 
            {
                menuItemsDop = [];
                createMenuDop();
                selectNow = true;
                select = 0;
                updateSeting();
            }
        }
        else
        {
            if(controls.justPressed('ui_up'))
            {
                if (!(select <= 0))
                    select--; 
                else
                    select = menuItemsDop.length - 1;
                updateSeting();
                // trace(select);
            }

            if(controls.justPressed('ui_down'))
            {
                if (!(select >= menuItemsDop.length - 1))
                    select++;
                else
                    select = 0;
                updateSeting();
                // trace(select);
            }

            if(controls.justPressed('ui_left'))
            {
                updateOptins(-1);
            }
    
            if(controls.justPressed('ui_right'))
            {
                updateOptins(1);
            }

            if(controls.justPressed('ACCEPT'))
            {
                updateOptins(0 , true);
            }

            updateTextsOptions(elapsed);
        }


        if (controls.justPressed('BACK'))
        {
            if (selectNow)
                selectNow = false;
            else
            {
                if (camOpt != null)
                    camOpt.destroy();
                camOpt = new FlxCamera();
                camOpt.bgColor = FlxColor.TRANSPARENT; 
                camOpt.width = FlxG.width;
                camOpt.height = FlxG.height;
                camOpt.x = 300;
                camOpt.y = 0;
                FlxG.cameras.add(camOpt);
                MusicBeatState.switchState(new MeinMenu());
            }
            select = 0;
            _lastVisiblesOptions = [];
        }
        if(selectNow)
        {
            camCat.zoom = FlxMath.lerp(defaultCamZoom, camCat.zoom, Math.exp(-elapsed * 3.125 * 1));
            lerpSelectedX = FlxMath.lerp(400, lerpSelectedX, Math.exp(-elapsed * 9 ));
            lerpSelectedY = FlxMath.lerp(200, lerpSelectedY, Math.exp(-elapsed * 9 ));
            for (i in 0 ... optinsCategories.length)
            {
                menuItems[i].x = 90 - lerpSelectedX;
                menuItems[i].y = ((i * 80) + 60) - lerpSelectedY;
            }
        }
        else
        {
            camCat.zoom = FlxMath.lerp(1, camCat.zoom, Math.exp(-elapsed * 3.125 * 1));
            lerpSelectedX = FlxMath.lerp(0, lerpSelectedX, Math.exp(-elapsed * 9 ));
            lerpSelectedY = FlxMath.lerp(0, lerpSelectedY, Math.exp(-elapsed * 9 ));
            for (i in 0 ... optinsCategories.length)
            {
                menuItems[i].x = 90 - lerpSelectedX;
                menuItems[i].y = ((i * 120) + 60) - lerpSelectedY;
            }
            if (camOpt != null)
                camOpt.destroy();
        }
    }
    var menuItemsDop:Array<FlxText> = [];
    function createMenuDop()
    {
        menuItemsDop = [];
        if (camOpt != null)
            camOpt.destroy();
        camOpt = new FlxCamera();
        camOpt.bgColor = FlxColor.TRANSPARENT; 
        camOpt.width = FlxG.width;
        camOpt.height = FlxG.height;
        camOpt.x = 300;
        camOpt.y = 0;
        FlxG.cameras.add(camOpt);

        var dynamicOptions:Array<Dynamic> = options[selectCategories];
        for (j in 0 ... dynamicOptions.length - 1)
        {
            var item:FlxText = createMenuItem(dynamicOptions[j+1], 90, (j * 30) + 30);
            item.visible = false;
            item.y = (j * 120) + 60;
            item.cameras = [camOpt];
            menuItemsDop.push(item);
            add(item);
        }

    }

    function updateSeting() {
        FlxG.sound.play("assets/sounds/scrollMenu.ogg", 0.4);
        var dynamicOptions:Array<Dynamic> = options[selectCategories];
        for (i in 0...menuItemsDop.length) 
        {
            menuItemsDop[i].alpha = (i == select) ? 1 : 0.6;
            if (dynamicOptions[i+1] == 'ghostTap')
                menuItemsDop[i].text = 'Ghost Tap  => ' + ClientSetings.data.ghostTap;
            if (dynamicOptions[i+1] == 'downScroll')
                menuItemsDop[i].text = 'Down Scroll  => ' + ClientSetings.data.downScroll;
            if (dynamicOptions[i+1] == 'middleScroll')
                menuItemsDop[i].text = 'Middle Scroll  => ' + ClientSetings.data.middleScroll;
            if (dynamicOptions[i+1] == 'opponentStrums')
                menuItemsDop[i].text = 'Opponent Strums  => ' + ClientSetings.data.opponentStrums;
            if (dynamicOptions[i+1] == 'botPlay')
                menuItemsDop[i].text = 'BotPlay  => ' + ClientSetings.data.botPlay;
            if (dynamicOptions[i+1] == 'healthDown')
                menuItemsDop[i].text = 'Health Down  => ' + ClientSetings.data.healthDown;
            if (dynamicOptions[i+1] == 'skipLogoEngine')
                menuItemsDop[i].text = 'Skip Logo Engine  => ' + ClientSetings.data.skipLogoEngine;
            if (dynamicOptions[i+1] == 'FPSmax')
                menuItemsDop[i].text = 'FPS max  => ' + ClientSetings.data.FPSmax ;
            if (dynamicOptions[i+1] == 'sickHit')
                menuItemsDop[i].text = 'Sick!!  => ' + ClientSetings.data.sickHit +'ms';
            if (dynamicOptions[i+1] == 'goodHit')
                menuItemsDop[i].text = 'Good!  => ' + ClientSetings.data.goodHit +'ms';
            if (dynamicOptions[i+1] == 'badHit')
                menuItemsDop[i].text = 'bad...  => ' + ClientSetings.data.badHit +'ms';
            if (dynamicOptions[i+1] == 'unlimitFPS')
                menuItemsDop[i].text = 'Unlimited FPS => ' + ClientSetings.data.unlimitFPS ;
            if (dynamicOptions[i+1] == 'antialiasing')
                menuItemsDop[i].text = 'Antialiasing => ' + ClientSetings.data.antialiasing ;
            
            
        }
    }

    var NewSeting:Bool;
    function updateOptins(keyLR:Int = 0, KeyAccept:Bool = false)
    {
        var dynamicOptions:Array<Dynamic> = options[selectCategories];
        for (i in 0...dynamicOptions.length - 1) 
        {
            if (i == select)
            {
                if (dynamicOptions[i+1] == 'ghostTap')
                {
                    if(KeyAccept)
                        NewSeting = !(ClientSetings.data.ghostTap);
                    ClientSetings.data.ghostTap = NewSeting ;
                }
                if (dynamicOptions[i+1] == 'downScroll')
                {
                    if(KeyAccept)
                        NewSeting = !(ClientSetings.data.downScroll);
                    ClientSetings.data.downScroll = NewSeting ;
                }
                if (dynamicOptions[i+1] == 'middleScroll')
                {
                    if(KeyAccept)
                        NewSeting = !(ClientSetings.data.middleScroll);
                    ClientSetings.data.middleScroll = NewSeting ;
                }
                if (dynamicOptions[i+1] == 'opponentStrums')
                {
                    if(KeyAccept)
                        NewSeting = !(ClientSetings.data.opponentStrums);
                    ClientSetings.data.opponentStrums = NewSeting ;
                }
                if (dynamicOptions[i+1] == 'skipLogoEngine')
                {
                    if(KeyAccept)
                        NewSeting = !(ClientSetings.data.skipLogoEngine);
                    ClientSetings.data.skipLogoEngine = NewSeting ;
                }
                if (dynamicOptions[i+1] == 'botPlay')
                {
                    if(KeyAccept)
                        NewSeting = !(ClientSetings.data.botPlay);
                    ClientSetings.data.botPlay = NewSeting ;
                }
                if (dynamicOptions[i+1] == 'healthDown')
                {
                    if(KeyAccept)
                        NewSeting = !(ClientSetings.data.healthDown);
                    ClientSetings.data.healthDown = NewSeting ;
                }
                if (dynamicOptions[i+1] == 'antialiasing')
                {
                    if(KeyAccept)
                        NewSeting = !(ClientSetings.data.antialiasing);
                    ClientSetings.data.antialiasing = NewSeting ;
                }
                if (dynamicOptions[i+1] == 'unlimitFPS')
                {
                    if(KeyAccept)
                        NewSeting = !(ClientSetings.data.unlimitFPS);
                    ClientSetings.data.unlimitFPS = NewSeting ;
                }
                if (dynamicOptions[i+1] == 'FPSmax')
                    ClientSetings.data.FPSmax += keyLR;
                if (dynamicOptions[i+1] == 'sickHit')
                    ClientSetings.data.sickHit += keyLR;
                if (dynamicOptions[i+1] == 'goodHit')
                    ClientSetings.data.goodHit += keyLR;
                if (dynamicOptions[i+1] == 'badHit')
                    ClientSetings.data.badHit  += keyLR;
            }
        }
        ClientSetings.saveSettings();
        updateSeting();
    }

    var _lastVisiblesOptions:Array<Int> = [];
    var lerpSelectedOptions:Float = 0;
    public function updateTextsOptions(elapsed:Float = 0.0)
	{
		lerpSelectedOptions = FlxMath.lerp(select, lerpSelectedOptions, Math.exp(-elapsed * 9.6));
		for (i in _lastVisiblesOptions)
		{
			menuItemsDop[i].visible = menuItemsDop[i].active = false;
		}
		_lastVisiblesOptions = [];

		var min:Int = Math.round(Math.max(0, Math.min(menuItemsDop.length, lerpSelectedOptions - 4)));
		var max:Int = Math.round(Math.max(0, Math.min(menuItemsDop.length, lerpSelectedOptions + 4)));
		for (i in min...max)
		{
			var item:FlxText = menuItemsDop[i];
			item.visible = item.active = true;
			item.x = ((i - lerpSelectedOptions) * 20)  +  80;
			item.y = ((i - lerpSelectedOptions) * 1.3 * 120) +  FlxG.height/2 - 100 ;

			_lastVisiblesOptions.push(i);
		}
	}

    var menuItems:Array<FlxText> = [];
    function createMenu()
    {
        for (i in 0 ... optinsCategories.length)
        {

            var item:FlxText = createMenuItem(optinsCategories[i], 90, (i * 30) + 30);
            item.visible = true;
            item.y = (i * 120) + 60;
            item.cameras = [camCat];
            menuItems.push(item);
            add(item);
        }
    }

    
    function createMenuItem(name:String, x:Float, y:Float):FlxText
	{
		var item:FlxText = new FlxText(x, y);
        item.setFormat('assets/fonts/Menu_Font.ttf', 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        item.scrollFactor.set();
        item.borderSize = 2.25;
        item.text = name;
        item.antialiasing = ClientSetings.data.antialiasing;
		item.scrollFactor.set();
		return item;
	}

    function updateTextSelect() {
        FlxG.sound.play("assets/sounds/scrollMenu.ogg", 0.4);
        for (i in 0 ... optinsCategories.length)
        {
            menuItems[i].alpha = (i == selectCategories) ? 1 : 0.6 ;
            menuItems[i].text = (i == selectCategories) ? '>' + optinsCategories[i] + '<' : optinsCategories[i] ;
        }
    }
}