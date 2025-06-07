package objects;

class MyStrumNote extends FlxSprite{

    public var imgpng:BitmapData;
    public var imgxml:String;
    public var tex:FlxAtlasFrames;

	public var resetAnim:Float = 0;
	private var noteData:Int = 0;
	public var direction:Float = 90;
	public var sustainReduce:Bool = true;
	private var player:Int;


    public function new(x:Float, y:Float, leData:Int, player:Int , img = 'NOTE_assets') {

		noteData = leData;
		this.player = player;
		this.noteData = leData;
		this.ID = noteData;
        this.imgpng = BitmapData.fromFile('assets/images/'+ img + '.png');
        this.imgxml = File.getContent('assets/images/' + img + '.xml');
		super(x, y);

		shitReloadNoteList();
		scrollFactor.set();
		playAnim('static');
	}

    public function shitReloadNoteList() 
    {
        var lastAnim:String = null;
		if(animation.curAnim != null) lastAnim = animation.curAnim.name;

			tex = FlxAtlasFrames.fromSparrow(imgpng,imgxml);
			frames = tex;

			// trace(imgpng);
			
			animation.addByPrefix('green', 'arrowUP');
			animation.addByPrefix('blue', 'arrowDOWN');
			animation.addByPrefix('purple', 'arrowLEFT');
			animation.addByPrefix('red', 'arrowRIGHT');
		
			setGraphicSize(Std.int(width * 0.7));
			antialiasing = ClientSetings.data.antialiasing;


			switch (Math.abs(noteData) % 4)
			{
				case 0:
					x += Note.swagWidth * 0 ;
					animation.addByPrefix('static', 'arrowLEFT');
					animation.addByPrefix('pressed', 'left press', 24, false);
					animation.addByPrefix('confirm', 'left confirm', 24, false);
				case 1:
					x += Note.swagWidth * 1 ;
					animation.addByPrefix('static', 'arrowDOWN');
					animation.addByPrefix('pressed', 'down press', 24, false);
					animation.addByPrefix('confirm', 'down confirm', 24, false);
				case 2:
					x += Note.swagWidth * 2 ;
					animation.addByPrefix('static', 'arrowUP');
					animation.addByPrefix('pressed', 'up press', 24, false);
					animation.addByPrefix('confirm', 'up confirm', 24, false);
				case 3:
					x += Note.swagWidth * 3 ;
					animation.addByPrefix('static', 'arrowRIGHT');
					animation.addByPrefix('pressed', 'right press', 24, false);
					animation.addByPrefix('confirm', 'right confirm', 24, false);
			}

			updateHitbox();

			// trace(animation.getByName('static'));
			// trace(animation.getByName('pressed'));
			// trace(animation.getNameList());
			if(lastAnim != null)
			{
				playAnim(lastAnim, true);
			}

			if (player != 1)
				visible = ClientSetings.data.opponentStrums;
    }

    public function playerPosition()
    {
		x += 50;
		if (!ClientSetings.data.middleScroll)
			x += ((FlxG.width / 2) * player);
		else
			if (player == 1)
				x += ((FlxG.width / 2) * player - Note.swagWidth * 2 - 50);
			else
				if (noteData < 2)
					x += ((FlxG.width / 2) * player);
				else
					x += ((FlxG.width / 2) * 1 + 50);

    }	

    public function playAnim(anim:String, ?force:Bool = false) {
		animation.play(anim, force);
		if(animation.curAnim != null)
		{
			centerOffsets();
			centerOrigin();
		}
	}


	override function update(elapsed:Float) {
		if (animation.curAnim.finished)
			if(resetAnim > 0) {
				resetAnim -= elapsed;
				if(resetAnim <= 0) {
					playAnim('static');
					resetAnim = 0;
				}
			}
		super.update(elapsed);
	}


}