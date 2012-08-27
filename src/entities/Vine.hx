package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import flash.geom.Rectangle;

class Vine extends Entity
{
	public var img:Image;
	public function new(x:Float, y:Float)
	{
		super(x,y);
		type = "Vine";
		img = new Image("gfx/tilemap.png", new Rectangle(32, 32, 32, 32));
		graphic = img;
		setHitbox(img.width, img.height);
	}
	public override function update()
	{
		var ent:Entity = collide("Player", x, y);
		if(ent != null && ( Input.check(Key.UP) || Input.check(Key.W)))
		{
			var player = cast(ent, Player);
			player.vy = -5;
			player.climbing = true;
			player.spritemap.play("climb");
		}
	}
}