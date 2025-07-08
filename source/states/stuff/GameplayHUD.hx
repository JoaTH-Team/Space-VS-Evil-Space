package states.stuff;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import global.CurrentData;

class GameplayHUD extends FlxSpriteGroup
{
    var scoreText:FlxText;
	var pendingScoreTimer:FlxTimer;

	var displayedScore:Float = 0;
	var displayedPending:Float = 0;
	var lerpSpeed:Float = 0.5;

    public function new() {
        super();

		scoreText = new FlxText(15, 15, 0, "", 18);
        scoreText.setBorderStyle(OUTLINE, FlxColor.BLACK);
        add(scoreText);
		pendingScoreTimer = new FlxTimer();
		displayedScore = CurrentData.SCORE;
		displayedPending = CurrentData.PRE_SCORE;
		updateDisplay();
	}

	function updateDisplay()
	{
		if (CurrentData.PRE_SCORE > 0)
		{
			scoreText.text = "Score: " + Std.int(displayedScore) + " (+" + Std.int(displayedPending) + ")";

			if (!pendingScoreTimer.active)
			{
				pendingScoreTimer.start(1, function(t:FlxTimer)
				{
					CurrentData.SCORE += CurrentData.PRE_SCORE;
					CurrentData.PRE_SCORE = 0;
				});
			}
		}
		else
		{
			scoreText.text = "Score: " + Std.int(displayedScore);
		}
	}

    override function update(elapsed:Float) {
        super.update(elapsed);
		displayedScore = FlxMath.lerp(displayedScore, CurrentData.SCORE, lerpSpeed);
		displayedPending = FlxMath.lerp(displayedPending, CurrentData.PRE_SCORE, lerpSpeed);

		if (Math.abs(displayedScore - CurrentData.SCORE) < 1)
			displayedScore = CurrentData.SCORE;
		if (Math.abs(displayedPending - CurrentData.PRE_SCORE) < 1)
			displayedPending = CurrentData.PRE_SCORE;

		updateDisplay();
    }
}