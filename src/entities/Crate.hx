package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import flash.geom.Rectangle;

class Crate extends PhysicsEntity
{
	public var image:Image;
	public function new(x:Float, y:Float)
	{
		super(x,y);
		type = "Crate";
		image = new Image("gfx/tilemap.png", new Rectangle(128, 32, 32, 32));
		graphic = image;
		setHitbox(image.width -4, image.height -4, -2, -2);
	}
}