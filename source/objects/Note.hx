package objects;

// import openfl.filters.BlurFilter;

import flixel.math.FlxRect;

class Note extends FlxSprite
{
    public var blockHit:Bool = false;
    
    public var imgpng:String;
    public var imgxml:String;
    public var textyre:String;
    public var tex:FlxAtlasFrames;
    
    public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
    public var missNote: Bool = false;
    public var badHit:Bool = false;
	public var prevNote:Note;
    public var nextNote:Note;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;

    public var offsetX:Float = 0;
	public var offsetY:Float = 0;

	public static var swagWidth:Float = 115;

    public var lowPriority:Bool = false;
    public var lateHitMult:Float = 1;
    public var earlyHitMult:Float = 1;

    private var reloadNotes:Bool = false;

    public var noteType:String;

    public var ignoreNote:Bool = false;
    
    public function new( strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, img:String = 'NOTE_assets') 
    {
        super();

        if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		this.isSustainNote = sustainNote;
		this.strumTime = strumTime;
		this.noteData = noteData;
        this.textyre = img;

        reloadNote();
    }

    public function reloadNote()
    {
        
        if(!reloadNotes)
            x += 50;

        if (noteType == 'Phantom Note')
        {
            ignoreNote = true;
            alpha = 0.3;

            textyre = 'HURTNOTE_assets';
        }

        imgpng = 'assets/images/' + textyre + '.png';
        imgxml = 'assets/images/' + textyre + '.xml';
        tex = FlxAtlasFrames.fromSparrow(imgpng,imgxml);
        frames = tex;

        
        animation.addByPrefix('greenScroll', 'green0');
		animation.addByPrefix('redScroll', 'red0');
		animation.addByPrefix('blueScroll', 'blue0');
		animation.addByPrefix('purpleScroll', 'purple0');

		animation.addByPrefix('purpleholdend', 'pruple hold end0');
		animation.addByPrefix('greenholdend', 'green hold end0');
		animation.addByPrefix('redholdend', 'red hold end0');
		animation.addByPrefix('blueholdend', 'blue hold end0');

		animation.addByPrefix('purplehold', 'purple hold piece');
		animation.addByPrefix('greenhold', 'green hold piece');
		animation.addByPrefix('redhold', 'red hold piece');
		animation.addByPrefix('bluehold', 'blue hold piece');
        
        updateHitbox();
        antialiasing = true;
        if(!reloadNotes)
            setGraphicSize(Std.int(width * 0.7));

        var arScroll:Array<String> = ['purpleScroll', 'blueScroll', 'greenScroll', 'redScroll'];

        if (!reloadNotes)
            x += swagWidth * noteData;

        animation.play(arScroll[noteData]);

        if (prevNote != null)
			prevNote.nextNote = this;

        if (isSustainNote && prevNote != null)
        {
            if(!reloadNotes)
            {
                noteScore * 0.2;
                // alpha = 0.6;
            }
            var arhold:Array<String> = ['purplehold', 'bluehold', 'greenhold', 'redhold'];
            updateHitbox();
        
            
            if (prevNote.isSustainNote)
            {
                prevNote.animation.play(arhold[prevNote.noteData]);
                prevNote.updateHitbox();
                earlyHitMult = 1;
                if (!reloadNotes)
                {
                    prevNote.scale.y *= Conductor.StepBit / 100 * 1.5;
                    prevNote.scale.y *=  PlayState.SONG.speed;
                    // prevNote.scale.y *= Conductor.StepBit / 100 * 1.05;
                }
                prevNote.noteType = noteType;
            }
            earlyHitMult = 0;
           
            
            flipY = !ClientSetings.data.downScroll ? false : true ;
            animation.play(arhold[noteData] + 'end');
            updateHitbox();
        }
        reloadNotes = true;
        // Забавный эфект измены стрелак
        // colorTransform.redOffset = 255;
        // colorTransform.greenOffset = 255;
        // colorTransform.blueOffset = 255;
        // colorTransform.redMultiplier = -1;
        // colorTransform.greenMultiplier = -1;
        // colorTransform.blueMultiplier = -1;
        
        
    }


    override function update(elapsed:Float)
        {
            super.update(elapsed);
    
            if (mustPress)
                {

                    canBeHit = (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * lateHitMult) &&
						        strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * earlyHitMult));   

                    if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				        tooLate = true;
                }
                else
                {
                    canBeHit = false;
        
                    if (!wasGoodHit && strumTime <= Conductor.songPosition)
                        {
                            if(!isSustainNote || prevNote.wasGoodHit )
                                wasGoodHit = true;
                        }
                }
        
                if (tooLate)
                {
                    if (alpha > 0.2)
                        alpha = 0.2;
                    alpha = 0.2;
                }
        }
}