package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
import flixel.FlxCamera;
/* Barra de Vida
 * 62x6
 */	
class Interfaz extends FlxTypedGroup<FlxSprite>
{
	private var barraVida:FlxSprite;
	private var barraVida2:FlxSprite;
	private var barraVidaBoss:FlxSprite;
	private var barraVidaBoss2:FlxSprite;
	private var skillIcon:FlxSprite;
	private var skillHeal:FlxSprite;
	private var vidasF:Float= 0;
	private var vidasI:Int= 0;
	public function new()
	{
		super();
		barraVida2 = new FlxSprite(11, 14);
		barraVida2.makeGraphic(62, 6, FlxColor.BLUE);
		barraVida = new FlxSprite(10, 10);
		barraVida.loadGraphic(AssetPaths.barraVida__png);
		barraVidaBoss = new FlxSprite(FlxG.width - 76, 10);
		barraVidaBoss.loadGraphic(AssetPaths.barraVida__png);
		barraVidaBoss2 = new FlxSprite(FlxG.width - 75, 14);
		barraVidaBoss2.makeGraphic(62, 5, FlxColor.RED);
		skillHeal = new FlxSprite(30, 10 + barraVida.height + 2);
		skillHeal.loadGraphic(AssetPaths.skillHeal__png);
		skillIcon = new FlxSprite(10, 10 + barraVida.height + 2);
		skillIcon.loadGraphic(AssetPaths.skillone__png);
		add(skillIcon);
		add(skillHeal);
		add(barraVida2);
		add(barraVida);
		add(barraVidaBoss2);
		add(barraVidaBoss);
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		barraVida2.makeGraphic(Std.int(Reg.vidas / 2.5), 6, FlxColor.BLUE);
		barraVidaBoss2.makeGraphic(Std.int(Reg.vidasBoss / 10), 6, FlxColor.RED);
		if (Reg.spellHealEnCD > 0)
		{
			skillHeal.loadGraphic(AssetPaths.skillHealCD__png);
		}
		else
		{
			skillHeal.loadGraphic(AssetPaths.skillHeal__png);
		}
		if (Reg.spellUnoEnCD > 0)
		{
			skillIcon.loadGraphic(AssetPaths.skilloneCD__png);
		}
		else
		{
			skillIcon.loadGraphic(AssetPaths.skillone__png);
		}
		if (Reg.vidasBoss >= Reg.maxVidasBoss)
		{
			barraVidaBoss2.makeGraphic(62, 6, FlxColor.RED);
		}
		else if (Reg.vidasBoss <= 0)
		{
			barraVidaBoss2.makeGraphic(1, 6, FlxColor.RED);
		}
		if (Reg.vidas >= Reg.maxVidas)
		{
			barraVida2.makeGraphic(62, 6, FlxColor.BLUE);
		}
		else if (Reg.vidas <= 0)
		{
			barraVida2.makeGraphic(1, 6, FlxColor.BLUE);
		}
	}
}