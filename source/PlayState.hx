package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
/*
 * Creditos del Arte:
	* http://opengameart.org/content/dawnlike-16x16-universal-rogue-like-tileset-v181
 * */
class PlayState extends FlxState
{
	private var _resetStage:Float;
	private var _xPlyaer:Float;
	private var _yPlayer:Float;
	private var _xBoss:Float;
	private var _yBoss:Float;
	override public function create():Void
	{
		super.create();
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.levelCircularTam__oel);
		Reg.tilemap = loader.loadTilemap(AssetPaths.tilesv1__png);
		FlxG.worldBounds.set(0, 0, Reg.tilemap.width, Reg.tilemap.height);
		for (s in 0...15)
		{
			Reg.tilemap.setTileProperties(s, FlxObject.NONE);
		}
		for (s in 16...28)
		{
			Reg.tilemap.setTileProperties(s, FlxObject.ANY);
		}
		for (s in 29...33)
		{
			Reg.tilemap.setTileProperties(s, FlxObject.NONE);
		}
		add(Reg.tilemap);
		FlxG.camera.setScrollBounds(0, Reg.tilemap.width, 0, Reg.tilemap.height);
		Reg.poisonArray = new Array<Poison>();
		for (s in 1...15)
		{
			Reg.poisonArray.push(new Poison(0, 0));
		}
		_resetStage = 0;
		FlxG.sound.playMusic("assets/music/pararabapapa.ogg", 0.75, true); //Musica
		loader.loadEntities(placeEntities, "entities");
		Reg.gui = new Interfaz();
		add(Reg.gui);
		FlxG.camera.follow(Reg.player);		
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (Reg.vidas <= 0 || Reg.vidasBoss <= 0)
		{
			_resetStage+= elapsed;
			if (_resetStage >= 5)
			{
				Reg.player.kill();
				Reg.boss.kill();
				Reg.player = new Player(_xPlyaer, _yPlayer);
				Reg.boss = new Boss(_xBoss, _yBoss);
				FlxG.resetState();
			}
		}
		FlxG.collide(Reg.tilemap, Reg.player);
		if (FlxG.keys.justReleased.O){Reg.spellUnoEnCD = 0;}
		if (FlxG.keys.justReleased.J){Reg.vidasBoss = Std.int(Reg.maxVidasBoss / 5) -1; }	
		if (FlxG.keys.justReleased.T){Reg.vidas = 10; }
		if (Reg.spellUnoEnCD > 0)
		{
			Reg.spellUnoEnCD -= elapsed;
			if (Reg.spellUnoEnCD <= 0)
			{
				Reg.spellUnoEnCD = 0;
			}
		}
		if (Reg.spellHealEnCD > 0)
		{
			Reg.spellHealEnCD -= elapsed;
			if (Reg.spellHealEnCD <= 0)
			{
				Reg.spellHealEnCD = 0;
			}
		}
	}
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "laserR")
		{
			var laser = new Laser(x, y, true);
		}
		if (entityName == "laserH")
		{
			var laser = new Laser(x, y, false);
		}
		if (entityName == "boss")
		{
			_xBoss = x; _yBoss = y;
			Reg.boss = new Boss(x + 4, y + 4);
		}
		if (entityName == "player")
		{
			_xPlyaer = x; _yPlayer = y;
			Reg.player = new Player(x, y);
		}
	}
}
