package menu
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import database.PlayerDataManager;
	
	public class LevelMenu extends MovieClip
	{
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
		public static const EVENT_ON_OPEN_MAIN_MENU:String = "EVENT_ON_OPEN_MAIN_MENU";
		public static const EVENT_ON_OPEN_CORE:String = "EVENT_ON_OPEN_CORE";
		public function LevelMenu() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			activateAllButtons();
			initLevelSelect();
		}
		
		private function initLevelSelect():void{
			trace("Init level select");
			for (var i:int = 1; i <= PlayerDataManager.getInstance().getPlayerLevelProgress(0); i++) {
				attachLevelSelect(430, 220 + (i - 1) * 160, i);
			}
		}
		
		//BUTTON FUNCTIONS ############################################################################################
		private function activateAllButtons():void{
			//btn_Play.addEventListener(MouseEvent.CLICK, onClickStartButton);
		}
		//BUTTON FUNCTIONS ############################################################################################
		//COMPONENT VARIABLE ##########################################################################################
		private var arrayOfLevelSelect:Array = new Array();
		
		//COMPONENT VARIABLE ##########################################################################################
		//ATTACHER REMOVER ############################################################################################
		//ATTACHER REMOVER LEVEL SELECT ###############################################################################
		private function attachLevelSelect(_x:Number = 0, _y:Number = 0, _id:int = 0):void{
			var levelSelect = new LevelSelect(_id);
			levelSelect.x = _x;
			levelSelect.y = _y;
			levelSelect.addEventListener(LevelSelect.EVENT_REMOVE, removeLevelSelect);
			levelSelect.addEventListener(LevelSelect.EVENT_ON_OPEN_CORE, onOpenCore);
			arrayOfLevelSelect.push(levelSelect);
			addChild(levelSelect);
		}
		
		private function removeLevelSelect(_event:Event):void{
			(_event.currentTarget as LevelSelect).removeEventListener(LevelSelect.EVENT_REMOVE, removeLevelSelect);
			(_event.currentTarget as LevelSelect).removeEventListener(LevelSelect.EVENT_ON_OPEN_CORE, onOpenCore);
			removeChild(_event.currentTarget as LevelSelect);
		}
		
		private function onOpenCore(_event:Event):void{
			trace("Open core level " + (_event.currentTarget as LevelSelect).getLevelId());
			PlayerDataManager.getInstance().setPlayerCurrentLevel(0, (_event.currentTarget as LevelSelect).getLevelId());
			dispatchEvent(new Event(EVENT_ON_OPEN_CORE));
		}
		//ATTACHER REMOVER LEVEL SELECT ###############################################################################
		//ATTACHER REMOVER ############################################################################################
		public function remove():void{
			this.removeChildren();
			dispatchEvent(new Event(EVENT_REMOVE));
		}
	}

}