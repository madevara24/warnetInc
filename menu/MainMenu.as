package menu
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class MainMenu extends MovieClip
	{
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
		public static const EVENT_ON_OPEN_LEVEL_MENU:String = "EVENT_ON_OPEN_LEVEL_MENU";
		
		//INITIALIZATION ##############################################################################################
		public function MainMenu()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			activateAllButtons();
		}
		
		//BUTTON FUNCTION #############################################################################################
		private function activateAllButtons():void
		{
			btn_Play.addEventListener(MouseEvent.CLICK, onClickStartButton);
		}
		
		private function onClickStartButton(e:MouseEvent):void 
		{
			trace("On Clicked Play Button");
			dispatchEvent(new Event(EVENT_ON_OPEN_LEVEL_MENU));
		}
		
		public function remove():void
		{
			this.removeChildren();
			dispatchEvent(new Event(EVENT_REMOVE));
		}
	}

}