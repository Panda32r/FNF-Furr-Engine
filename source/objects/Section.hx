package objects;

typedef SwagSection =
{
	var sectionNotes:Array<Dynamic>;
	var mustHitSection:Bool;
	var bpm:Int;
	var altAnim:Bool;
	var gfSection:Bool;
	var changeBPM:Bool;
	var sectionBeats:Float;
}

class Section
{
	public var sectionNotes:Array<Dynamic> = [];

	public var mustHitSection:Bool = true;
	public var altAnim:Bool = false;
	public var gfSection:Bool = false; 
	public var changeBPM:Bool = false;

	/**
	 *	Copies the first section into the second section!
	 */
	public static var COPYCAT:Int = 0;

}
