package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import flash.geom.Rectangle;

class Gate extends PhysicsEntity
{
	public var img:Image;
	public function new(x:Float, y:Float)
	{
		super(x,y);
		type = "Gate";
		img = new Image("gfx/tilemap.png", new Rectangle(160,32,32,32));
		graphic = img;
		setHitbox(img.width, img.height);
		gravity = 0.0;
	}
}