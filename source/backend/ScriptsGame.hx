package backend;

import crowplexus.iris.Iris;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import objects.Enemy;
import states.PlayState;
import sys.io.File;

using StringTools;

class ScriptsGame extends Iris
{
    public function new(file:String) {
		super(File.getContent(Paths.data('$file.hxs')));

		// Imported
		set('Math', Math);
        set('FlxG', FlxG);
        set('FlxSprite', FlxSprite);
        set('FlxCamera', FlxCamera);
        set('FlxText', FlxText);
		set('FlxSpriteGroup', FlxSpriteGroup);
		set('FlxBackdrop', FlxBackdrop);
		set('Enemy', Enemy);
		set('FlxTimer', FlxTimer);
		set('FlxTween', FlxTween);
		set('FlxEase', FlxEase);
		set('Paths', Paths);

		// Some variable and functions
		set('game', FlxG.state);
		set('add', FlxG.state.add);
		set('remove', FlxG.state.remove);
		set('insert', FlxG.state.insert);

		// Enemy code
		set('addEnemy', function(type:String, ?setup:Enemy->Void, quantity:Int = 1)
		{
			return cast(FlxG.state, PlayState).addEnemy(type, setup, quantity);
		});
		set('getEnemies', function()
		{
			return cast(FlxG.state, PlayState).enemies;
		});
		set('wait', function(seconds:Float, callback:Void->Void)
		{
			new FlxTimer().start(seconds, function(_) callback());
		});
		set('getEnemyCount', function() return cast(FlxG.state, PlayState).enemies.length);
		set('startWave', function(waveNum:Int) return cast(FlxG.state, PlayState).script.call('wave$waveNum', []));
		set('nextWave', function(delay:Float = 2.0)
		{
			var state:PlayState = cast FlxG.state;
			new FlxTimer().start(delay, function(_)
			{
				state.curWave++;
				state.script.call('wave${state.curWave}', []);
			});
		});
	}

	override function call(fun:String, ?args:Array<Dynamic>):IrisCall
	{
		if (!exists(fun) || fun == null)
			return null;
		return super.call(fun, args);
	}
}