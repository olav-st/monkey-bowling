package worlds;

import com.haxepunk.World;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

class End extends World 
{
	public var strikeImg:Image;
	public var spareImg:Image;
	public function new(bananasCollected:Int, burgersCollected:Int)
	{
		super();
		strikeImg = new Image("gfx/strike.png");
		spareImg = new Image("gfx/spare.png");
		if(bananasCollected < 32 || burgersCollected < 6)
		{
			addGraphic(spareImg);
			addGraphic(new Text(bananasCollected + "/32 Bananas", 295, 300, 0, 0, {size: 18, color: 0xFFFFFF} ));
			addGraphic(new Text(burgersCollected + "/6 Burgers", 295, 350, 0, 0, {size: 18, color: 0xFFFFFF} ));
		}else
		{
			addGraphic(strikeImg);
		}
	}
}