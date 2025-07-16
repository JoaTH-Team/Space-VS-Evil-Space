package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import global.CurrentData;

class Player extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0) {
        super(x, y);
		loadGraphic(Paths.images("player"), false);
    }    

    public function dead(?trulyDead:Bool) {
		FlxTween.tween(this, {alpha: 0}, 1, {ease: FlxEase.sineInOut});
	}

	var invulnerable:Bool = false;
	var invulnerableTimer:FlxTimer;

	public function hit(amount:Int = 0)
	{
		if (invulnerable)
			return;

		CurrentData.HEALTH -= amount;
		invulnerable = true;

		FlxTween.color(this, 0.1, FlxColor.RED, FlxColor.WHITE, {
			ease: FlxEase.sineInOut
		});

		invulnerableTimer = new FlxTimer().start(1, function(_)
		{
			invulnerable = false;
		});
	}

    public var allowMove:Bool = true;
    public var allowBound:Bool = true;

    override function update(elapsed:Float) {
        super.update(elapsed);

		if (allowMove)
		{
			var speed = 175;
			if (FlxG.keys.pressed.SHIFT)
			{
				speed = 100;
			}

			if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
			{
				x += (FlxG.keys.pressed.RIGHT ? 1 : -1) * speed * elapsed;
			}

			if (FlxG.keys.pressed.UP || FlxG.keys.pressed.DOWN)
			{
				y += (FlxG.keys.pressed.DOWN ? 1 : -1) * speed * elapsed;
			}
		}

		if (allowBound)
		{
			x = FlxMath.bound(x, 0, FlxG.width - width);
			y = FlxMath.bound(y, 0, FlxG.height - height);
		}
    }
}