package gameplay.popUp
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gameplay.OperatorComponent;
	
	import database.CoreDataManager;
	import database.DatabaseOperatorWarnet;
	
	public class PopUpOperator extends MovieClip
	{
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
		//INITIALIZATION ##############################################################################################
		public function PopUpOperator() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			activateAllButtons();
			initComponent();
		}
		
		private function activateAllButtons():void{
			btn_Cancel.addEventListener(MouseEvent.CLICK, onClickCancelButton);
		}
		
		private function initComponent():void{
			attachOperatorComponent(35, 40, 1);
			attachOperatorComponent(35, 222, 2);
			attachOperatorComponent(35, 404, 3);
			attachOperatorComponent(657, 40, 4);
			attachOperatorComponent(657, 222, 5);
			attachOperatorComponent(657, 404, 6);
		}
		//INITIALIZATION ##############################################################################################
		//BUTTON FUNCTIONS ############################################################################################
		private function onClickCancelButton(e:Event):void{
			dispatchEvent(new Event(EVENT_REMOVE));
		}
		//BUTTON FUNCTIONS ############################################################################################
		//COMPONENT VARIABLES #########################################################################################
		private var arrayOfOperatorComponent:Array = new Array();
		private function attachOperatorComponent(_x:Number = 0, _y:Number = 0, _id:int = 0):void{
			var operatorComponent = new OperatorComponent(_id);
			operatorComponent.x = _x;
			operatorComponent.y = _y;
			operatorComponent.addEventListener(OperatorComponent.EVENT_REMOVE, removeOperatorComponent);
			operatorComponent.addEventListener(OperatorComponent.EVENT_HIRE, onHireOperator);
			arrayOfOperatorComponent.push(operatorComponent);
			addChild(operatorComponent);
		}
		
		private function onHireOperator(_event:Event):void{
			if (CoreDataManager.getInstance().getMoney()>=DatabaseOperatorWarnet.getInstance().getOpWarnetFee((_event.currentTarget as OperatorComponent).getId())){
				CoreDataManager.getInstance().addMoney( -1 * DatabaseOperatorWarnet.getInstance().getOpWarnetFee((_event.currentTarget as OperatorComponent).getId()));
				CoreDataManager.getInstance().hireOperator((_event.currentTarget as OperatorComponent).getId());
				removeChild(_event.currentTarget as OperatorComponent);
				remove();
			}
		}
		
		private function removeOperatorComponent(_event:Event):void{
			(_event.currentTarget as OperatorComponent).removeEventListener(OperatorComponent.EVENT_REMOVE, removeOperatorComponent);
			(_event.currentTarget as OperatorComponent).removeEventListener(OperatorComponent.EVENT_HIRE, onHireOperator);
			removeChild(_event.currentTarget as OperatorComponent);
		}
		//COMPONENT VARIABLES #########################################################################################
		public function remove():void{
			this.removeChildren();
			dispatchEvent(new Event(EVENT_REMOVE));
		}
	}

}