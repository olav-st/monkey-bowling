package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.tweens.misc.AngleTween;
import com.haxepunk.graphics.PreRotation;
import com.haxepunk.Sfx;

class PlayerFat extends Player
{
	public var img:Image;
	public var prerot:PreRotation;
	public var tweenRot:AngleTween;
	public function new(x:Float, y:Float)
	{
		super(x,y);
		prerot = new PreRotation("gfx/player_sprite_3.png", 12);
		prerot.originX = Std.int(prerot.width / 2);
		prerot.originY = Std.int(prerot.height / 2);
		graphic = prerot;
		setHitbox(48,46, -10, -10);
		tweenRot = new AngleTween(null, Looping);
		tweenRot.tween(1, 360, 10000);
		tweenRot.start();
		maxVx = 30.0;
		friction = 0.80;
	}
	public override function update()
	{
		super.update();
		if(vx != 0)
		{
			if(vx < 0)
			{
				prerot.angle += tweenRot.angle * 5;
			}else
			{
				prerot.angle -= tweenRot.angle * 5;
			}
		}
		var ent:Entity = collide("BowlingPin", x +1, y);
		if(ent != null)
		{
			new Sfx("sfx/hit.wav").play();
			cast(ent, BowlingPin).vy -= 12.0;
		}
		ent = collide("BowlingPin", x -1, y);
		if(ent != null)
		{
			new Sfx("sfx/hit.wav").play();
			cast(ent, BowlingPin).vy -= 12.0;
		}
	}
	public override function moveLeft()
	{
		super.moveLeft();
		prerot.flipped = true;
	}
	public override function moveRight()
	{
		super.moveRight();
		prerot.flipped = false;
	}
}