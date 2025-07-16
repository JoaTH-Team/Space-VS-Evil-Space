package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import global.GroupCreation;
import lime.app.Application;

class MenuState extends FlxState
{
    var listArray:Array<String> = [
        "Play",
        "Options",
        "Exit"
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
		menuGroup.updateSelection();
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
                case 0: // Play
                    FlxG.switchState(() -> new SelectLevelState());
                case 1: // Options

                case 2: // Exit Game
                    Application.current.window.alert("Game will now exit", "Note");
                    Sys.exit(0);
            }
        }
    }
}