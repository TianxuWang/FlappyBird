package  
{
	//import com.levelxgames.flixelx.data.FlxSaveWrapper;
 
    public class GameLocalData
    {
        private const SAVE_NAME:String = "flappysquare";
        private const DEFAULT_HIGH_SCORE:int = 0;
 
        private var save:FlxSaveWrapper;
 
        public function GameLocalData()
        {
            save = new FlxSaveWrapper();
            save.init(SAVE_NAME, defaults);
        }
 
        public function get highScore():int
        {
            return save.data.highScore;
        }
 
        public function set highScore(newScore:int):void
        {
            save.data.highScore = newScore;
            save.updateLocalCopy(); // save immediately in case of system crash
        }
 
        public function defaults():void
        {
            trace("SaveGame - defaults()");
            highScore = DEFAULT_HIGH_SCORE;
        }
    }
}