package objects;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class Bullet extends FlxSprite
{
	public var power:Int = 10;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		makeGraphic(8, 8, FlxColor.WHITE);
		velocity.x = 800;
		FlxTween.color(this, 0.5, FlxColor.WHITE, FlxColor.BROWN, {
			ease: FlxEase.linear,
			type: PINGPONG,
			loopDelay: 0.1
		});
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (!isOnScreen())
		{
			kill();
		}
	}

	override public function kill():Void
	{
		FlxTween.cancelTweensOf(this);
		super.kill();
	}
}