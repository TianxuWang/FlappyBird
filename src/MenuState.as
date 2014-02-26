package  
{
	import org.flixel.*
	
	public class MenuState extends FlxState
	{
		public var title:FlxText;
		public var startButton:FlxButton;
		
		override public function create():void 
		{
			title = new FlxText(60, 80, 200, "Flappy Bird");
			title.alignment = "center"
			title.size = 18;
			title.shadow = 0xff939393;
			
			startButton = new FlxButton(120, 140, "Play", onFade);
			
			add(startButton);
			add(title);
			
			FlxG.mouse.show();
		}
		
		private function onFade():void 
		{
			FlxG.flash(0xffd8eba2, 0.5);
			FlxG.fade(0xff131c1b, 1, onPlay);
		}
		
		private function onPlay():void 
		{
			FlxG.switchState(new PlayState());
		}
	}

}