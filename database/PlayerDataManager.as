package database
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class PlayerDataManager extends MovieClip
	{
		private static var playerDataManager:PlayerDataManager = new PlayerDataManager();
		
		public function PlayerDataManager()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public static function getInstance():PlayerDataManager
		{
			return playerDataManager;
		}
		
		//ENUM ARRAY ###################################################################################################
		public static const ID_PLAYER_NAME:int = 0;
		public static const ID_CURRENT_LEVEL:int = 1;
		public static const ID_LEVEL_PROGRESS:int = 2;
		//ENUM ARRAY ###################################################################################################
		//AREA ARRAY ###################################################################################################
		private var arrayOfPlayer = [
			["Devara", 1, 3]
		];
		//AREA ARRAY ###################################################################################################
		//METHOD ACCESSOR ##############################################################################################
		public function getPlayerName(_playerId:int = 0):String{
			return arrayOfPlayer[_playerId][0];
		}
		public function setPlayerCurrentLevel(_playerId:int = 0, _currentLevel:int = 1):void{
			arrayOfPlayer[_playerId][1] = _currentLevel;
		}
		public function getPlayerCurrentLevel(_playerId:int = 0):int{
			return arrayOfPlayer[_playerId][1];
		}
		public function addPlayerCurrentLevel(_playerId:int = 0, _currentLevel:int = 1):void{
			arrayOfPlayer[_playerId][1] += _currentLevel;
		}
		public function setPlayerLevelProgress(_playerId:int = 0, _levelProgress:int = 1):void{
			arrayOfPlayer[_playerId][2] = _levelProgress;
		}
		public function getPlayerLevelProgress(_playerId:int = 0):int{
			return arrayOfPlayer[_playerId][2];
		}
		public function addPlayerLevelProgress(_playerId:int = 0, _levelProgress:int = 1):void{
			arrayOfPlayer[_playerId][2] += _levelProgress;
		}
		//METHOD ACCESSOR ##############################################################################################
	}

}