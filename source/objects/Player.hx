package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import objects.Bullet.BulletType;

class Player extends FlxSprite
{
	public static var shootType:BulletType;

    public function new(x:Float = 0, y:Float = 0) {
        super(x, y);
        loadGraphic(Paths.images("player"), false);

        setSize(38, 23);
        offset.set(12, 1);
    }    

    public function dead(?trulyDead:Bool) {
        FlxTween.tween(this, {alpha: 0}, 1, {ease: FlxEase.sineInOut, onComplete: function (_) {
            if (trulyDead) {
                this.kill();
				}
				else
				{
					revive();
				}
        }});
    }

	override function revive()
	{
		super.revive();

		FlxTween.tween(this, {alpha: 1}, 1, {
			ease: FlxEase.sineInOut
		});
	}

    public var allowMove:Bool = true;
    public var allowBound:Bool = true;

    override function update(elapsed:Float) {
        super.update(elapsed);

		if (allowMove)
		{
			var speed = 150;
			if (FlxG.keys.pressed.SHIFT)
			{
				speed = 75;
			}

			if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
			{
				x += (FlxG.keys.pressed.RIGHT ? 1 : -1) * speed * elapsed;
			}

			if (FlxG.keys.pressed.UP || FlxG.keys.pressed.DOWN)
			{
				y += (FlxG.keys.pressed.DOWN ? 1 : -1) * speed * elapsed;
			}

			if (FlxG.keys.justPressed.C)
			{
				flipX = !flipX;
			}
		}

		if (allowBound)
		{
			x = FlxMath.bound(x, 0, FlxG.width - width);
			y = FlxMath.bound(y, 0, FlxG.height - height);
		}
    }
}