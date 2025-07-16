package backend;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.events.Event;
import states.*;

class Main extends Sprite
{
	var fpsCounter:GameCounter;

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, InitState));
		fpsCounter = new GameCounter(10, 10);
		addChild(fpsCounter);

		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event:openfl.events.Event):Void
	{
		// Calculate elapsed time since last frame
		var currentTime:Float = openfl.Lib.getTimer();
		@:privateAccess
		var elapsed:Float = (currentTime - (fpsCounter._times[fpsCounter._times.length - 1] ?? currentTime)) / 1000;
		fpsCounter.update(elapsed);
	}
}
