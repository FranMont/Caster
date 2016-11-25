package;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;

class Reg
{
	//Direcciones
	inline static public var UP:Int = 0;
	inline static public var DOWN:Int = 1;
	inline static public var LEFT:Int = 2;
	inline static public var RIGHT:Int = 3;
	inline static public var UPRIGHT:Int = 4;
	inline static public var UPLEFT:Int = 5;
	inline static public var DOWNLEFT:Int = 6;
	inline static public var DOWNRIGHT:Int = 7;
	//Spells
	inline static public var SPELLNONE:Int = 0;
	inline static public var SPELLDISPARO:Int = 1;
	inline static public var SPELLHEAL:Int = 2;
	
	inline static public var spellHealCastTime:Float = 2;
	inline static public var spellHealCoolDown:Float = 10;
	inline static public var spellOneCastTime:Float = 1.5;
	inline static public var spellOneCoolDown:Float = 10;
	inline static public var spellHealCura:Int = 5;
	inline static public var curaBoss:Int = 8;
	//Constantes
	inline static public var velocityBossDisparo:Int = 175;
	inline static public var velocityDisparo:Int = 300;
	inline static public var velocitySpell:Int = 150;
	inline static public var playerSpeed:Int = 80;
	inline static public var maxVidas:Int = 155;
	inline static public var maxCantDisparos = 3;
	inline static public var maxVidasBoss:Int = 620;	
	inline static public var danioDisparoBoss:Int = 6;
	
	static public var cantidadPoison:Int = 0;
	
	//Variables
	static public var _healBossAnim:HealAnimBoss;
	static public var healingAnim:HealAnim;
	static public var gui:Interfaz;
	static public var spellHealEnCD:Float = 0;
	static public var spellCasted:Int = SPELLNONE;
	static public var boss:Boss;
	static public var vidasBoss:Int;
	static public var spellUno:SpellOne;
	static public var spellUnoEnCD:Float = 0;
	static public var disparoArray:Array<Disparo>;
	static public var poisonArray:Array<Poison>;
	static public var cantDisparos = 0;
	static public var player:Player;
	static public var tilemap:FlxTilemap;
	static public var tilempaWidth:Int;
	static public var vidas:Int = maxVidas;
	
	static public var disparosBossArray:Array<DisparoBoss>;
}