package objects;
// Сделал максимально похожую миханику определения анимаций как в Psych Engine
// И вроди всё покачто норма работает :')
class HealthIcon extends FlxSprite{
    var charector:String = '';
    var isPlayer:Bool = false;
    public var iSize:Float;
    public function new(charector:String = 'cat', isPlayer:Bool = false) 
    {
        super();
        this.isPlayer = isPlayer;
        ChangeIcon(charector);
        scrollFactor.set();
    }

    private var iconOffsets:Array<Float> = [0, 0];
    public function ChangeIcon(charector:String) 
    {
        if(this.charector != charector) {
            var pathIcon = 'assets/images/icons/icon-' + charector + '.png';
            if (!(FileSystem.exists(pathIcon)))
                pathIcon = 'assets/images/icons/icon-cat.png';

            var bitmap = BitmapData.fromFile(pathIcon);
            iSize = Math.round(bitmap.width / bitmap.height);
            // trace(iSize);
            loadGraphic(bitmap, true, Math.floor(bitmap.width / iSize), Math.floor(bitmap.height));
            iconOffsets[0] = (width - 150) / iSize;
            iconOffsets[1] = (height - 150) / iSize;
            updateHitbox();

            animation.add(charector, [for(i in 0...frames.frames.length) i], 0, false, isPlayer);
            animation.play(charector);
            this.charector = charector;

            antialiasing = true;
        }

    }

    public var autoAdjustOffset:Bool = true;
	override function updateHitbox()
	{
		super.updateHitbox();
		if(autoAdjustOffset)
		{
			offset.x = iconOffsets[0];
			offset.y = iconOffsets[1];
		}
	}
}