package objects;

class MySpleshForNote extends FlxSprite
{
    public var noteData:Int = 0;

    public var imgpng:BitmapData;
    public var imgxml:String;

    public var isPlayer:Int;
    public var tex:FlxAtlasFrames;

    public function new(x:Float, y:Float, data:Int, p:Int, img:String = 'noteSplashesVanilla') {
        super(x,y);
        this.noteData = data;
        this.isPlayer = p;
        this.ID = noteData;
        this.imgpng = BitmapData.fromFile('assets/images/'+ img + '.png');
        this.imgxml = File.getContent('assets/images/' + img + '.xml');

        reloadSplesh();
        scrollFactor.set();
        playAnim('pressed');
    }

    public function reloadSplesh()
    {

        tex = FlxAtlasFrames.fromSparrow(imgpng,imgxml);
		frames = tex;

        animation.addByPrefix('green', 'note impact 1 green');
		animation.addByPrefix('blue', 'note impact 1 blue');
		animation.addByPrefix('purple', 'note impact 1 purple');
		animation.addByPrefix('red', 'note impact 1 red');

        antialiasing = ClientSetings.data.antialiasing;

        switch (Math.abs(noteData) % 4)
        {
            case 0:
                x += Note.swagWidth * 0 ;
                animation.addByPrefix('pressed', 'note impact 1 purple', 24, false);
                // trace('1');
            case 1:
                x += Note.swagWidth * 1 ;
                animation.addByPrefix('pressed', 'note impact 1  blue', 24, false);
                // trace('2');
            case 2:
                x += Note.swagWidth * 2 ;
                animation.addByPrefix('pressed', 'note impact 1 green', 24, false);
                // trace('3');
            case 3:
                x += Note.swagWidth * 3 ;
                animation.addByPrefix('pressed', 'note impact 1 red', 24, false);
                // trace('4');
        }

        updateHitbox();

        alpha = ClientSetings.data.splashAlpha;
    }

    public function playerPosition()
    {
        y-=100;
		x -= 25;
		if (!ClientSetings.data.middleScroll)
			x += ((FlxG.width / 2) * isPlayer);
		else
			if (isPlayer == 1)
				x += ((FlxG.width / 2) * isPlayer - Note.swagWidth * 2 - 50);
			else
				if (noteData < 2)
					x += ((FlxG.width / 2) * isPlayer);
				else
					x += ((FlxG.width / 2) * 1 + 50);

    }	

    public function playAnim(anim:String, ?force:Bool = false) {
        // trace('play anim');
        visible = true;
		animation.play(anim, force);
		if(animation.curAnim != null)
		{
			centerOffsets();
			centerOrigin();
		}
	}

    override function update(elapsed:Float) {
		if (animation.curAnim.finished && visible)
            visible = false;
		super.update(elapsed);
	}
}