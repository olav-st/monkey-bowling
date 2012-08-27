package collectibles;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import entities.Player;

class Banana extends Collectible
{
	public function new(x:Float, y:Float)
	{
		super(x,y);
		graphic = new Image("gfx/banana.png");
		setHitbox(32, 32);
	}
	public override function collected(player:Player)
	{
		super.collected(player);
		if(player.inAir && player.vy != 0 && player.collide("TMX", player.x, player.y + 1) == null)
		{
			player.vy -= 10;
		}
	}
}
