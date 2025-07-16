package states;

import flixel.FlxG;
import global.SaveData;

class InitState extends StateCreation
{
    override function create() {
        super.create();

		SaveData.init();
		FlxG.switchState(() -> new TitleState());
    }
}