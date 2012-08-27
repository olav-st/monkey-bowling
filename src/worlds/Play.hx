package worlds;

import com.haxepunk.World;
import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.Player;
import entities.PlayerGorilla;
import entities.PlayerHuman;
import entities.PlayerFat;
import entities.Sign;
import collectibles.Collectible;
import collectibles.Banana;
import collectibles.Burger;
import Level;
import com.haxepunk.tmx.TmxEntity;
import entities.Crate;
import entities.Gate;
import entities.Notification;
import com.haxepunk.Sfx;

class Play extends World 
{
	public var player:Player;
	public var tmx:TmxEntity;
	public var level:Level;
	public var levelNumber:Int = 1;
	public var background:Image;
	public var bananasCollected:Int = 0;
	public var burgersCollected:Int = 0;
	public var notif:Notification;
	public var evolutionLevel:Int = 1;
	public function new()
	{
		super();
	}
	public override function begin()
	{
		background = new Image("gfx/background.png");
		background.scrollX = 0;
		background.scrollY = 0;
		addGraphic(background);
		player = new Player(200, 80);
		level = new Level(levelNumber);
		buildLevel(level);
		add(player);
		
	}
	public override function update()
	{
		super.update();
		if(Input.check(Key.R) )
		{
			reloadLevel();
		}
		if(Input.check(Key.DIGIT_1))
		{
			remove(player);
			var newPlayer = new Player(player.x, player.y);
			newPlayer.hasKey = player.hasKey;
			player = newPlayer;
			add(player);
		}
		if(Input.check(Key.DIGIT_2) && levelNumber > 5 && !Std.is(player, PlayerGorilla))
		{
			remove(player);
			var newPlayer = new PlayerGorilla(player.x, player.y - 5);
			newPlayer.hasKey = player.hasKey;
			player = newPlayer;
			add(player);
		}
		if(Input.check(Key.DIGIT_3) && levelNumber > 7 && !Std.is(player, PlayerHuman))
		{
			remove(player);
			var newPlayer = new PlayerHuman(player.x, player.y - 18);
			newPlayer.hasKey = player.hasKey;
			player = newPlayer;
			add(player);
		}
		if(Input.check(Key.DIGIT_4) && levelNumber > 7 && !Std.is(player, PlayerFat))
		{
			remove(player);
			var newPlayer = new PlayerFat(player.x, player.y - 30);
			newPlayer.hasKey = player.hasKey;
			player = newPlayer;
			add(player);
		}
		//Center the camera on the player
		if(player.x - HXP.width / 2 < 0)
		{
			HXP.setCamera(0,player.y + player.height / 2 - HXP.height / 2);
		}else if ( player.x + HXP.width / 2 > tmx.width) 
		{
			HXP.setCamera(tmx.width -  HXP.width,player.y + player.height / 2 - HXP.height / 2);
		}else
		{
			HXP.setCamera(player.x + player.width / 2 - HXP.width / 2, player.y + player.height / 2 - HXP.height / 2);
		}
		if(!level.useY)
		{
			if(level.finishLeft && player.x < level.finish)
			{
				levelFinished();
			}else if(!level.finishLeft && player.x > level.finish)
			{
				levelFinished();
			}
		}else
		{
			if(!level.finishBelow && player.y < level.finish)
			{
				levelFinished();
			}else if(level.finishBelow && player.y > level.finish)
			{
				levelFinished();
			}
		}
		if(player.y > tmx.height + player.height)
		{
			reloadLevel();
		}
		//Check for collectibles
		collideCollectibles();
		collideGates();
		collideBowlingPins();
	}
	public function collideBowlingPins()
	{
		var offsetX:Int;
		if(player.vx > 0)
		{
			offsetX = 2;
		}else if(player.vx < 0)
		{
			offsetX = -2;
		}else
		{
			offsetX = 0;
		}
		var ent:Entity = player.collide("BowlingPin", player.x +offsetX, player.y);
		if(ent != null)
		{
			if(!Std.is(player, PlayerFat))
			{
				player.x = ent.x - player.width;
				player.vx = 0;
			}
		}
	}
	public function collideGates()
	{
		var offsetX:Int;
		if(player.vx > 0)
		{
			offsetX = 2;
		}else if(player.vx < 0)
		{
			offsetX = -2;
		}else
		{
			offsetX = 0;
		}
		var ent:Entity = player.collide("Gate", player.x +offsetX, player.y);
		if(ent != null)
		{
			if(player.hasKey)
			{
				var gate:Gate = cast(ent, Gate);
				remove(gate);
				new Sfx("sfx/open.wav").play();
			}
		}
		var offsetY:Int;
		if(player.vy > 0)
		{
			offsetY = 2;
		}else if(player.vy < 0)
		{
			offsetY = -2;
		}else
		{
			offsetY = 0;
		}
		ent = player.collide("Gate", player.x, player.y + offsetY);
		if(ent != null)
		{
			if(player.hasKey)
			{
				var gate:Gate = cast(ent, Gate);
				remove(gate);
				new Sfx("sfx/open.wav").play();
			}
		}
	}
	public function collideCollectibles()
	{
		var ent:Entity = player.collide("Collectible", player.x, player.y);
		if(ent != null)
		{
			var collectible:Collectible = cast(ent, Collectible);
			collectible.collected(player);
			remove(collectible);
			if(Std.is(collectible, Banana))
			{
				level.nannersCollected++;
			}else if(Std.is(collectible, Burger))
			{
				level.burgersCollected++;
			}
		}
	}
	public function buildLevel(level:Level)
	{
		tmx = level.loadTmx();
		tmx.type = "TMX";
		add(tmx);
		for(col in level.collectibles)
		{
			add(col);
		}
		for(ent in level.entities)
		{
			add(ent);
		}
		for(gate in level.gates)
		{
			add(gate);
		}
		player.x = level.playerStartPos.x;
		player.y = level.playerStartPos.y;
	}
	public function reloadLevel()
	{
		remove(player);
		remove(tmx);
		for(col in level.collectibles)
		{
			remove(col);
		}
		for(ent in level.entities)
		{
			remove(ent);
		}
		for(gate in level.gates)
		{
			remove(gate);
		}
		if(levelNumber > 5 && levelNumber < 8)
		{
			player = new PlayerGorilla(0, 0);
		}else if(levelNumber > 7 && levelNumber < 9)
		{
			player = new PlayerHuman(0,0);
		}else if(levelNumber > 8)
		{
			player = new PlayerFat(0,0);
		}
		else
		{
			player = new Player(0, 0);
		}
		level = new Level(levelNumber);
		buildLevel(level);
		add(player);
		if(levelNumber == 6)
		{
			if(evolutionLevel < 2)
			{
				evolutionLevel++;
				showNotification(1);
			}
		}
		if(levelNumber == 8)
		{
			if(evolutionLevel < 3)
			{
				evolutionLevel++;
				showNotification(2);
			}
		}
		if(levelNumber == 9)
		{
			if(evolutionLevel < 4)
			{
				evolutionLevel++;
				showNotification(3);
			}
		}
		
	}
	public function levelFinished()
	{
		if(levelNumber < 10)
		{
			levelNumber ++;
			bananasCollected += level.nannersCollected;
			burgersCollected += level.burgersCollected;
			reloadLevel();
		}else
		{
			haxe.Timer.delay(timerFinished, 1400);
			remove(player);
		}
	}
	public function timerFinished()
	{
		HXP.world = new End(bananasCollected, burgersCollected);
	}
	public function showNotification(n:Int)
	{
		notif = new Notification(n);
		notif.layer = layerNearest;
		add(notif);
		haxe.Timer.delay(hideNotification, 2000);
	}
	public function hideNotification()
	{
		remove(notif);
	}
	
}