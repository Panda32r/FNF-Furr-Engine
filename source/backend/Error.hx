package backend;

import states.TitleState;
import openfl.events.UncaughtErrorEvent;
import lime.app.Application;

class Error {
    
    public static var NameError:String = '';
    public static var infoError:String = '';

    public static function onError(e:UncaughtErrorEvent):Void {
		// #if !neko
        var stack = haxe.CallStack.exceptionStack();  
        trace(stack);
        var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		// var errorMsg = "CRASH: " + Std.string(e);
		var errorMsg:String = NameError == '' ? "Произошла критическая ошибка  данного типа :\n\n" : NameError + "\n\n";

        var textMsg:String = '' + e;
        textMsg = textMsg.replace(' ', '\n');

        var lines = textMsg.split("\n");

        var line = lines[4].trim();
        var startIndex = line.indexOf('[') + 1;
        var endIndex = line.lastIndexOf(',');
        var typeError = line.substring(startIndex, endIndex);

        line = lines[4].trim();
        startIndex = line.indexOf(',') + 1;
        endIndex = line.lastIndexOf(']]');
        var msg = line.substring(startIndex, endIndex);

        if(typeError == 'file_contents')
            errorMsg += 'Небыл найден файл по следущему пути:\n\n' + msg + '\n\n';

        if(infoError == '')
            errorMsg += 'Полная информация об ошибке:\n\n' + textMsg;
        else
            errorMsg += 'Полная информация об ошибке:\n\n' + infoError;
        
        
        if (e != null) {
            errorMsg +="\n\nStack Trace:\n" + haxe.CallStack.toString(stack);
        } else {
            errorMsg += "\n\nНеизвестная ошибка.";
        }

        // Выводим окно с ошибкой
        Application.current.window.alert(errorMsg, "Uh-Oh!");

        if (NameError == '')
		{
            if (!FileSystem.exists("./Crash_Engine/"))
			    FileSystem.createDirectory("./Crash_Engine/");

            sys.io.File.saveContent("Crash_Engine/Crash_Log_FurrEngine_"+ TitleState.verEngine +"_" + dateNow + ".txt", errorMsg); // Запись в файл
            Sys.exit(1);
        }
        else
        {    
            if (!FileSystem.exists("./Crash_Engine_Script/"))
			    FileSystem.createDirectory("./Crash_Engine_Script/");

            sys.io.File.saveContent("Crash_Engine_Script/Crash_Log_FurrEngine_" + TitleState.verEngine + "_" + dateNow + ".txt", errorMsg); // Запись в файл
            NameError = '';
            infoError = '';
        }
		// #end
    }

}