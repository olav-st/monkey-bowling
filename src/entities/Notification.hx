package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import flash.geom.Rectangle;

class Notification extends Entity
{
	public var img:Image;
	public function new(evolutionNumber:Int)
	{
		type = "Notification";
		if(evolutionNumber == 1)
		{
			img = new Image("gfx/notify_gorilla.png");
		}else if(evolutionNumber == 2)
		{
			img = new Image("gfx/notify_human.png");
		}else{
			img = new Image("gfx/notify_fat.png");
		}
		graphic = img;
		img.scrollX = 0;
		img.scrollY = 0;
		super(170, 99);
	}
}