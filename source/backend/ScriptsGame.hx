package backend;

import crowplexus.iris.Iris;
import crowplexus.iris.IrisConfig.RawIrisConfig;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import objects.Enemy;
import states.PlayState;
import sys.io.File;

using StringTools;

class ScriptsGame extends Iris
{
    public function new(file:String) {
		final rawConfig:RawIrisConfig = {name: '$file.hxs'};

		super(File.getContent(Paths.data('$file.hxs')), rawConfig);

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
		set('FlxColor', getFlxColor());

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
	public function getFlxColor()
		return {
			"BLACK": FlxColor.BLACK,
			"BLUE": FlxColor.BLUE,
			"BROWN": FlxColor.BROWN,
			"CYAN": FlxColor.CYAN,
			"GRAY": FlxColor.GRAY,
			"GREEN": FlxColor.GREEN,
			"LIME": FlxColor.LIME,
			"MAGENTA": FlxColor.MAGENTA,
			"ORANGE": FlxColor.ORANGE,
			"PINK": FlxColor.PINK,
			"PURPLE": FlxColor.PURPLE,
			"RED": FlxColor.RED,
			"TRANSPARENT": FlxColor.TRANSPARENT,
			"WHITE": FlxColor.WHITE,
			"YELLOW": FlxColor.YELLOW,
			"add": FlxColor.add,
			"fromCMYK": FlxColor.fromCMYK,
			"fromHSB": FlxColor.fromHSB,
			"fromHSL": FlxColor.fromHSL,
			"fromInt": FlxColor.fromInt,
			"fromRGB": FlxColor.fromRGB,
			"fromRGBFloat": FlxColor.fromRGBFloat,
			"fromString": FlxColor.fromString,
			"interpolate": FlxColor.interpolate,
			"to24Bit": function(color:Int) return color & 0xffffff
		};
}