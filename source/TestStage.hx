package;

import flixel.FlxState;
import flixel.FlxG;

class TestStage extends MusicBeatState {
    override public function create() {
        super.create();
        
        // Прозрачный фон камеры (обязательно!)
        FlxG.cameras.bgColor = 0x00000000;
        

        // Пример видимого объекта
        var sprite = new FlxSprite(100, 100).makeGraphic(100, 100, 0xFFFF0000);
        add(sprite);
    }
}