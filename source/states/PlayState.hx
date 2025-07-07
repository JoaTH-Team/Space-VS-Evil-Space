package states;

import flixel.FlxState;
import objects.Player;

class PlayState extends FlxState
{
	var player:Player;

	override public function create()
	{
		super.create();
		player = new Player(50, 0);
		player.screenCenter(Y);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
