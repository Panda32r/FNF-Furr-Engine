package backend;

import haxe.Json;

typedef EventFiles = {
    var event:Array<Events>;
}

typedef Events = {
    var step:Int;
    var eventName:String;
    var value1:String;
    var value2:String;
}

class EventJson {
    public static var pathEvent:String;
    public static function loadJson(nameFolder:String) {
        pathEvent = 'assets/data/' + nameFolder.toLowerCase() + '/event.json';
        if (FileSystem.exists(pathEvent))
        {
            var eventFiles = File.getContent(pathEvent).trim();
            var eventF:EventFiles = Json.parse(eventFiles);
            return eventF;
        }
        else 
        {
            return { event: []};
        }
    }
}