package;

import flixel.addons.display.FlxRuntimeShader;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import openfl.utils.Assets;

class PlayState extends FlxState
{
	var effectTween:FlxTween;

	override public function create():Void
	{
		var effect:FlxRuntimeShader = new FlxRuntimeShader(Assets.getText('assete/data/mosaic.frag'));
		effect.setFloatArray('uBlocksize', [1, 1]);

		var backdrop:FlxSprite = new FlxSprite(0, 0, 'assets/images/backdrop.png');
		backdrop.shader = effect;
		add(backdrop);

		#if mobile
		var infoText:FlxText = new FlxText(10, 10, 100, 'Touch to pause the effect.');
		#else
		var infoText:FlxText = new FlxText(10, 10, 100, 'Press SPACE to pause the effect.');
		#end
		infoText.color = FlxColor.BLACK;
		add(infoText);

		effectTween = FlxTween.num(1, 15, 2, {type: PINGPONG}, function(v)
		{
			effect.setFloatArray('uBlocksize', [v, v]);
		});
	}

	override public function update(elapsed:Float):Void
	{
		#if mobile
		for (touch in FlxG.touches.list)
			if (touch.justPressed)
				effectTween.active = !effectTween.active;
		#else
		if (FlxG.keys.justPressed.SPACE)
			effectTween.active = !effectTween.active;
		#end

		super.update(elapsed);
	}
}
