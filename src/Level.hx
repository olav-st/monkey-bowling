import com.haxepunk.Entity;
import com.haxepunk.tmx.TmxMap;
import com.haxepunk.tmx.TmxEntity;
import flash.display.BitmapData;
import flash.geom.Point;
import com.haxepunk.graphics.Image;
import collectibles.Banana;
import com.haxepunk.HXP;
import entities.Vine;
import entities.BowlingPin;
import entities.Crate;
import entities.Sign;
import collectibles.Key;
import entities.Gate;
import collectibles.Burger;
import flash.geom.Point;

class Level
{
	public var collectibles:Array<Entity>;
	public var entities:Array<Entity>;
	public var gates:Array<Gate>;
	public var levelNumber:Int = 0;
	public var playerStartPos:Point;
	public var finish:Float = 0.0;
	public var useY:Bool = false;
	public var finishLeft:Bool = false;
	public var finishBelow:Bool = false;
	public var nannersCollected:Int = 0;
	public var burgersCollected:Int = 0;
	public function new(lvlNumber:Int)
	{
		levelNumber = lvlNumber;
		collectibles = new Array<Entity>();
		entities = new Array<Entity>();
		gates = new Array<Gate>();
		playerStartPos = new Point();
		nannersCollected = 0;
		burgersCollected = 0;
		var str:String = nme.Assets.getText("level/level" + levelNumber + ".xml");
		var xml = Xml.parse(str);
		var root = new haxe.xml.Fast(xml.firstElement());
		playerStartPos = new Point(Std.parseInt(root.node.spawnX.innerData) * 32, Std.parseInt(root.node.spawnY.innerData) * 32);
		finish = Std.parseInt(root.node.finish.innerData) * 32;
		useY = Std.parseInt(root.node.useY.innerData) == 1;
		finishLeft = Std.parseInt(root.node.finishLeft.innerData) == 1;
		finishBelow = Std.parseInt(root.node.finishBelow.innerData) == 1;
		//Load signs
		var signNode = root.node.signs;
		for(sign in signNode.nodes.sign)
		{
			entities.push(new Sign(Std.parseFloat(sign.node.x.innerData) * 32, Std.parseFloat(sign.node.y.innerData) * 32, sign.node.message.innerData));
		}
	}
	public function loadTmx()
	{
		var img = new Image("gfx/tilemap.png");
		//var bmd:BitmapData = new BitmapData(img.width, img.height, true);
		var bmd:BitmapData = nme.Assets.getBitmapData("gfx/tilemap.png");
		//img.render(bmd, new Point(0,0), new Point(0,0));
		var data:String = nme.Assets.getText("level/level" + levelNumber + ".tmx");
		var map:TmxMap = new TmxMap(data);
		var order:Array<String> = ["background", "collide"];
		var tmx:TmxEntity = new TmxEntity(map, bmd, checkTiles, order);
		tmx.setCollidable(setCollidableTiles, "collide"); // Set collidable function and layer name
		return tmx;
	}
	public function checkTiles(tile:Int, col:Int, row:Int):Bool
	{
	  if (tile < 11 && tile > 0) return true;
	  if(tile == 11) //Banana
	  {
	  	collectibles.push(new Banana(row * 32, col * 32 ));
	  }
	  if(tile == 12)
	  {
	  	entities.push(new Vine(row * 32, col * 32));
	  }
	  if(tile == 13)
	  {
	  	entities.push(new BowlingPin(row * 32, col * 32 - 16));
	  }
	  if(tile == 14)
	  {
	  	collectibles.push(new Key(row * 32, col * 32));
	  }
	  if(tile == 15)
	  {
	  	collectibles.push(new Crate(row * 32 , col * 32));
	  }
	  if(tile == 16)
	  {
	  	gates.push(new Gate(row * 32 , col * 32));
	  }
	  if(tile == 17)
	  {
	  	collectibles.push(new Burger(row *32, col *32));
	  }
	  return false;
	}
	public function setCollidableTiles(tile:Int, col:Int, row:Int):Bool
	{
		if (tile < 11 && tile > 0) return true;
		return false;
	}
}
