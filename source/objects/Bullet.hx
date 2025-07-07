package objects;

import flixel.FlxSprite;

enum BulletType {
    LINE;
    LITTLE_RANGE;
}

class Bullet extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0) {
        super(x, y);
    }
}