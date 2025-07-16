package states;

import flixel.FlxG;
import flixel.util.FlxTimer;
import global.SaveData;

class InitState extends StateCreation
{
    override function create() {
        super.create();

		SaveData.init();
		FlxG.switchState(() -> new PlayState());
    }
}