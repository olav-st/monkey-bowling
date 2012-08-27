package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import flash.geom.Rectangle;

class BowlingPin extends PhysicsEntity
{
	public var img:Image;
	public function new(x:Float, y:Float)
	{
		super(x,y);
		type = "BowlingPin";
		img = new Image("gfx/bowling.png");
		graphic = img;
		setHitbox(img.width, img.height);
	}
}