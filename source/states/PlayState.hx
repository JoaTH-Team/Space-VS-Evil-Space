package states;

import backend.ScriptsGame;
import backend.ScriptsStage;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import global.CurrentData;
import objects.Bullet;
import objects.Enemy;
import objects.Player;
import states.stuff.GameplayHUD;

class PlayState extends FlxState
{
	public var player:Player;
	public var bullets:Array<Bullet> = [];
	public var shootTimer:FlxTimer;

	public var enemies:Array<Enemy> = [];
	public var enemiesBullet:Array<Bullet> = [];

	public var gameplayHUD:GameplayHUD;

	public var stage:ScriptsStage;
	public var curStage:String = "world1";
	public var script:ScriptsGame;
	public var curScript:String = "level1";
	public var shootScript:ScriptsGame;
	public var curShootScript:String = "line";

	public var curWave:Int = 1;
	public var maxWave:Int = 10;

	override public function create()
	{
		shootTimer = new FlxTimer();
		shootTimer.finished = true;

		// init stage, scripts
		stage = new ScriptsStage(curStage);
		player = new Player(0, FlxG.height - 100);
		player.screenCenter(X);
		add(player);
		Player.shootType = LINE;

		script = new ScriptsGame('$curStage/scripts/$curScript');
		shootScript = new ScriptsGame('shoot_type/$curShootScript');

		callFunction("create", []);

		super.create();

		gameplayHUD = new GameplayHUD();
		add(gameplayHUD);
	}

	function shootFire()
	{
		shootScript.call("shoot", [player.x + player.width / 2 - 4, player.y + player.height / 2 - 4, bullets]);
	}

	override public function update(elapsed:Float)
	{
		callFunction("update", [elapsed]);
		super.update(elapsed);

		if (player.allowMove && FlxG.keys.pressed.Z && shootTimer.finished)
		{
			shootFire();
			shootTimer.start(0.1);
		}

		for (eBullet in enemiesBullet)
		{
			if (player.overlaps(eBullet))
			{
				CurrentData.HEALTH -= eBullet.power;

				@:privateAccess
				gameplayHUD.healthPlayer = CurrentData.HEALTH;

				eBullet.kill();
				remove(eBullet);
				enemiesBullet.remove(eBullet);

				if (CurrentData.HEALTH <= 0)
				{
					player.dead();
				}
			}
		}

		for (bullet in bullets)
		{
			if (bullet.x > FlxG.width || bullet.x + bullet.width < 0 || bullet.y > FlxG.height || bullet.y + bullet.height < 0)
			{
				remove(bullet);
				bullets.remove(bullet);
				bullet.destroy();
				continue;
			}

			for (enemy in enemies)
			{
				if (bullet.overlaps(enemy))
				{
					enemy.health -= bullet.power;
					if (enemy.health <= 0)
					{
						CurrentData.PRE_SCORE += enemy.enemyScore;
						remove(enemy);
						enemies.remove(enemy);
						enemy.destroy();
					}
					else
					{
						enemy.hit();
					}

					remove(bullet);
					bullets.remove(bullet);
					bullet.destroy();
					break;
				}
			}
		}
	}

	/**
	 * Adds enemy with callback for full control
	 * @param type Enemy type
	 * @param setup Optional setup callback (enemy:Enemy)->Void
	 * @param quantity How many to spawn (default 1)
	 * @return Array<Enemy> created enemies
	 */
	public function addEnemy(type:String, ?setup:Enemy->Void, quantity:Int = 1):Array<Enemy>
	{
		var createdEnemies = [];

		for (i in 0...quantity)
		{
			var enemy = new Enemy(FlxG.random.float(0, FlxG.width - 32), FlxG.random.float(0, FlxG.height - 32), type);

			if (setup != null)
				setup(enemy);

			add(enemy);
			enemies.push(enemy);
			createdEnemies.push(enemy);
		}

		return createdEnemies;
	}

	function callFunction(funcName:String, args:Array<Dynamic>)
	{
		stage.call(funcName, args);
		script.call(funcName, args);
		shootScript.call(funcName, args);
	}
	override function destroy()
	{
		super.destroy();

		callFunction("destroy", []);
	}
}
