package  
{
	import org.flixel.*;
	
	public class Bird extends FlxSprite 
	{
		[Embed(source = "data/bird.png")] protected var ImgBird:Class;
		[Embed(source = "data/sfx_wing.mp3")] protected var SndJump:Class;
		
		protected var _jumpPower:int;
		protected var _gravity:int;
		protected var isJumped:Boolean;
		
		public function Bird(X:int, Y:int, JumpPower:int, Gravity:int) 
		{
			super(X, Y);
			loadGraphic(ImgBird, true, false, 17, 12);
			
			width = 15;
			height = 10;
			offset.x = 1;
			offset.y = 1;
			antialiasing = true;
			
			isJumped = false;
			_jumpPower = JumpPower;
			velocity.y = _jumpPower;
			_gravity = Gravity;
			acceleration.y = _gravity;
			
			addAnimation("idle", [1]);
			addAnimation("fly", [0, 1, 2, 1], 6);
		}
		
		override public function update():void 
		{	
			if (alive) 
			{
				play("fly");
				
				switch (true) 
				{
					case velocity.y < 0:
						angle = -20;
						break;
					case velocity.y > 0 && velocity.y <= 40:
						angle = 20;
						break;
					case velocity.y > 40:
						angle = 30;
						break;
					default:
						angle = 0;
				}
				
				if (FlxG.keys.UP && !isJumped)
				{
					velocity.y = _jumpPower;
					FlxG.play(SndJump);
					isJumped = true;
				}
				if (FlxG.keys.justReleased("UP"))
				{
					isJumped = false;
				}
			}
			else {
				play("idle");
			}
		}
		
		public function hit():void 
		{
			alive = false;
			solid = false;
			acceleration.y = 0;
			velocity.y = 0;
			FlxG.camera.shake(0.01, 0.35, onShakeComplete);		
		}
		
		private function onShakeComplete():void 
		{
			acceleration.y = _gravity;
		}
	}

}