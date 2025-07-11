package objects;

import backend.ScriptsGame;
import flixel.FlxSprite;

class Enemy extends FlxSprite
{
	public var type:String;
	public var enemyScore:Int = 10;
	public var enemyScript:ScriptsGame = null;

	public function new(x:Float = 0, y:Float = 0, type:String = "shooter")
	{
        super(x, y);

        this.type = type;

		enemyScript = new ScriptsGame('enemies/${type.toLowerCase()}');

		enemyScript.set("enemy", this);
		enemyScript.call("init", []);
	}
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		enemyScript.call("update", [elapsed]);
	}
}