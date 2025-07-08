package backend;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import joalor64gh.HScript;
import objects.Enemy.EnemyType;
import openfl.Lib;
import states.PlayState;

using StringTools;

class ScriptsGame extends HScript
{
    public function new(file:String) {
		super(Paths.data(file + '.hxs'), false);
		parser.allowJSON = parser.allowTypes = parser.allowMetadata = true;

		// Imported Class
        set('FlxG', FlxG);
        set('FlxSprite', FlxSprite);
        set('FlxCamera', FlxCamera);
        set('FlxText', FlxText);
		set('FlxSpriteGroup', FlxSpriteGroup);
		set('FlxBackdrop', FlxBackdrop);
		// Some variable and functions
		set('import', importFunc);
		set('game', FlxG.state);
		set('add', FlxG.state.add);
		set('remove', FlxG.state.remove);
		set('insert', FlxG.state.insert);
		// Enemy code
		set('SHOOTER', EnemyType.SHOOTER);
		set('LASER_SHOOTER', EnemyType.LASER_SHOOTER);
		set('addEnemy', function(type:EnemyType, x:Float = 0, y:Float = 0, quantity:Int = 1, xVel:Float = 0, yVel:Float = 0, health:Float = -1)
		{
			return cast(FlxG.state, PlayState).addEnemy(type, x, y, quantity, xVel, yVel, health);
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

		executeFile(Paths.data(file + '.hxs'));
	}

	function importFunc(daClass:String, ?asDa:String)
	{
		final splitClassName = [for (e in daClass.split('.')) e.trim()];
		final className = splitClassName.join('.');
		final daClassObj:Class<Dynamic> = Type.resolveClass(className);
		final daEnum:Enum<Dynamic> = Type.resolveEnum(className);

		if (daClassObj == null && daEnum == null)
			Lib.application.window.alert('Class / Enum at $className does not exist.', 'HScript Error!');
		else if (daEnum != null)
		{
			var daEnumField = {};
			for (daConstructor in daEnum.getConstructors())
				Reflect.setField(daEnumField, daConstructor, daEnum.createByName(daConstructor));
			set(asDa != null && asDa != '' ? asDa : splitClassName[splitClassName.length - 1], daEnumField);
		}
		else
			set(asDa != null && asDa != '' ? asDa : splitClassName[splitClassName.length - 1], daClassObj);
	}
}