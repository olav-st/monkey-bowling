package collectibles;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import entities.Player;
import flash.geom.Rectangle;

class Key extends Collectible
{
	public function new(x:Float, y:Float)
	{
		super(x,y);
		graphic = new Image("gfx/tilemap.png", new Rectangle(96, 32, 32, 32));
		setHitbox(32, 32);
	}
	public override function collected(player:Player)
	{
		super.collected(player);
		player.hasKey = true;
		
	}
}
