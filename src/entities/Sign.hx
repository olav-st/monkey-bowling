package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Text;

class Sign extends Entity
{
	public var signImg:Image;
	public var bubbleImg:Image;
	public var text:Text;
	public var glist:Graphiclist;
	public var message:String;
	public function new(x:Float, y:Float, msg:String)
	{
		super(x,y);
		type = "Sign";
		glist = new Graphiclist();
		signImg = new Image("gfx/sign.png");
		bubbleImg = new Image("gfx/bubble.png");
		text = new Text(msg, -36, -163, 200, 95, {wordWrap: true});
		text.color = 0x000000;
		bubbleImg.y = -190;
		bubbleImg.x = -50;
		glist.add(signImg);
		graphic = glist;
		setHitbox(signImg.width, signImg.height);
		this.message = msg;
	}
	public override function update()
	{
		if(collide("Player", x, y) != null && Input.check(Key.SPACE))
		{
			if(glist.count < 4)
			{
				glist.add(bubbleImg);
				glist.add(text);
			}
			
		}else
		{
			glist.remove(bubbleImg);
			glist.remove(text);
		}
	}
}