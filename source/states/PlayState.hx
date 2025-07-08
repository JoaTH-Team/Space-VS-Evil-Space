package states;

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
	var player:Player;
	var bullets:Array<Bullet> = [];
	var shootTimer:FlxTimer;

	var enemies:Array<Enemy> = [];

	var gameplayHUD:GameplayHUD;

	override public function create()
	{
		shootTimer = new FlxTimer();
		shootTimer.finished = true;

		player = new Player(50, 0);
		player.screenCenter(Y);
		add(player);
		Player.shootType = LITTLE_RANGE;
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
		super.update(elapsed);
		if (FlxG.keys.justReleased.P)
			addEnemy(LASER_SHOOTER, -3, -1, 1, -100, 0, 30);

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
		}
	}
	/**
	 * Added enemy to the game
	 * @param type The type of enemy to spawn
	 * @param x X position (use -1 for random, -2 for left edge, -3 for right edge)
	 * @param y Y position (use -1 for random, -2 for top edge, -3 for bottom edge)
	 * @param quantity How many enemies to spawn (default 1)
	 * @param xVel Horizontal velocity (0 for stationary)
	 * @param yVel Vertical velocity (0 for stationary)
	 * @param health Custom health value (default based on enemy type)
	 * @return Array<Enemy> The created enemies
	 */
	public function addEnemy(type:EnemyType, x:Float = 0, y:Float = 0, quantity:Int = 1, xVel:Float = 0, yVel:Float = 0, health:Float = -1):Array<Enemy>
	{
		var createdEnemies:Array<Enemy> = [];

		for (i in 0...quantity)
		{
			// Handle special position cases
			var finalX:Float = switch (x)
			{
				case -1: FlxG.random.float(0, FlxG.width - 32);
				case -2: 0;
				case -3: FlxG.width - 32;
				default: x;
			};

			var finalY:Float = switch (y)
			{
				case -1: FlxG.random.float(0, FlxG.height - 32);
				case -2: 0;
				case -3: FlxG.height - 32;
				default: y;
			};

			// Create enemy
			var enemy:Enemy = new Enemy(finalX, finalY, type);
			enemy.velocity.set(xVel, yVel);

			// Set custom health if provided
			if (health > 0)
			{
				enemy.health = health;
			}
			else
			{
				// Default health based on type
				enemy.health = switch (type)
				{
					case SHOOTER: 10;
					case LASER_SHOOTER: 20;
				};
			}

			enemies.push(enemy);
			add(enemy);
			createdEnemies.push(enemy);
		}

		return createdEnemies;
	}
}
