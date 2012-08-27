package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.TiledSpritemap;

class PlayerHuman extends Player
{

	public function new(x:Float, y:Float, flip:Bool = false)
	{
		super(x,y);
		spritemap = new TiledSpritemap("gfx/human.png", 34, 48, 34, 48);
		spritemap.add("idle", [0]);
		spritemap.add("run", [1, 2, 3], 8);
		graphic = spritemap;
		spritemap.flipped = flip;
		setHitbox(34,48);
	}
}