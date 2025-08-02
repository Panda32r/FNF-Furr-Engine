package data;

import flixel.animation.FlxAnimationController;

class AnimControl extends FlxAnimationController{

     public override function update(elapsed:Float):Void {
		if (_curAnim != null) {
            // var adjustedElapsed = elapsed * (60 / FlxG.updateFramerate);
            var speed:Float = timeScale;
            speed *= FlxG.animationTimeScale;
			_curAnim.update(elapsed * speed);
		}
		else if (_prerotated != null) {
			_prerotated.angle = _sprite.angle;
		}
	}
}