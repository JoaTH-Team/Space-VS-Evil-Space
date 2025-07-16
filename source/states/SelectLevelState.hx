package states;

import flixel.FlxG;
import flixel.text.FlxText;

class SelectLevelState extends StateCreation
{
	var titleText:FlxText;

    override function create() {
        super.create();
		titleText = new FlxText(0, 50, 0, "World 1: The Green World", 32);
		add(titleText);
    }    

    override function update(elapsed:Float) {
        super.update(elapsed);
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(() -> new MenuState());
		}
    }
}