package objects;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

enum BulletType {
    LINE;
    LITTLE_RANGE;
}

class Bullet extends FlxSprite
{
	public var power:Int = 1;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		makeGraphic(8, 8, FlxColor.WHITE);
		power = 10;
		velocity.x = 800;

		doTween();
	}
	function doTween()
	{
		FlxTween.color(this, 0.25, FlxColor.WHITE, FlxColor.BROWN, {ease: FlxEase.linear, type: ONESHOT});
	}
}