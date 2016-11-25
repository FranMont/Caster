package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class LaserBeam extends FlxSprite
{
	private var _directionR:Bool;
	private var tileWidht:Int = Std.int(Reg.tilemap.width);
	private var tileHeight:Int = Std.int(Reg.tilemap.height);
	private var _killTime:Float;
	private var _duration:Float;
	public function new(?X:Float = 0, ?Y:Float = 0, ?Direction:Bool = true, ?Duration:Float = 5, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		_directionR = Direction;
		_duration = Duration;
		if (_directionR)
		{
			makeGraphic(tileWidht-24, 2, FlxColor.RED);
		}
		else
		{
			makeGraphic(2, tileHeight-24, FlxColor.RED);
		}
		alpha = 0.3;
		_killTime = 0;
		FlxG.state.add(this);
	}	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		_killTime += elapsed;
		if (_killTime > 2)
		{
			if (_duration > 0)
			{
				alpha = 1;
				if (_directionR)
				{
					makeGraphic(tileWidht-24, 4, FlxColor.RED);
				}
				else
				{
					makeGraphic(4, tileHeight-24, FlxColor.RED);
				}
				if (FlxG.overlap(this, Reg.player))
				{
					Reg.vidas--;
					if (Reg.vidas <= 0)
					{
						Reg.player.kill();
					}
				}
				_duration-=1;
			}
			else
			{
				kill();
			}
		}
	}
}