package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;

class Player extends FlxSprite
{
	private var _disparoTimer:Float;
	private var _up:Bool = false;
	private var _direction:Int = 0;
	private var canMove:Bool;
	private var castingSpell:Bool;
	private var castTime:Float;
	private var _timer:Float;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//makeGraphic(16, 16, FlxColor.WHITE);
		loadGraphic(AssetPaths.Mage__png, true, 16, 16);
		animation.add("down", [0, 1, 2, 3, 0], 6, false);
		animation.add("left", [4, 5, 6, 7, 4], 6, false);
		animation.add("right", [8, 9, 10, 11, 9], 6, false);
		animation.add("up", [12, 13, 14 , 15, 14], 6, false);
		animation.add("facedown", [0, 0], 6, false);
		animation.add("faceleft", [4, 4], 6, false);
		animation.add("faceright", [8, 9], 6, false);
		animation.add("faceup", [12, 14], 6, false);
		width = 10;
		height = 12;
		_timer = 0;
		_disparoTimer = 0;
		Reg.vidas = Reg.maxVidas;
		Reg.disparoArray = new Array<Disparo>();
		canMove = true;
		castingSpell = false;
		castTime = 0;
		
		FlxG.state.add(this);
		
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		_timer += elapsed;
		_disparoTimer += elapsed;
		velocity.x = 0;	velocity.y = 0;
		var shootx:Float = 0; var shooty:Float = 0;		
		switch(_direction)
		{
			case Reg.UP:{	shootx = x + width / 2; shooty = y;		}
			case Reg.DOWN:{	shootx = x + width / 2; shooty = y + height;	}
			case Reg.LEFT:{	shootx = x; shooty = y + height / 2;	}
			case Reg.RIGHT:{	shootx = x + width; shooty = y + height / 2;	}
			case Reg.UPRIGHT:{	shootx = x + width; shooty = y;		}
			case Reg.UPLEFT:{	shootx = x; shooty = y;		}
			case Reg.DOWNLEFT:{	shootx = x; shooty = y + height;	}
			case Reg.DOWNRIGHT:{	shootx = x + width; shooty = y + height;	}
		}
		if (Reg.vidas <= 0)
		{
			kill();
		}
		if (castingSpell)
		{
			castTime -= elapsed;			
			if (Reg.spellCasted == Reg.SPELLHEAL && _timer >= 0.4)
			{
				Reg.vidas += Reg.spellHealCura;
				Reg.spellHealEnCD = Reg.spellHealCoolDown;
				_timer = 0;
			}
			if (castTime <= 0)
			{
				if (Reg.spellCasted == Reg.SPELLDISPARO)
				{
					castingSpell = false;
					castTime = 0;
					canMove = true;
					Reg.spellCasted = Reg.SPELLNONE;
					Reg.spellUno = new SpellOne(shootx, shooty, _direction);
				}
				if (Reg.spellCasted == Reg.SPELLHEAL)
				{
					castingSpell = false;
					castTime = 0;
					canMove = true;
					Reg.spellCasted = Reg.SPELLNONE;
				}
			}
		}
		if (FlxG.keys.pressed.UP)
		{
			_direction = Reg.UP;
			if (canMove)
			{
				velocity.y = -Reg.playerSpeed;
				animation.play("up");
			}
			else
			{
				animation.play("faceup");	
			}
			if (FlxG.keys.pressed.LEFT)
			{
				_direction = Reg.UPLEFT;
				if (canMove)
				{
					velocity.x = -Reg.playerSpeed;
					animation.play("up");
				}
				else
				{
					animation.play("faceup");
				}
			}
			else if (FlxG.keys.pressed.RIGHT)
			{
				_direction = Reg.UPRIGHT;
				if (canMove)
				{				
					velocity.x = Reg.playerSpeed;
					animation.play("up");
				}
				else
				{
					animation.play("faceup");	
				}
			}
		}
		else if (FlxG.keys.pressed.DOWN)
		{
			_direction = Reg.DOWN;
			if (canMove)
			{
				velocity.y = Reg.playerSpeed;
				animation.play("down");
			}
			else
			{
				animation.play("facedown");	
			}
			if (FlxG.keys.pressed.LEFT)
			{
				_direction = Reg.DOWNLEFT;
				if (canMove)
				{
					velocity.x = -Reg.playerSpeed;
					animation.play("down");
				}
				else
				{
					animation.play("facedown");	
				}
			}
			else if (FlxG.keys.pressed.RIGHT)
			{
				_direction = Reg.DOWNRIGHT;
				if (canMove)
				{
					velocity.x = Reg.playerSpeed;
					animation.play("down");
				}
				else
				{
					animation.play("facedown");	
				}
			}
		}
		else
		{
			if (FlxG.keys.pressed.LEFT)
			{
				_direction = Reg.LEFT;
				if (canMove)
				{
					velocity.x = -Reg.playerSpeed;
					animation.play("left");
				}
				else
				{
					animation.play("faceleft");	
				}
			}
			else if (FlxG.keys.pressed.RIGHT)
			{
				_direction = Reg.RIGHT;
				if (canMove)
				{
					velocity.x = Reg.playerSpeed;
					animation.play("right");
				}
				else
				{
					animation.play("faceright");	
				}
			}
		}
		if (Reg.spellCasted == Reg.SPELLNONE)
		{
			if ((FlxG.keys.justPressed.C && castingSpell == false) && Reg.spellHealEnCD <= 0)
			{
				Reg.healingAnim = new HealAnim(Reg.spellHealCastTime);
				Reg.spellCasted = Reg.SPELLHEAL;
				castingSpell = true;
				canMove = false;
				castTime = Reg.spellHealCastTime;
			}
			if ((FlxG.keys.justPressed.X && castingSpell == false) && Reg.spellUnoEnCD <= 0)
			{
				Reg.spellCasted = Reg.SPELLDISPARO;
				castingSpell = true;
				canMove = false;
				castTime = Reg.spellOneCastTime;
			}
			if (FlxG.keys.pressed.Z && Reg.cantDisparos < 6)
			{
				if (_disparoTimer >= 0.2)
				{
					Reg.disparoArray[Reg.cantDisparos] = new Disparo(shootx, shooty, _direction);
					Reg.cantDisparos++;
					_disparoTimer = 0;
				}
			}
		}
	}
}