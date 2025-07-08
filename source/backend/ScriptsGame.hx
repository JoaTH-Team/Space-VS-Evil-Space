package backend;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import joalor64gh.HScript;

class ScriptsGame extends HScript
{
    public function new(file:String) {
        super(file, true);

        set('FlxG', FlxG);
        set('FlxSprite', FlxSprite);
        set('FlxCamera', FlxCamera);
        set('FlxText', FlxText);
    }    
}