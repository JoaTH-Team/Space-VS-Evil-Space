package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;

class TitleState extends StateCreation
{
	var titleGame:FlxSprite;

    override function create() {
        super.create();
		titleGame = new FlxSprite(0, 0, Paths.images("title_game"));
		titleGame.scale.set(3, 3);
		titleGame.screenCenter();
		titleGame.y -= 50;
		add(titleGame);

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