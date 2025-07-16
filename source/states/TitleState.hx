package states;

import flixel.FlxG;
import flixel.text.FlxText;

class TitleState extends StateCreation
{
    override function create() {
        super.create();
		add(new FlxText(0, 500, 0, "Press ANY Key to continue", 32).screenCenter(X));
	}

    override function update(elapsed:Float) {
        super.update(elapsed);
		if (FlxG.keys.justPressed.ANY)
		{
			FlxG.switchState(() -> new MenuState());
		}
    }
}