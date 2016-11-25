package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxRandom;

class HealAnimBoss extends FlxSprite
{
	private var _stage:Int = 0;
	private var _random:FlxRandom;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		_stage = 0;
		loadGraphic(AssetPaths.healboss__png, true, 32, 32);
		animation.add("HealStart", [0, 1, 2, 3, 4], 5, false);
		animation.add("Healing", [5, 6, 7, 8, 9],5 , false);
		animation.add("HealingDos", [10, 11, 12, 13, 14], 5, false);
		animation.add("HealStop", [15, 16, 17, 18, 19, 20, 21], 5, false);
		_random = new FlxRandom();
		hide();
		FlxG.state.add(this);
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (Reg.vidasBoss > 1)
		{
			if (Reg.vidasBoss > Std.int(Reg.maxVidasBoss / 5) && (_stage > 0 && _stage <= 2))
			{
				_stage = 3;
			}
			if (Reg.vidasBoss <= Std.int(Reg.maxVidasBoss / 5) && _stage == 0)
			{
				show();
				_stage = 1;
			}
			if (_stage == 1)
			{
				_stage = 2;
				animation.play("HealStart");
			}
			if (_stage == 2)
			{
				animation.play("Healing");
			}
			if (_stage == 3)
			{
				_stage = 4;
				animation.play("HealStop");				
			}
			if (_stage == 4)
			{
				if (animation.name == null)
				{
					hide();
					_stage = 0;
				}
			}
		}
		else
		{
			hide();
			_stage = 0;
		}
	}
	private function show()
	{
		alpha = 1;
	}
	private function hide()
	{
		alpha = 0;
	}
}