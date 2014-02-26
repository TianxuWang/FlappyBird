package 
{
	/**
	 * ...
	 * @author Tianxu Wang
	 */
	import org.flixel.*;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	 
	public class Main extends FlxGame 
	{
		public function Main() 
		{
			super(320, 240, MenuState, 2);
		}
	}
	
}