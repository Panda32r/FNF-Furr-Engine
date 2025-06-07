package states.subState;

import states.OptinsState;
import backend.KeyNames;
import flixel.input.keyboard.FlxKey;

class OptionsControl extends MusicBeatState {
    var grpOptions:FlxTypedGroup<FlxText>;
    var curSelected:Int = 0;
    var changingKey:Bool = false;
    var currentAction:String = null;
    var changingStep:Int = 0;
    var newKeys:Array<FlxKey> = [];
    var sortedActions:Array<String> = [];

    override function create() {
        super.create();
        
        ClientSetings.loadSettingsControls();
        grpOptions = new FlxTypedGroup<FlxText>();
        add(grpOptions);

        // Сортируем действия: сначала ноты, потом остальные
        var noteOrder = ['note_left', 'note_down', 'note_up', 'note_right'];
        var otherActions = [];
        
        for (action in ClientSetings.keyBinds.keys()) {
            if (!noteOrder.contains(action)) 
                otherActions.push(action);
        }
        sortedActions = noteOrder.concat(otherActions);

        // Создаем элементы меню
        var yPos:Float = 50;
        for (action in sortedActions) {
            var text = new FlxText(50, yPos, 0, 
                '${action.toUpperCase()}: ${ClientSetings.keyBinds[action].join(", ")}', 
                24);
            text.visible = false; // Скрываем до первой загрузки
            grpOptions.add(text);
            yPos += 50;
        }

        // Загрузка позиций и обновление видимости
        refreshMenu();

        var infoText = new FlxText(50, FlxG.height - 70, 0, 
            "ЛКМ - Выбрать действие | Нажмите 2 клавиши для назначения | ESC - Сохранить и выйти", 
            16);
        add(infoText);
    }

    function refreshMenu() {
        var yPos:Float = 50;
        for (i in 0...sortedActions.length) {
            var action = sortedActions[i];
            var text = grpOptions.members[i];
            // Используем KeyNames для преобразования
            text.text = '${action.toUpperCase()}: ${KeyNames.keysToString(ClientSetings.keyBinds[action])}';
            text.setPosition(50, yPos);
            text.visible = true;
            yPos += 50;
        }
    }


    override function update(elapsed:Float) {
        super.update(elapsed);

        // Обработка кликов мыши
        if (FlxG.mouse.justPressed && !changingKey) {
            for (i in 0...grpOptions.length) {
                var option = grpOptions.members[i];
                if (FlxG.mouse.overlaps(option)) {
                    curSelected = i;
                    startChangingKey();
                    break;
                }
            }
        }

        if (!changingKey) {
            // Навигация клавиатурой
            if (FlxG.keys.justPressed.UP) changeSelection(-1);
            if (FlxG.keys.justPressed.DOWN) changeSelection(1);
            
            if (FlxG.keys.justPressed.ESCAPE) {
                ClientSetings.saveSettings();
                FlxG.switchState(new OptinsState());
            }
        }
        else {
            // Обработка ввода клавиш
            if (FlxG.keys.justPressed.ANY) {
                var pressedKey = FlxG.keys.firstJustPressed();
                newKeys.push(pressedKey);
                changingStep++;
                
                // Обновляем текст
                var statusText = switch (changingStep) {
                    case 1: "НАЖМИТЕ ВТОРУЮ КЛАВИШУ";
                    case 2: "СОХРАНЕНО!";
                    default: "";
                }
                grpOptions.members[curSelected].text = 
                    '${currentAction.toUpperCase()}: ${KeyNames.keysToString(newKeys)} ($statusText)';

                // Завершаем ввод
                if (changingStep >= 2) {
                    ClientSetings.keyBinds.set(currentAction, newKeys);
                    Controls.instance.keyboardBinds.set(currentAction, newKeys);
                    changingKey = false;
                    changingStep = 0;
                    newKeys = [];
                    
                    // Автосохранение после изменения
                    ClientSetings.saveSettings();
                    
                    // Возвращаем нормальный текст через секунду
                    FlxG.camera.shake(0.002, 0.1);
                    FlxTween.tween(grpOptions.members[curSelected], {alpha: 1}, 0.5, {
                        onComplete: function(_) {
                            refreshMenu();
                        }
                    });
                }
            }
        }
    }

    function startChangingKey() {
        changingKey = true;
        currentAction = sortedActions[curSelected];
        newKeys = [];
        changingStep = 0;
        grpOptions.members[curSelected].text = 
        '${currentAction.toUpperCase()}: > НАЖМИТЕ ПЕРВУЮ КЛАВИШУ <';
    }

    function changeSelection(change:Int = 0) {
        curSelected = FlxMath.wrap(curSelected + change, 0, sortedActions.length - 1);
        
        // Визуальное выделение
        for (i in 0...grpOptions.length) {
            grpOptions.members[i].color = (i == curSelected) ? FlxColor.YELLOW : FlxColor.WHITE;
            grpOptions.members[i].alpha = (i == curSelected) ? 1 : 0.6;
        }
    }
}