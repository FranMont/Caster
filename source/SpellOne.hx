package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class SpellOne extends FlxSprite
{
	private var _direction:Int = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?Facing:Int = 0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		_direction = Facing;
		Reg.spellUnoEnCD = Reg.spellOneCoolDown;
		//makeGraphic(8, 8, FlxColor.YELLOW);
		loadGraphic(AssetPaths.fireball1__png, false, 8, 8);
		switch(_direction)
		{
			case Reg.UP:
				{
					velocity.y = -Reg.velocitySpell;
				}
			case Reg.DOWN:
				{
					velocity.y = Reg.velocitySpell;
				}
			case Reg.LEFT:
				{
					velocity.x = -Reg.velocitySpell;
				}
			case Reg.RIGHT:
				{
					velocity.x = Reg.velocitySpell;
				}
			case Reg.UPRIGHT:
				{
					velocity.y = -Reg.velocitySpell;
					velocity.x = Reg.velocitySpell;
				}
			case Reg.UPLEFT:
				{
					velocity.y = -Reg.velocitySpell;
					velocity.x = -Reg.velocitySpell;
				}
			case Reg.DOWNLEFT:
				{
					velocity.y = Reg.velocitySpell;
					velocity.x = -Reg.velocitySpell;
				}
			case Reg.DOWNRIGHT:
				{
					velocity.y = Reg.velocitySpell;
					velocity.x = Reg.velocitySpell;
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
			Reg.vidasBoss -= 50;
			kill();
		}
	}

}