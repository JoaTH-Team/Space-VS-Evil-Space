package backend;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import states.*;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, InitState));
		addChild(new FPS(10, 3, 0xFFFFFF));
	}
}
