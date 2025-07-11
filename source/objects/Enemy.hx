package objects;

import backend.ScriptsGame;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class Enemy extends FlxSprite
{
	public var type:String;
	public var enemyScore:Int = 10;
	public var enemyScript:ScriptsGame = null;
	public var ogColor:FlxColor;

	public function new(x:Float = 0, y:Float = 0, type:String = "shooter")
	{
        super(x, y);

        this.type = type;
		this.ogColor = this.color;

		enemyScript = new ScriptsGame('enemies/${type.toLowerCase()}');

		enemyScript.set("enemy", this);
		enemyScript.call("init", []);
	}
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		enemyScript.call("update", [elapsed]);
	}
	override function destroy()
	{
		super.destroy();

		enemyScript.call("destroy", []);
	}

	public function hit()
	{
		FlxTween.color(this, 0.1, FlxColor.RED, ogColor, {
			ease: FlxEase.sineInOut
		});
	}
}