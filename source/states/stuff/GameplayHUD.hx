package states.stuff;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import global.CurrentData.*;

class GameplayHUD extends FlxSpriteGroup
{
    var scoreText:FlxText;

    public function new() {
        super();

        scoreText = new FlxText(15, 15, 0, "Score: " + SCORE, 18);
        scoreText.setBorderStyle(OUTLINE, FlxColor.BLACK);
        add(scoreText);
    }    

    override function update(elapsed:Float) {
        super.update(elapsed);

        scoreText.text = "Score: " + SCORE;
    }
}