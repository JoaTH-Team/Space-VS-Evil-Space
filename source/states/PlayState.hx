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

	public var gameplayHUD:GameplayHUD;

	public var stage:ScriptsStage;
	public var curStage:String = "world1";
	public var script:ScriptsGame;
	public var curScript:String = "level1";

	public var curWave:Int = 1;
	public var maxWave:Int = 10;

	override public function create()
	{
		shootTimer = new FlxTimer();
		shootTimer.finished = true;

		// init stage, scripts
		stage = new ScriptsStage(curStage);
		script = new ScriptsGame('$curStage/scripts/$curScript');

		callFunction("create", []);

		player = new Player(50, 0);
		player.screenCenter(Y);
		add(player);
		Player.shootType = LINE;
		super.create();

		gameplayHUD = new GameplayHUD();
		add(gameplayHUD);
	}

	function shootFire()
	{
		switch (Player.shootType)
		{
			case LINE:
				var bullet:Bullet = new Bullet((player.x + player.width / 2 - 4) + 25, (player.y + player.height / 2 - 4) + 2);
				add(bullet);
				bullets.push(bullet);
				var bullet:Bullet = new Bullet((player.x + player.width / 2 - 4) + 5, (player.y + player.height / 2 - 4) + 20);
				bullet.power = 5;
				add(bullet);
				bullets.push(bullet);

				var bullet:Bullet = new Bullet((player.x + player.width / 2 - 4) + 5, (player.y + player.height / 2 - 4) + -14);
				bullet.power = 5;
				add(bullet);
				bullets.push(bullet);
			case LITTLE_RANGE:
				var bullet:Bullet = new Bullet((player.x + player.width / 2 - 4) + 25, (player.y + player.height / 2 - 4) + 2);
				add(bullet);
				bullets.push(bullet);
				for (i in 0...2)
				{
					var bullet:Bullet = new Bullet((player.x + player.width / 2 - 4) + 25, (player.y + player.height / 2 - 4) + 2);
					bullet.velocity.y = -40 * i;
					bullet.power = 5;
					bullet.angle = -40 * i;
					add(bullet);
					bullets.push(bullet);
				}

				for (i in 0...2)
				{
					var bullet:Bullet = new Bullet((player.x + player.width / 2 - 4) + 25, (player.y + player.height / 2 - 4) + 2);
					bullet.velocity.y = 40 * i;
					bullet.power = 5;
					bullet.angle = 40 * i;
					add(bullet);
					bullets.push(bullet);
				}
		}
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

		for (bullet in bullets)
		{
			if (bullet.x > FlxG.width || bullet.x + bullet.width < 0 || bullet.y > FlxG.height || bullet.y + bullet.height < 0)
			{
				remove(bullet);
				bullets.remove(bullet);
				bullet.destroy();
			}
			for (bullet in bullets)
			{
				if (bullet.x > FlxG.width || bullet.x + bullet.width < 0 || bullet.y > FlxG.height || bullet.y + bullet.height < 0)
				{
					remove(bullet);
					bullets.remove(bullet);
					bullet.destroy();
					break;
				}

				for (enemy in enemies)
				{
					if (bullet.overlaps(enemy))
					{
						enemy.health -= bullet.power;
						if (enemy.health >= 0)
						{
							CurrentData.PRE_SCORE += enemy.enemyScore;
							remove(enemy);
							enemies.remove(enemy);
							enemy.destroy();
						}

						remove(bullet);
						bullets.remove(bullet);
						bullet.destroy();

						break;
					}
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
	public function addEnemy(type:EnemyType, ?setup:Enemy->Void, quantity:Int = 1):Array<Enemy>
	{
		var createdEnemies = [];

		for (i in 0...quantity)
		{
			var enemy = new Enemy(FlxG.random.float(0, FlxG.width - 32), FlxG.random.float(0, FlxG.height - 32), type);

			enemy.health = switch (type)
			{
				case SHOOTER: 10;
				case LASER_SHOOTER: 20;
			};

			if (setup != null)
				setup(enemy);

			add(enemy);
			enemies.push(enemy);
			createdEnemies.push(enemy);
		}

		return createdEnemies;
	}

	public function startScriptSequence()
	{
		callFunction("startEnemySequence", []);
	}

	function callFunction(funcName:String, args:Array<Dynamic>)
	{
		stage.call(funcName, args);
		script.call(funcName, args);
	}
}
