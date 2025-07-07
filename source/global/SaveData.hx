package global;

import flixel.FlxG;

class SaveData {
    public static function init():Void {
        if (FlxG.save.data.runAt120FPS == null)
            FlxG.save.data.runAt120FPS = false;
        if (FlxG.save.data.fullScreen == null)
            FlxG.save.data.fullScreen = false;

        FlxG.save.bind("SVSES_Data", "SpaceVSEvilSpace");
        FlxG.save.flush();

        trace("Successfully Init Save Data");
    }
}