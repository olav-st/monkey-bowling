package collectibles;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import entities.Player;
import com.haxepunk.Sfx;

class Collectible extends Entity
{
	public var sfx:Sfx;
	public function new(x:Float, y:Float)
	{
		super(x,y);
		type ="Collectible";
		sfx = new Sfx("sfx/collectible.wav");
	}
	public function collected(player:Player)
	{
		sfx.play();
	}
}
