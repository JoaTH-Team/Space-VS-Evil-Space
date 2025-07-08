package objects;

import flixel.FlxSprite;
import flixel.util.FlxColor;

enum EnemyType {
    SHOOTER;
    LASER_SHOOTER;
}

class Enemy extends FlxSprite
{
    public var type:EnemyType;
	public var enemyScore:Int = 10;

    public function new(x:Float = 0, y:Float = 0, type:EnemyType) {
        super(x, y);

        this.type = type;

        switch (this.type) {
            case SHOOTER:
                loadGraphic(Paths.images("enemy_shooter"), false);
				health = enemyScore = 10;
            case LASER_SHOOTER:
                makeGraphic(32, 32, FlxColor.RED);
				health = enemyScore = 20;
        }
    }    
}