package objects;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

enum BulletType {
    LINE;
    LITTLE_RANGE;
}

class Bullet extends FlxSprite
{
	public var power:Int = 1;
	public var speed:Float = 100;
	public var waveAmplitude:Float = 30;
	public var waveFrequency:Float = 2;
	public var waveTimer:Float = 0;

	public function new(x:Float = 0, y:Float = 0, type:BulletType = LINE)
	{
        super(x, y);
		switch (type)
		{
			case LINE: // Standard, okay power
				makeGraphic(16, 8, FlxColor.WHITE);
				power = 10;
				velocity.x = 600;
			case LITTLE_RANGE: // Really Fast, But less power
				makeGraphic(8, 8, FlxColor.WHITE);
				power = 5;
				velocity.x = 1000;
		}
	}
}