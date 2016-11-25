package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxVelocity;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;

class DisparoBoss extends FlxSprite
{
	private var _left:Bool = false;
	private var _distance:Float = -1;
	private var _startX:Float;
	private var _startY:Float;
	private var _random:FlxRandom;
	private var _danio:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?angulo:Float = -1, ?Distance:Float = -1, ?Damage:Int = Reg.danioDisparoBoss, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(8, 8, FlxColor.WHITE);
		FlxG.state.add(this);
		_distance = Distance;
		_startX = X;
		_startY = Y;
		_danio = Damage;
		_random = new FlxRandom();
		if (angulo == -1)
		{
			loadGraphic(AssetPaths.bolaCosmica__png);
			//makeGraphic(8, 8, FlxColor.WHITE);
			FlxVelocity.moveTowardsObject(this, Reg.player, Reg.velocityBossDisparo);
		}
		else
		{
			loadGraphic(AssetPaths.rayoCosmico__png);
			//makeGraphic(8, 4, FlxColor.WHITE);
			angle = angulo;
			velocity.x = Reg.velocityBossDisparo * FlxMath.fastCos(angle);
			velocity.y = Reg.velocityBossDisparo * FlxMath.fastSin(angle);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (_distance != -1)
		{
			if (getDistance(_startX, _startY, x, y) >= _distance)
			{
				var free:Int = -1;
				for (s in 1...Reg.poisonArray.length)
				{
					if (Reg.poisonArray[s].isInUse() == false)
						free = s;
				}
				if (free != -1)
				{
					Reg.poisonArray[free].create(x, y, _random.int(0, 3), _random.float(5, 8), _random.int(1, 5));
					Reg.cantidadPoison++;
				}
			}
		}
		if (FlxG.collide(this, Reg.tilemap))
		{
			kill();
		}
		if (FlxG.overlap(this, Reg.player))
		{
			Reg.vidas -= _danio;
			kill();
		}
	}
	override public function kill():Void 
	{
		super.kill();
	}
	static public function getDistance(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		var dx:Float = x1 - x2;
		var dy:Float = y1 - y2;
		return Math.sqrt(dx * dx + dy * dy);
	}
	
}