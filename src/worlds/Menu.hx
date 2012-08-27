package worlds;

import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Menu extends World 
{
	public function new()
	{
		super();
	}
	public override function begin()
	{
		addGraphic(new Image("gfx/menu.png"));
	}
	public override function update()
	{
		if(Input.check(Key.SPACE) || Input.check(Key.ENTER))
		{
			HXP.world = new Play();
		}

	}
}