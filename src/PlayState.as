package  
{
	import adobe.utils.CustomActions;
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "data/background.png")] protected var ImgBackground:Class;
		[Embed(source = "data/upper_wall.png")] protected var ImgUpperWall:Class;
		[Embed(source = "data/lower_wall.png")] protected var ImgLowerWall:Class;
		
		[Embed(source = "data/sfx_point.mp3")] protected var SndScore:Class;
		[Embed(source = "data/sfx_hit.mp3")] protected var SndHit:Class;
		[Embed(source = "data/sfx_die.mp3")] protected var SndDie:Class;
		
		public var bird:Bird;
		public var walls:FlxGroup;
		public var gaps:FlxGroup;
		public var leftBoundWall:FlxSprite;
		public var score:FlxText;
		public var background:FlxSprite;
		
		private var isAlive:Boolean;
		private var gapHeight:int;
		private var safeHeight:int;
		private var wallDistance:int;
		
		override public function create():void 
		{
			//FlxG.debug = true;
			//FlxG.visualDebug = true;
			
			background = new FlxSprite(0, 0);
			background.solid = false;
			background.loadGraphic(ImgBackground);
			
			isAlive = true;
			gapHeight = 64;
			safeHeight = 40;
			wallDistance = 106;
			
			bird = new Bird(108, 120, -140, 550);
			
			FlxG.score = 0;
			
			walls = new FlxGroup();
			var wall1:FlxGroup = createNewWalls(FlxG.width, -100);
			var wall2:FlxGroup = createNewWalls(FlxG.width + wallDistance, -100);
			var wall3:FlxGroup = createNewWalls(FlxG.width + wallDistance * 2, -100);
			walls.add(wall1);
			walls.add(wall2);
			walls.add(wall3);
			
			gaps = new FlxGroup();
			gaps.add(createGap(FlxG.width + 26));
			gaps.add(createGap(FlxG.width + wallDistance + 26));
			gaps.add(createGap(FlxG.width + wallDistance * 2 + 26));
			
			
			leftBoundWall = new FlxSprite( -1, 0);
			leftBoundWall.makeGraphic(1, FlxG.height);
			
			score = new FlxText(2, 2, 100);
			score.text = "score: " + FlxG.score.toString();
			score.color = 0xffff0000;
			
			add(leftBoundWall);
			add(gaps);
			add(background);
			add(walls);
			add(bird);	
			add(score);
			
			FlxG.mouse.hide();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (isAlive && bird.y >= FlxG.height - 10)
			{
				isAlive = false;
				FlxG.play(SndDie);
				bird.kill();
				FlxG.fade(0xff131c1b, 0.35, onGameOver);
			}
			
			for each(var _walls:FlxGroup in walls.members)
			{	
				if (FlxG.overlap(_walls, leftBoundWall))
				{
					_walls.members[0].x = FlxG.width;
					var newUpperHeight:int = getRandomUpWallHeight()
					_walls.members[0].y = newUpperHeight - 180;
					_walls.members[1].x = FlxG.width;
					_walls.members[1].y = newUpperHeight + gapHeight;
				}		
			}
			
			FlxG.overlap(bird, gaps, addScore);
			FlxG.overlap(bird, walls, onHit);
		}
		
		private function onGameOver():void 
		{
			FlxG.switchState(new GameOverState());
		}
		
		private function onHit(_bird:FlxSprite, _wall:FlxSprite):void 
		{
			FlxG.play(SndHit);
			// stop walls
			for each(var _walls:FlxGroup in walls.members)
			{
				_walls.members[0].velocity.x = 0;
				_walls.members[1].velocity.x = 0;
			}
			bird.hit();
		}
		
		private function createGap(x:int):FlxSprite 
		{
			var gap:FlxSprite = new FlxSprite(x, 0);
			gap.makeGraphic(1, 240, 0x00ffffff);
			gap.velocity.x = -100;
			return gap;
		}
		
		private function createNewWalls(originX:int, speedX:int):FlxGroup 
		{
			var newWalls:FlxGroup = new FlxGroup();
			var upWallHeight:int = getRandomUpWallHeight();
			var downWallHeight:int = FlxG.height - upWallHeight - gapHeight;
			var newUpperWall:FlxSprite = new FlxSprite(originX, upWallHeight - 180);
			newUpperWall.loadGraphic(ImgUpperWall);
			var newLowerWall:FlxSprite = new FlxSprite(originX, upWallHeight + gapHeight);
			newLowerWall.loadGraphic(ImgLowerWall);
			newUpperWall.velocity.x = speedX;
			newLowerWall.velocity.x = speedX;
			
			newWalls.add(newUpperWall);
			newWalls.add(newLowerWall);
			
			return newWalls;
		}
		
		private function getRandomUpWallHeight():int 
		{
			var upBound:int = safeHeight;
			var downBound:int = FlxG.height - safeHeight - gapHeight;
			return int(FlxG.random() * (downBound - upBound) + upBound);
		}
		
		private function addScore(_bird:FlxSprite, _gap:FlxSprite):void 
		{
			resetGap(_gap);
			FlxG.score += 1;
			FlxG.play(SndScore);
			score.text = "score: " + FlxG.score.toString();
		}
		
		private function resetGap(gap:FlxSprite):void 
		{
			gap.x = FlxG.width + 122;
		}
	}

}