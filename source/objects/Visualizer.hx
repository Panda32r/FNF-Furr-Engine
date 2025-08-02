package objects;

import data.Vis;
#if funkin.vis
import funkin.vis.dsp.SpectralAnalyzer.Bar;
#end

class Visualizer extends Vis
{
    static final BAR_WIDTH:Int          = 20;
    static final BAR_SPACING:Int        = 5;
    static final MAX_HEIGHT:Float       = 150;

    public var bars:Array<FlxSprite>    = [];

    public function new(x:Float = 0, y:Float = 0, umb_lines:Int = 30)
    {
        super(x, y);
        // trace('Create new Vis');
        for (i in 0...NUM_BARS)
        {
            var bar = new FlxSprite();
            bar.makeGraphic(BAR_WIDTH, 1, FlxColor.WHITE);
            bar.x = i * (BAR_WIDTH + BAR_SPACING);
            bar.y = y;
            bar.origin.y = bar.height;
            add(bar);
            bars.push(bar);
        }
    }

    #if funkin.vis

    var levels:Array<Bar>               = null;

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (analyzer == null) return;
        if (levels == null) levels = new Array<Bar>();
        
        // trace(analyzer);
        levels = analyzer.getLevels(levels);
        if (levels.length == 0) return;

        for (i in 0...bars.length)
        {
            if (i >= levels.length) break;
            
            var level = FlxMath.bound(levels[i].value * 1.5, 0, 1);
            bars[i].scale.y = level * MAX_HEIGHT;
            bars[i].updateHitbox();
            bars[i].offset.y = bars[i].height;
            
            bars[i].color = FlxColor.interpolate(
                FlxColor.BLUE, 
                FlxColor.RED, 
                level
            );
        }
    }

    #end
    
}