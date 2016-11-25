package;

import flixel.FlxG;
import flixel.addons.effects.chainable.FlxOutlineEffect.FlxOutlineMode;
import flixel.math.FlxAngle;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Boss extends FlxSprite
{
	private var _itsAlive:Bool;
	private var _angulo:Float = 0;
	private var random:FlxRandom;
	private var _facingR:Bool;
	private var _facingU:Bool;
	private var _timerAttack:Float = 0;
	private var _timerHabilities:Float = 0;
	private var _timerHabilities2:Float = 0;
	private var _timerHabilities3:Float = 0;
	private var _random:FlxRandom;
	
	inline static var minDisparos:Int = 5;
	inline static var maxDisparos:Int = 16;
	inline static var minDistance:Int = 50;
	inline static var maxDistance:Int = 100;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		x -= 1;
		y -= 4;
		loadGraphic(AssetPaths.Firemage1__png, true, 32, 32);
		animation.add("idle", [0], 6, false);
		animation.add("attack", [1, 1, 1, 1, 0], 6, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		Reg.vidasBoss = Reg.maxVidasBoss;
		_random = new FlxRandom();
		FlxG.state.add(this);
		_itsAlive = true;
		random = new FlxRandom();
		Reg.disparosBossArray = new Array<DisparoBoss>();
		Reg._healBossAnim = new HealAnimBoss(x,y);
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (_itsAlive)
		{
			if (Reg.vidasBoss <= 0)
			{
				_itsAlive = false;
			}
			_timerAttack += elapsed;
			_timerHabilities += elapsed;
			if (_timerAttack > 2.2)
			{
				animation.play("attack");
				var disparoo = new DisparoBoss(x + width / 2, y + height / 2);
				_timerAttack = 0;
			}
			if (Reg.vidasBoss < Reg.maxVidasBoss / 5)
			{
				_timerHabilities3 += elapsed;
				if (_timerHabilities3 > 1.5)
				{
					Reg.vidasBoss += Reg.curaBoss;
					_timerHabilities3 = 0;
				}
			}
			if (Reg.vidasBoss < Reg.maxVidasBoss / 2)
			{
				_timerHabilities2 += elapsed;
				if (_timerHabilities2 > 5)
				{
					var free:Int = -1;
					var randomSize:Int = _random.int(0, 3);
					for (s in 1...Reg.poisonArray.length)
					{
						if (Reg.poisonArray[s].isInUse() == false)
							free = s;
					}
					if (free == -1)
					{
						free = Reg.poisonArray.length - 1;
						Reg.poisonArray[Reg.poisonArray.length - 1].freePoison();
					}
					if (free != -1)
					{
						Reg.poisonArray[free].create(Reg.player.x-randomSize, Reg.player.y-randomSize, randomSize, _random.float(5, 8), _random.int(1, 5));
						Reg.cantidadPoison++;
					}
					_timerHabilities2 = 0;
				}
			}
			if (_timerHabilities > 5)
			{
				animation.play("attack");
				var randoom:Int = random.int(minDisparos, maxDisparos);
				_angulo = FlxAngle.asRadians(360 / randoom);
				for (a in 0...randoom)
				{				
					Reg.disparosBossArray.push(new DisparoBoss(x + width / 2, y + height / 2, (_angulo * a + FlxAngle.asRadians(360)), random.int(minDistance,maxDistance), random.int(Reg.danioDisparoBoss,Reg.danioDisparoBoss+5)));
				}
				_timerHabilities = 0;
			}
			if (FlxG.keys.justReleased.U)
			{
				animation.play("attack");
				var randoom:Int = random.int(minDisparos, maxDisparos);
				_angulo = FlxAngle.asRadians(360 / randoom);
				for (a in 0...randoom)
				{				
					Reg.disparosBossArray.push(new DisparoBoss(x + width / 2, y + height / 2, (_angulo * a + FlxAngle.asRadians(360)), random.int(minDistance,maxDistance)));
				}
			}
			if (FlxG.keys.justReleased.Q)
			{
				animation.play("attack");
				var disparoo = new DisparoBoss(x + width / 2, y + height / 2);
			}
		}
		else
		{
			loadGraphic(AssetPaths.bossrip__png);
		}
	}
	override public function kill()
	{
		
		super.kill();
	}
}