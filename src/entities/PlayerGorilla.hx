package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.TiledSpritemap;

class PlayerGorilla extends Player
{

	public function new(x:Float, y:Float, flip:Bool = false)
	{
		super(x,y);
		spritemap = new TiledSpritemap("gfx/gorilla.png", 40, 35, 40, 35);
		spritemap.add("idle", [0]);
		spritemap.add("run", [1, 2, 3], 8);
		graphic = spritemap;
		spritemap.flipped = flip;
		setHitbox(40,35);
	}
}