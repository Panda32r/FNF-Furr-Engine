package backend;

import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;
import objects.Section.SwagSection;

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var events:Array<Dynamic>;
	var bpm:Int;
	var sections:Int;
	var needsVoices:Bool;
	var speed:Float;
	var stage:String;

	var player1:String;
	var player2:String;
	var player3:String;

	var format:String;
	
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var events:Array<Dynamic>;
	public var bpm:Int;
	public var sections:Int;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;

	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var player3:String = 'gf';
	public var stage:String = 'stage';

	public var format:String = 'Prototype_0.1';

	public function new(song, notes, bpm, sections)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
		this.sections = sections;
		
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{

		var rawJson = File.getContent('assets/data/' + folder.toLowerCase() + '/' + jsonInput.toLowerCase() + '.json').trim();
		trace('assets/data/' + folder.toLowerCase() + '/' + jsonInput.toLowerCase() + '.json');
		// var rawJson = Assets.getText('assets/data/tutorial/tutorial-hard.json').trim();
		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
			// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
		}

		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		// trace(swagShit.notes[0]);

		// FIX THE CASTING ON WINDOWS/NATIVE
		// Windows???
		// trace(songData);

		// trace('LOADED FROM JSON: ' + songData.notes);
		/* 
			for (i in 0...songData.notes.length)
			{
				trace('LOADED FROM JSON: ' + songData.notes[i].sectionNotes);
				// songData.notes[i].sectionNotes = songData.notes[i].sectionNotes
			}

				daNotes = songData.notes;
				daSong = songData.song;
				daSections = songData.sections;
				daBpm = songData.bpm;
				daSectionLengths = songData.sectionLengths; */

		return swagShit;
	}
}