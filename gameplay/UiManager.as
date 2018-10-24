package gameplay
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gameplay.popUp.PopUpPause;
	
	import gameplay.button.OperatorButton;
	import gameplay.popUp.PopUpOperator;
	
	import database.CoreDataManager;
	
	public class UiManager extends MovieClip
	{
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
		public static const EVENT_ON_OPEN_PAUSE:String = "EVENT_ON_OPEN_PAUSE";
		//INITIALIZATION ##############################################################################################
		public function UiManager(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			attachOperatorButton(483, 177);
			activateAllButtons();
		}
		
		private function activateAllButtons():void{
			btn_Pause.addEventListener(MouseEvent.CLICK, onClickPauseButton);
			btn_UpgradeComputerSpec.addEventListener(MouseEvent.CLICK, onClickUpgradeComputerSpecButton);
			btn_UpgradeComputerAmount.addEventListener(MouseEvent.CLICK, onClickUpgradeComputerAmountButton);
			btn_UpgradePeripheral.addEventListener(MouseEvent.CLICK, onClickUpgradePeripheralButton);
			btn_UpgradeNetwork.addEventListener(MouseEvent.CLICK, onClickUpgradeNetworkButton);
			btn_UpgradeMiscellaneous.addEventListener(MouseEvent.CLICK, onClickUpgradeMiscellaneousButton);
		}
		
		public function update():void{
			updateOperatorButton();
			updateText();
		}
		
		private function updateOperatorButton():void{
			getOperatorButton().update();
		}
		
		private function updateText():void{
			updateResourceText();
			updateComponentText();
		}
		
		private function updateResourceText():void{
			txt_Money.text = CoreDataManager.getInstance().getMoney().toFixed(2);
			txt_Customer.text = CoreDataManager.getInstance().getCustomer().toString();
			txt_Popularity.text = CoreDataManager.getInstance().calculatePopularityDisplayValue() + "%";
		}
		
		private function updateComponentText():void{
			txt_OperatorName.text = CoreDataManager.getInstance().getComponentName(CoreDataManager.ENUM_OPERATOR);
			txt_ComputerName.text = CoreDataManager.getInstance().getComponentName(CoreDataManager.ENUM_COMPUTER_SPEC);
			txt_ComputerUpgradePrice.text = CoreDataManager.getInstance().getComponentPriceDisplay(CoreDataManager.ENUM_COMPUTER_SPEC);
			txt_ComputerAmountName.text = CoreDataManager.getInstance().getComponentName(CoreDataManager.ENUM_COMPUTER_AMOUNT);
			txt_ComputerAmountUpgradePrice.text = CoreDataManager.getInstance().getComponentPriceDisplay(CoreDataManager.ENUM_COMPUTER_AMOUNT);
			txt_PeripheralName.text = CoreDataManager.getInstance().getComponentName(CoreDataManager.ENUM_PERIPHERAL_SPEC);
			txt_PeripheralUpgradePrice.text = CoreDataManager.getInstance().getComponentPriceDisplay(CoreDataManager.ENUM_PERIPHERAL_SPEC);
			txt_NetworkName.text = CoreDataManager.getInstance().getComponentName(CoreDataManager.ENUM_NETWORK_SPEC);
			txt_NetworkUpgradePrice.text = CoreDataManager.getInstance().getComponentPriceDisplay(CoreDataManager.ENUM_NETWORK_SPEC);
			txt_MiscellaneousName.text = CoreDataManager.getInstance().getComponentName(CoreDataManager.ENUM_MISCELLANEOUS);
			txt_MiscellaneousUpgradePrice.text = CoreDataManager.getInstance().getComponentPriceDisplay(CoreDataManager.ENUM_MISCELLANEOUS);
		}
		//INITIALIZATION ##############################################################################################
		//BUTTON FUNCTIONS ############################################################################################
		private function onClickPauseButton(e:MouseEvent):void{
			dispatchEvent(new Event(EVENT_ON_OPEN_PAUSE));
		}
		private function onClickUpgradeComputerSpecButton(e:MouseEvent):void{
			if (CoreDataManager.getInstance().eligibleToUpgrade(CoreDataManager.ENUM_COMPUTER_SPEC)){
				CoreDataManager.getInstance().addMoney( -1 * CoreDataManager.getInstance().getComponentNextLevelPrice(CoreDataManager.ENUM_COMPUTER_SPEC));
				CoreDataManager.getInstance().addComponentLevel(CoreDataManager.ENUM_COMPUTER_SPEC, 1);
			}
		}
		private function onClickUpgradeComputerAmountButton(e:MouseEvent):void{
			if (CoreDataManager.getInstance().eligibleToUpgrade(CoreDataManager.ENUM_COMPUTER_AMOUNT)){
				CoreDataManager.getInstance().addMoney( -1 * CoreDataManager.getInstance().getComponentNextLevelPrice(CoreDataManager.ENUM_COMPUTER_AMOUNT));
				CoreDataManager.getInstance().addComponentLevel(CoreDataManager.ENUM_COMPUTER_AMOUNT, 1);
			}
		}
		private function onClickUpgradePeripheralButton(e:MouseEvent):void{
			if (CoreDataManager.getInstance().eligibleToUpgrade(CoreDataManager.ENUM_PERIPHERAL_SPEC)){
				CoreDataManager.getInstance().addMoney( -1 * CoreDataManager.getInstance().getComponentNextLevelPrice(CoreDataManager.ENUM_PERIPHERAL_SPEC));
				CoreDataManager.getInstance().addComponentLevel(CoreDataManager.ENUM_PERIPHERAL_SPEC, 1);
			}
		}
		private function onClickUpgradeNetworkButton(e:MouseEvent):void{
			if (CoreDataManager.getInstance().eligibleToUpgrade(CoreDataManager.ENUM_NETWORK_SPEC)){
				CoreDataManager.getInstance().addMoney( -1 * CoreDataManager.getInstance().getComponentNextLevelPrice(CoreDataManager.ENUM_NETWORK_SPEC));
				CoreDataManager.getInstance().addComponentLevel(CoreDataManager.ENUM_NETWORK_SPEC, 1);
			}
		}
		private function onClickUpgradeMiscellaneousButton(e:MouseEvent):void{
			if (CoreDataManager.getInstance().eligibleToUpgrade(CoreDataManager.ENUM_MISCELLANEOUS)){
				CoreDataManager.getInstance().addMoney( -1 * CoreDataManager.getInstance().getComponentNextLevelPrice(CoreDataManager.ENUM_MISCELLANEOUS));
				CoreDataManager.getInstance().addComponentLevel(CoreDataManager.ENUM_MISCELLANEOUS, 1);
			}
		}
		//BUTTON FUNCTIONS ############################################################################################
		//CLASS VARIABLES #############################################################################################
		private var operatorButton:OperatorButton;
		private var popUpOperator:PopUpOperator;
		//CLASS VARIABLES #############################################################################################
		//CLASS VARIABLES ATTACHER REMOVER ############################################################################
		private function attachOperatorButton(_x:Number = 0, _y:Number = 0):void{
			operatorButton = new OperatorButton();
			operatorButton.x = _x;
			operatorButton.y = _y;
			operatorButton.addEventListener(OperatorButton.EVENT_REMOVE, removeOperatorButton);
			operatorButton.addEventListener(OperatorButton.EVENT_ON_CLICK_BUTTON, onClickButton);
			addChild(operatorButton);
		}
		
		private function getOperatorButton():OperatorButton{
			return operatorButton;
		}
		
		private function onClickButton(e:Event):void{
			if (CoreDataManager.getInstance().getComponentLevel(CoreDataManager.ENUM_OPERATOR) != 0)
				CoreDataManager.getInstance().fireOperator();
			else
				attachPopUpOperator();
		}
		
		private function removeOperatorButton(_event:Event):void{
			(_event.currentTarget as OperatorButton).removeEventListener(OperatorButton.EVENT_REMOVE, removeOperatorButton);
			(_event.currentTarget as OperatorButton).removeEventListener(OperatorButton.EVENT_ON_CLICK_BUTTON, onClickButton);
			removeChild(_event.currentTarget as OperatorButton);
		}
		//CLASS VARIABLES ATTACHER REMOVER ############################################################################
		private function attachPopUpOperator(_x:Number = 0, _y:Number = 0):void{
			popUpOperator = new PopUpOperator();
			popUpOperator.x = _x;
			popUpOperator.y = _y;
			popUpOperator.addEventListener(PopUpOperator.EVENT_REMOVE, removePopUpOperator);
			addChild(popUpOperator);
		}
		
		private function removePopUpOperator(_event:Event):void{
			(_event.currentTarget as PopUpOperator).removeEventListener(PopUpOperator.EVENT_REMOVE, removePopUpOperator);
			removeChild(_event.currentTarget as PopUpOperator);
		}
		//CLASS VARIABLES ATTACHER REMOVER ############################################################################
		public function remove():void{
			this.removeChildren();
			dispatchEvent(new Event(EVENT_REMOVE));
		}
	}
}