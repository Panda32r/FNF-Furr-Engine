package scriptsUrlsFE;

import flixel.tweens.FlxEase;

class TweenEaseAll {
    public static function SelectEase(name:String):Float->Float {
        //Моя изначально версия
        // switch (name){
        //     case 'backIn':  return FlxEase.backIn;
        //     case 'backInOut': return FlxEase.backInOut;
        //     case 'backOut': return FlxEase.backOut;
        //     case 'bounceIn': return FlxEase.bounceIn;
        // }

        // Это версия исправлениями ии, да маленькое 
        // просто перенёс он return в свитчер но почемута так работает
        //toLowerCase() - делает весть текст одинаковым
        //trim() удаляет пробелы ыыыыы
        trace(name);
        return switch (name.toLowerCase().trim()) {
            // Linear
            case "linear": FlxEase.linear;
            
            // Quad
            case "quadin": FlxEase.quadIn;
            case "quadout": FlxEase.quadOut;
            case "quadinout": FlxEase.quadInOut;
            
            // Cube
            case "cubein": FlxEase.cubeIn;
            case "cubeout": FlxEase.cubeOut;
            case "cubeinout": FlxEase.cubeInOut;
            
            // Quart
            case "quartin": FlxEase.quartIn;
            case "quartout": FlxEase.quartOut;
            case "quartinout": FlxEase.quartInOut;
            
            // Quint
            case "quintin": FlxEase.quintIn;
            case "quintout": FlxEase.quintOut;
            case "quintinout": FlxEase.quintInOut;
            
            // Sine
            case "sinein": FlxEase.sineIn;
            case "sineout": FlxEase.sineOut;
            case "sineinout": FlxEase.sineInOut;
            
            // Expo
            case "expoin": FlxEase.expoIn;
            case "expoout": FlxEase.expoOut;
            case "expoinout": FlxEase.expoInOut;
            
            // Circ
            case "circin": FlxEase.circIn;
            case "circout": FlxEase.circOut;
            case "circinout": FlxEase.circInOut;
            
            // Elastic
            case "elasticin": FlxEase.elasticIn;
            case "elasticout": FlxEase.elasticOut;
            case "elasticinout": FlxEase.elasticInOut;
            
            // Back
            case "backin": FlxEase.backIn;
            case "backout": FlxEase.backOut;
            case "backinout": FlxEase.backInOut;
            
            // Bounce
            case "bouncein": FlxEase.bounceIn;
            case "bounceout": FlxEase.bounceOut;
            case "bounceinout": FlxEase.bounceInOut;
            
            // Smooth
            case "smoothstepin": FlxEase.smoothStepIn;
            case "smoothstepout": FlxEase.smoothStepOut;
            case "smoothstepinout": FlxEase.smoothStepInOut;
            case "smootherstepin": FlxEase.smootherStepIn;
            case "smootherstepout": FlxEase.smootherStepOut;
            case "smootherstepinout": FlxEase.smootherStepInOut;
            
            // Default to linear if not found
            case _: FlxEase.linear;
        }
    }

    /**
     * Возвращает массив всех доступных имен функций easing
     * @return Array<String> Список всех доступных имен
     */
    public static function getAllEaseNames():Array<String> {
        return [
            "linear",
            "quadIn", "quadOut", "quadInOut",
            "cubeIn", "cubeOut", "cubeInOut",
            "quartIn", "quartOut", "quartInOut",
            "quintIn", "quintOut", "quintInOut",
            "sineIn", "sineOut", "sineInOut",
            "expoIn", "expoOut", "expoInOut",
            "circIn", "circOut", "circInOut",
            "elasticIn", "elasticOut", "elasticInOut",
            "backIn", "backOut", "backInOut",
            "bounceIn", "bounceOut", "bounceInOut",
            "smoothStepIn", "smoothStepOut", "smoothStepInOut",
            "smootherStepIn", "smootherStepOut", "smootherStepInOut"
        ];
    }
}