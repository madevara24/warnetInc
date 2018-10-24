package menu
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class LevelSelect extends MovieClip
	{
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
		public static const EVENT_ON_OPEN_CORE:String = "EVENT_ON_OPEN_CORE";
		public function LevelSelect(_levelId:int) 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
			setLevelId(_levelId);
		}
		
		private function init(_event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			activateAllButtons();
			initText();
		}
		
		private function initText():void {
			txt_LevelId.text = getLevelId().toString();
		}
		
		//BUTTON FUNCTIONS ############################################################################################
		private function activateAllButtons():void{
			btn_LevelSelect.addEventListener(MouseEvent.CLICK, onClickLevelSelectButton);
		}
		
		private function onClickLevelSelectButton(e:MouseEvent):void {
			dispatchEvent(new Event(EVENT_ON_OPEN_CORE));
		}
		
		//BUTTON FUNCTIONS ############################################################################################
		//LOCAL VARIABLE ##############################################################################################
		private var levelId:int;
		
		//LOCAL VARIABLE ##############################################################################################
		//LOCAL VARIABLE ACCESSOR #####################################################################################
		public function setLevelId(_levelId:int):void{
			levelId = _levelId;
		}
		public function getLevelId():int{
			return levelId;
		}
		//LOCAL VARIABLE ACCESSOR #####################################################################################
		
		public function remove():void
		{
			this.removeChildren();
			dispatchEvent(new Event(EVENT_REMOVE));
		}
	}
}