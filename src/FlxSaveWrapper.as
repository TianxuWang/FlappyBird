package  
{
	import org.flixel.*;

	public class FlxSaveWrapper
	{
		private var saveDataObject:FlxSave;

		public function FlxSaveWrapper()
		{
			saveDataObject = new FlxSave();
		}

		/** 
		 * Initialises the save data so it can be used.
		 * 
		 * @param uniqueSaveName the name of your application or save file. 
		 * I recommend using reverse domain name notation (ie com.levelxgames.gamename).
		 * 
		 * @param onCreatedNew this function is called in the event that the save file was not found.
		 * This function is where you set your default values for your save data.
		 * 
		 * @param onLoaded if provided, this function is called in the event that the save file
		 * was found and correctly loaded.
		 * **/
		public function init(uniqueSaveName:String, onCreatedNew:Function, onLoaded:Function = null):void
		{
			var exists:Boolean = saveDataObject.bind(uniqueSaveName);
			if (exists && data)
			{
				trace("FlxSaveWrapper - Existing Loaded");
				if (onLoaded != null)
					onLoaded();
			}
			else
			{
				trace("FlxSaveWrapper - New Created");
				saveDataObject.data.mySave = new Object();
				if (onCreatedNew != null)
					onCreatedNew();
			}
		}

		/** 
		 * Flushes the save data to hard disk or local storage.
		 * It's a good idea to do this whenever you alter your save data so that the local data is kept current.
		 * That way the player's current progress isn't lost in the event of a system crash. 
		 * @param onSaveComplete If provided, this function is called after the data can be successfully updated
		 * **/
		public function updateLocalCopy(onSaveComplete:Function = null):void
		{
			trace("FlxSaveWrapper - Saved");
			saveDataObject.flush(0, onSaveComplete);
		}

		public function get data():Object
		{
			return saveDataObject.data.mySave;
		}
	}
}