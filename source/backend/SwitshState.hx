package backend;

import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;

class SwitshState {
    
    public static function switchState(nextState:FlxState = null) 
    {
        if(nextState == null) nextState = FlxG.state;
        if(nextState == FlxG.state)
        {
            resetState();
            return;
        }

        if(FlxTransitionableState.skipNextTransIn) FlxG.switchState(nextState);
        else startTransition(nextState);
        FlxTransitionableState.skipNextTransIn = false;
    }

    public static function resetState() 
    {
        if(FlxTransitionableState.skipNextTransIn) FlxG.resetState();
        else startTransition();
        FlxTransitionableState.skipNextTransIn = false;
    }
    public static function startTransition(nextState:FlxState = null)
    {
        if(nextState == null)
            nextState = FlxG.state;

        FlxG.state.openSubState(new CustomFadeTransition(0.5, false));
        if(nextState == FlxG.state)
            CustomFadeTransition.finishCallback = function() FlxG.resetState();
        else
            CustomFadeTransition.finishCallback = function() FlxG.switchState(nextState);
    }
}