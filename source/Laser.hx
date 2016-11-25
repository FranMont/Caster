package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import Reg;

class Laser extends FlxSprite
{
	private var _directionR:Bool = false;
	private var tileWidht:Int = Std.int(Reg.tilemap.width);
	private var tileHeight:Int = Std.int(Reg.tilemap.height);
	private var timer:Float = 0;
	private var _randomDuration:FlxRandom;
	public function new(?X:Float=0, ?Y:Float=0, ?DirectionR:Bool = true, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		_directionR = DirectionR;
		x -= 4;
		y -= 4;
		makeGraphic(4, 4, FlxColor.ORANGE);
		_randomDuration = new FlxRandom();
		FlxG.state.add(this);
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		timer += elapsed;
		if (timer >= 5 && Reg.vidas > 0)
		{
			timer = 0;
			var laserBeam = new LaserBeam(x, y, _directionR, _randomDuration.int(65, 115));
		}
	}
}