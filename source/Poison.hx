package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Poison extends FlxSprite
{
	private var _duration:Float;
	private var _timer:Float;
	private var _damage:Int;
	private var _size:Int;
	private var _inUse:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(40, 40, FlxColor.GREEN);
		hide();
		_inUse = false;
		_timer = 0;
		_duration = 0;
		FlxG.state.add(this);
	}
	public function create(?X:Float, ?Y:Float, ?Size:Int, ?Duration:Float = 5, ?Damage:Int = 1)
	{
		x = X;
		y = Y;
		_damage = Damage;
		_size = Size;
		_duration = Duration;
		switch(_size)
		{
			case 0: //8 cambiado a 16
				{
					loadGraphic(AssetPaths.poison16__png);
				}
			case 1: //16
				{
					loadGraphic(AssetPaths.poison16__png);
				}
			case 2: //32
				{
					loadGraphic(AssetPaths.poison32__png);
				}
			case 3: //40
				{
					loadGraphic(AssetPaths.poison40__png);
				}
			case 4: //64
				{
					loadGraphic(AssetPaths.poison64__png);
				}
			default:
				{
					loadGraphic(AssetPaths.poison16__png);
				}
		}
		_inUse = true;
		show();
	}
	public function isInUse():Bool
	{
		return _inUse;
	}
	public function freePoison()
	{
		hide();
		_size = 0;
		x = Reg.tilemap.width;
		y = Reg.tilemap.height;
		_inUse = false;
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (_inUse)
		{
			_timer += elapsed;
			_duration -= elapsed;
			if (_duration <= 0)
			{
				freePoison();
			}
			if (FlxG.overlap(this, Reg.player))
			{
				if (_timer >= 0.8)
				{
					Reg.vidas -= _damage;
					_timer = 0;
				}
			}
		}
		else
		{
			hide();
		}
	}
	public function show():Void
	{
		alpha = 1;
	}
	public function hide():Void
	{
		alpha = 0;
	}
	override public function kill()
	{
		super.kill();
	}
}