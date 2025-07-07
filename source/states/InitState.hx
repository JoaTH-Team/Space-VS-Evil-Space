package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import global.SaveData;

class InitState extends FlxState
{
    override function create() {
        super.create();

        SaveData.init();
    
        new FlxTimer().start(1, function (timer:FlxTimer) {
            FlxG.switchState(() -> new PlayState());
        });
    }
}