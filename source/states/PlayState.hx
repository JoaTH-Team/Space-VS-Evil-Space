package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import objects.Bullet;
import objects.Player;

class PlayState extends FlxState
{
	var player:Player;
	var bullets:Array<Bullet> = [];
	var shootTimer:FlxTimer;

	override public function create()
	{
		shootTimer = new FlxTimer();
		shootTimer.finished = true;

		super.create();
		player = new Player(50, 0);
		player.screenCenter(Y);
		add(player);
		Player.shootType = LITTLE_RANGE;
	}

	function shootFire()
	{
		switch (Player.shootType)
		{
			case LINE:
				var bullet:Bullet = new Bullet((player.x + player.width / 2 - 4) + 25, (player.y + player.height / 2 - 4) + 2);
				add(bullet);
				bullets.push(bullet);
			case LITTLE_RANGE:
				var bullet:Bullet = new Bullet((player.x + player.width / 2 - 4) + 25, (player.y + player.height / 2 - 4) + 2, LITTLE_RANGE);
				add(bullet);
				bullets.push(bullet);

				for (i in 0...3)
				{
					var bullet:Bullet = new Bullet((player.x + player.width / 2 - 4) + 25, (player.y + player.height / 2 - 4) + 2, LITTLE_RANGE);
					bullet.scale.set(0.4, 0.4);
					bullet.velocity.y -= 20 * i;
					bullet.angle = 20 * i;
					bullet.power = Std.int(5 - i);
					add(bullet);
					bullets.push(bullet);
				}
		}
	}

	override public function update(elapsed:Float)
	{
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
		}
	}
}
