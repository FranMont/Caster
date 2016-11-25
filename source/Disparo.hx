package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Disparo extends FlxSprite
{
	private var _direction:Int = 0;
	public function new(?X:Float = 0, ?Y:Float = 0, ?Facing:Int = 0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		_direction = Facing;
		makeGraphic(3, 3, FlxColor.WHITE);
		switch(_direction)
		{
			case Reg.UP:
				{
					velocity.y = -Reg.velocityDisparo;
				}
			case Reg.DOWN:
				{
					velocity.y = Reg.velocityDisparo;
				}
			case Reg.LEFT:
				{
					velocity.x = -Reg.velocityDisparo;
				}
			case Reg.RIGHT:
				{
					velocity.x = Reg.velocityDisparo;
				}
			case Reg.UPRIGHT:
				{
					velocity.y = -Reg.velocityDisparo;
					velocity.x = Reg.velocityDisparo;
				}
			case Reg.UPLEFT:
				{
					velocity.y = -Reg.velocityDisparo;
					velocity.x = -Reg.velocityDisparo;
				}
			case Reg.DOWNLEFT:
				{
					velocity.y = Reg.velocityDisparo;
					velocity.x = -Reg.velocityDisparo;
				}
			case Reg.DOWNRIGHT:
				{
					velocity.y = Reg.velocityDisparo;
					velocity.x = Reg.velocityDisparo;
				}
		}
		FlxG.state.add(this);
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.collide(this, Reg.tilemap))
		{
			kill();
		}
		if (FlxG.overlap(this, Reg.boss))
		{
			Reg.vidasBoss -= 4;
			kill();
		}
	}
	override public function kill()
	{
		Reg.cantDisparos--;
		super.kill();
	}	
}