package substates;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import global.GroupCreation;

class PauseSubState extends FlxSubState
{
    var listArray:Array<String> = [
        "Resume Game",
        "Restart Game",
        "Return Menu"
    ];
    var menuGroup:GroupCreation;
    var menuItems:Array<FlxText> = [];

    override function create() {
        super.create();

        menuGroup = new GroupCreation(true, 40);
        for (i in 0...listArray.length) {
            var item = new FlxText(0, 0, 0, listArray[i], 32);
            item.screenCenter(X);
            menuItems.push(item);
            menuGroup.addItem(item);
        }
        menuGroup.setPosition(50, FlxG.height / 2 - (listArray.length * 60) / 2);
        add(menuGroup.group);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.UP) {
            menuGroup.selectPrevious();
        }
        if (FlxG.keys.justPressed.DOWN) {
            menuGroup.selectNext();
        }
        if (FlxG.keys.justPressed.ENTER) {
            switch (menuGroup.selectedIndex) {
                case 0: // Resume
                    FlxG.state.persistentUpdate = true;
                    FlxTimer.globalManager.forEach(function(time:FlxTimer)
                    {
                        time.active = true;
                    });
                    FlxTween.globalManager.forEach(function(tween:FlxTween)
                    {
                        tween.active = true;
                    });
                    close();
                case 1: // Restart
                    FlxG.resetGame();
                case 2: // Return to menu
            }
        }
    }
}