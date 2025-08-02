package backend;

import data.Event.EventFiles;
import haxe.Json;

class EventJson {
    public static var pathEvent:String;
    public static function loadFromJson(nameFolder:String) {
        pathEvent = 'assets/data/' + nameFolder.toLowerCase() + '/event.json';
        if (FileSystem.exists(pathEvent))
        {
            var eventFiles = File.getContent(pathEvent).trim();
            var eventF:EventFiles = Json.parse(eventFiles);
            return eventF;
        }
        else 
        {
            return {event: []};
        }
    }
}