package gameplay.button
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import database.CoreDataManager;
	
	public class OperatorButton extends MovieClip{
		
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
		public static const EVENT_ON_CLICK_BUTTON:String = "EVENT_ON_CLICK_BUTTON";
		//INITIALIZATION ##############################################################################################
		public function OperatorButton(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			activateAllButtons();
			btn_HireOperator.visible = true;
			btn_FireOperator.visible = false;
		}
		public function update():void{
			updateVisibility();
		}
		
		private function updateVisibility():void{
			if (CoreDataManager.getInstance().getComponentLevel(CoreDataManager.ENUM_OPERATOR) == 0){
				btn_HireOperator.visible = true;
				btn_FireOperator.visible = false;
			}else{
				btn_FireOperator.visible = true;
				btn_HireOperator.visible = false;
			}
		}
		//INITIALIZATION ##############################################################################################
		//BUTTON FUNCTIONS ############################################################################################
		private function activateAllButtons():void{
			btn_HireOperator.addEventListener(MouseEvent.CLICK, onClickOperatorButton);
			btn_FireOperator.addEventListener(MouseEvent.CLICK, onClickOperatorButton);
		}
		
		private function onClickOperatorButton(e:MouseEvent):void{
			dispatchEvent(new Event(EVENT_ON_CLICK_BUTTON));
		}
		//BUTTON FUNCTIONS ############################################################################################
		public function remove():void{
			this.removeChildren();
			dispatchEvent(new Event(EVENT_REMOVE));
		}
	}
}