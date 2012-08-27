package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.TiledSpritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.PhysicsEntity;


class Player extends PhysicsEntity
{
	public var spritemap:TiledSpritemap;
	public var image:Image;
	public var speed:Float = 3.0;
	public var jumpSpeed:Float = 20.0;
	public var climbing:Bool = false;
	public var hasKey:Bool = false;
	public function new(x:Float, y:Float, flip:Bool = false)
	{
		super(x,y);
		type = "Player";
		spritemap = new TiledSpritemap("gfx/monkey.png", 32, 32, 32, 32);
		spritemap.add("idle", [0]);
		spritemap.add("run", [1, 2, 3], 8);
		spritemap.add("climb", [4,5], 6);
		spritemap.add("attack", [2]);
		spritemap.play("idle");
		graphic = spritemap;
		spritemap.flipped = flip;
		setHitbox(30,30, -1, -1);
	}
	public override function update()
	{
		var ent:Entity = collide("Crate", x +1, y);
		if(ent != null)
		{
			cast(ent, Crate).vx += 8.0;
		}
		ent = collide("Crate", x -1, y);
		if(ent != null)
		{
			cast(ent, Crate).vx += -8.0;
		}
		if(vx != 0)
		{
			spritemap.play("run");
			climbing = false;
		}else if(!climbing)
		{
			spritemap.play("idle");
		}
		handleInput();
		super.update();
		
	}
	public function handleInput()
	{
		if( (Input.check(Key.UP) || Input.check(Key.W)) && !inAir && collideBelow)
		{
			this.jump();
		}
		if( (Input.check(Key.LEFT) || Input.check(Key.A)) && !collideLeft)
		{
			this.moveLeft();
		}
		if( (Input.check(Key.RIGHT) || Input.check(Key.D)) && !collideRight)
		{
			this.moveRight();
		}
		if(Input.check(Key.SPACE))
		{
			spritemap.play("climb");
		}
	}
	public function jump()
	{
		vy -= jumpSpeed;
		inAir = true;
	}
	public function moveLeft()
	{
		vx -= speed;
		if(collideRight)
		{
			collideRight = false;
		}
		spritemap.flipped = true;
	}
	public function moveRight()
	{
		vx += speed;
		if(collideLeft)
		{
			collideLeft = false;
		}
		spritemap.flipped = false;
	}

}