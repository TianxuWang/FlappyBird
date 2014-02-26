package  
{
	import org.flixel.*;
	
	public class GameOverState extends FlxState
	{
		
		public var finalScore:FlxText;
		public var gameOver: FlxText;
		public var restartButton:FlxButton;
		public var localData:GameLocalData;
		public var highScore:FlxText;
		
		override public function create():void 
		{
			localData = new GameLocalData();
			if (FlxG.score > localData.highScore)
			{
				localData.highScore = FlxG.score;
			}
			
			highScore = new FlxText(100, 105, 100);
			highScore.text = "Best Record: " + localData.highScore;
			highScore.alignment = "center";
			
			finalScore = new FlxText(100, 90, 100);
			finalScore.text = "Your Score: " + FlxG.score;
			finalScore.alignment = "center";
			
			gameOver = new FlxText(60, 60, 200, "GAME OVER");
			gameOver.alignment = "center";
			gameOver.size = 18;
			gameOver.shadow = 0xff939393;
			
			restartButton = new FlxButton(120, 150, "Restart", onRestart);
			
			add(finalScore);
			add(gameOver);
			add(restartButton);
			add(highScore);
			
			FlxG.mouse.show();
			
		}
		
		private function onRestart():void 
		{
			FlxG.switchState(new PlayState());
		}
		
	}

}