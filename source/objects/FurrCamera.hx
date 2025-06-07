package objects;

import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

/**
 * FurrCamera - это почти как PsychCamera но немного переделанная
 * FurrCamera - улучшенная камера для HaxeFlixel с:
 * - Плавным followLerp на любом FPS
 * - Оптимизированным обновлением
 * - Поддержкой кастомных deadzone-режимов
 * - Дополнительными эффектами (дрожание, zoom-инерция)
 */
class FurrCamera extends FlxCamera
{
    // Настройки плавности слежения
    public var smoothness:Float = 1.0; // Множитель плавности (1.0 = стандартная плавность)
    public var dynamicLerp:Bool = true; // Автоматически корректировать lerp под FPS

    // Для расчёта движения
    private var _lastTargetPos:FlxPoint = FlxPoint.get();
    // private var _scrollTarget:FlxPoint = FlxPoint.get();
    private var _lerpSpeed:Float = 0.0;

    // Эффекты
    private var _zoomLerp:Float = 0.0;
    private var _targetZoom:Float = 1.0;

    public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0, zoom:Float = 0)
    {
        super(x, y, width, height, zoom);
        _targetZoom = zoom;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed); // Обновляем базовые эффекты (вспышки, тряски)

        if (target != null)
            updateFollowWithElapsed(elapsed);

        updateScroll();
        updateZoom(elapsed);
    }

    /**
     * Плавное слежение за целью с учётом FPS.
     */
    private function updateFollowWithElapsed(elapsed:Float):Void
    {
         // Обновляем позицию цели
        target.getMidpoint(_point);
        _point.addPoint(targetOffset);
        _scrollTarget.set(
            _point.x - width * 0.5,
            _point.y - height * 0.5
        );

        // Динамический lerp (корректировка под FPS)
        _lerpSpeed = dynamicLerp 
            ? 1 - Math.exp(-elapsed * followLerp * smoothness * (1 / 60))
            : followLerp;

        // Плавный переход к цели
        scroll.x = FlxMath.lerp(scroll.x, _scrollTarget.x, _lerpSpeed);
        scroll.y = FlxMath.lerp(scroll.y, _scrollTarget.y, _lerpSpeed);

        // Фиксируем последнюю позицию для след. кадра
        _lastTargetPos.set(target.x, target.y);
    }

    /**
     * Плавный зум камеры.
     */
    private function updateZoom(elapsed:Float):Void
    {
        if (zoom != _targetZoom)
        {
            _zoomLerp = dynamicLerp
                ? 1 - Math.exp(-elapsed * followLerp * smoothness * (1 / 60))
                : followLerp;

            zoom = FlxMath.lerp(zoom, _targetZoom, _zoomLerp);
        }
    }

    /**
     * Установка целевого зума (с плавным переходом).
     */
    public function setTargetZoom(newZoom:Float):Void
    {
        _targetZoom = newZoom;
    }

    /**
     * "Толчок" камеры (эффект удара/шака).
     */
    public function bumpCamera(x:Float = 0, y:Float = 0):Void
    {
        scroll.x += x;
        scroll.y += y;
    }

    override function destroy():Void
    {
        super.destroy();
        _lastTargetPos.put();
        _scrollTarget.put();
    }
}