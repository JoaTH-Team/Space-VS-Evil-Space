package backend;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import joalor64gh.HScript;
import openfl.Lib;

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