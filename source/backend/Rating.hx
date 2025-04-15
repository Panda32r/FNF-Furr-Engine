package backend;

import backend.ClientSetings;

class Rating
{
	public var name:String = '';
	public var image:String = '';
	public var hitWindow:Null<Int> = 0; //ms
	public var ratingMod:Float = 1;
	public var score:Int = 350;
	public var noteSplash:Bool = true;
	public var hits:Int = 0;

	public function new(name:String)
	{
		this.name = name;
		this.image = name;
		this.hitWindow = 0;

		var window:String = name + 'Window';
	}

	public static function loadDefault():Array<Rating>
	{
		var ratingsData:Array<Rating> = [new Rating('sick')]; //highest rating goes first

		var rating:Rating = new Rating('good');
		rating.score = 200;
		rating.noteSplash = false;
		ratingsData.push(rating);

		var rating:Rating = new Rating('bad');
		rating.score = 100;
		rating.noteSplash = false;
		ratingsData.push(rating);

		var rating:Rating = new Rating('shit');
		rating.score = 50;
		rating.noteSplash = false;
		ratingsData.push(rating);
		return ratingsData;
	}
}
