package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;


class HealAnim extends FlxSprite
{
	private var _duration:Float;
	private var _startDuration:Float;
	private var _stage:Int = 0;
	public function new(?HealDuration:Float, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(Reg.player.x, Reg.player.y, SimpleGraphic);
		_stage = 1;
		_startDuration = HealDuration;
		_duration = HealDuration;
		loadGraphic(AssetPaths.heal_anim__png, true, 16, 16);
		animation.add("HealStart", [0, 1, 2, 3, 4], 5, false);
		animation.add("Healing", [5, 6, 7, 8, 9], 5, false);
		animation.add("HealStop", [10, 11, 12, 13 , 14], 5, false);
		FlxG.state.add(this);
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		_duration -= elapsed;
		if (_duration <= 0)
		{
			kill();
		}
		if (_stage == 1)
		{
			animation.play("HealStart");
			if (animation.name == null)
			{
				_stage = 2;
			}
		}
		if (_stage == 2)
		{
			animation.play("Healing");
			if (_duration <= _startDuration / 3)
			{
				_stage = 3;
				animation.stop();				
			}
		}
		if (_stage == 3)
		{
			animation.play("HealStop");
			if (animation.name == null)
			{
				_stage = 0;
				kill();
			}
		}
	}
	
}