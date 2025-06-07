package backend;

import haxe.io.Path;
import haxe.Json;

typedef StoryWeek = {
    var weekImg:String;
    var weekName:String;
    var song:Array<Dynamic>;
    var difficulties:Array<String>;
    var charectors:Array<String>;
    var description:String;
}

class StoryLoad {
    
    public static function loadWeek(folder:String) {
        var weekPath:String = 'assets/weeks/$folder';
        var weekJson = File.getContent(weekPath).trim();
        var weekData:StoryWeek = Json.parse(weekJson);
        return weekData;
    }

    public static function collectFilesByExtension(directoryPath:String, targetExtension:String):Array<String> {
    var files = [];
    
    // Проверка существования директории
    if (!FileSystem.exists(directoryPath) || !FileSystem.isDirectory(directoryPath)) {
        throw "Директория не существует или путь ведёт к файлу";
    }

    // Удаляем точку из расширения, если она есть (например, ".json" → "json")
    targetExtension = targetExtension.replace(".", "").toLowerCase();
    
    // Читаем содержимое директории
    var items = FileSystem.readDirectory(directoryPath);
    for (item in items) {
        var fullPath = directoryPath + "\\" + item; // Для Windows используем обратные слеши
        if (!FileSystem.isDirectory(fullPath)) {
            // Получаем расширение файла
            var ext = Path.extension(item).toLowerCase();
            if (ext == targetExtension) {
                files.push(item); // Или fullPath, если нужны полные пути
            }
        }
    }
    
    return files;
}
}