package states.stuff;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import global.CurrentData;

class GameplayHUD extends FlxSpriteGroup
{
    var scoreText:FlxText;
	var healthBar:FlxBar;
	var healthPlayer:Int = 100;
	var pendingScoreTimer:FlxTimer;

	var displayedScore:Float = 0;
	var displayedPending:Float = 0;
	var lerpSpeed:Float = 0.5;

    public function new() {
		healthPlayer = CurrentData.HEALTH;

        super();

		scoreText = new FlxText(15, 15, 0, "", 18);
        scoreText.setBorderStyle(OUTLINE, FlxColor.BLACK);
        add(scoreText);
		pendingScoreTimer = new FlxTimer();
		displayedScore = CurrentData.SCORE;
		displayedPending = CurrentData.PRE_SCORE;
		updateDisplay();
		healthBar = new FlxBar(scoreText.x, scoreText.height + 20, LEFT_TO_RIGHT, 100, 10, this, "healthPlayer", 0, 100, true);
		add(healthBar);
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