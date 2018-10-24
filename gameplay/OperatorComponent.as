package gameplay 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import database.DatabaseOperatorWarnet;
	public class OperatorComponent extends MovieClip
	{
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
		public static const EVENT_HIRE:String = "EVENT_HIRE";
		//INITIALIZATION ##############################################################################################
		public function OperatorComponent(_id:int = 0){
			super();
			setId(_id);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			activateAllButtons();
			initText();
		}
		
		private function activateAllButtons():void{
			btn_Hire.addEventListener(MouseEvent.CLICK, onClickHireButton);
		}
		
		private function initText():void{
			txt_OperatorName.text = DatabaseOperatorWarnet.getInstance().getOpWarnetName(getId());
			txt_OperatorSpeciality.text = DatabaseOperatorWarnet.getInstance().getOpWarnetSpeciality(getId());
			txt_OperatorFee.text = DatabaseOperatorWarnet.getInstance().getOpWarnetFee(getId()).toFixed(2);
		}
		//INITIALIZATION ##############################################################################################
		//BUTTON FUNCTIONS ############################################################################################
		private function onClickHireButton(e:MouseEvent):void{
			dispatchEvent(new Event(EVENT_HIRE));
		}
		//BUTTON FUNCTIONS ############################################################################################
		//LOCAL VARIABLES #############################################################################################
		private var id:int;
		public function setId(_id:int = 0):void{
			id = _id;
		}
		public function getId():int{
			return id;
		}
		//LOCAL VARIABLES #############################################################################################
		public function remove():void{
			this.removeChildren();
			dispatchEvent(new Event(EVENT_REMOVE));
		}
	}

}