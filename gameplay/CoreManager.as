package gameplay
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gameplay.popUp.PopUpPause;
	
	import com.greensock.TweenMax;
	
	import database.CoreDataManager;
	import database.PlayerDataManager;
	import database.DatabaseComputerAmount;
	import database.DatabaseComputerSpec;
	import database.DatabaseMiscellaneous;
	import database.DatabaseNetworkSpec;
	import database.DatabaseOperatorWarnet;
	import database.DatabasePeripheralSpec;
	
	import gameplay.UiManager;
	
	public class CoreManager extends MovieClip
	{
		//STATIC & LAYER VARIABLES ####################################################################################
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
		public static const EVENT_QUIT:String = "EVENT_QUIT";
		
		private var layerBackground:MovieClip = new MovieClip();
		private var layerObjects:MovieClip = new MovieClip();
		private var layerUi:MovieClip = new MovieClip();
		private var layerPopUp:MovieClip = new MovieClip();
		//STATIC & LAYER VARIABLES ####################################################################################
		//INITIALIZATION ##############################################################################################
		public function CoreManager(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			activateEventListener();
			initLayer();
			initCore();
			initUi();
		}
		
		private function initUi():void{
			attachUiManager();
		}
		
		private function initCore():void{
			CoreDataManager.getInstance().resetData();
			startOnFrequently();
		}
		
		private function initLayer():void{
			addChild(layerBackground);
			addChild(layerObjects);
			addChild(layerUi);
			addChild(layerPopUp);
		}
		
		private function activateEventListener():void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		//INITIALIZATION ##############################################################################################
		//ON FREQUENTLY FUNCTIONS #####################################################################################
		private function startOnFrequently():void {
			onFrequentlyUpdateResource();
		}
		private function onFrequentlyUpdateResource():void{
			if (!isPaused()){
				CoreDataManager.getInstance().calculateNormalPayment();
				CoreDataManager.getInstance().calculateExpense();
				CoreDataManager.getInstance().calculatePopularity();
				onFrequentlyUpdateMoney();
				onFrequentlyUpdateOperator();
				onFrequentlyUpdateCustomer();
			}
			onFrequentlyUpdatePlayTime();
			TweenMax.delayedCall(0.5, onFrequentlyUpdateResource);
		}
		
		private function onFrequentlyUpdateOperator():void{
			CoreDataManager.getInstance().updateOperator();
		}
		private function onFrequentlyUpdateMoney():void{
			CoreDataManager.getInstance().addMoney(calculatePaymentIncome());
			CoreDataManager.getInstance().addMoney( -1 * CoreDataManager.getInstance().getExpense());
		}
		private function onFrequentlyUpdateCustomer():void{
			calculateCustomer();
		}
		
		private function onFrequentlyUpdatePlayTime():void{
			CoreDataManager.getInstance().addPlayTime();
		}
		//ON FREQUENTLY FUNCTIONS #####################################################################################
		//CALCULATION FUNCTIONS #######################################################################################
		private function calculatePaymentIncome():Number{
			var income:Number = 0;
			for (var i:int = 0; i < CoreDataManager.getInstance().getCustomer(); i++){
				if (isCustomerPaying()){//trace("Customer #" + i + " is paying");
					income += calculateCustomerPayment();
				}
			}
			return income;
		}
		private function calculateCustomerPayment():Number{
			return CoreDataManager.getInstance().calculateCustomerPayment();
		}
		private function calculateCustomer():void{
			var chance:Number = 0;
			chance = CoreDataManager.getInstance().calculateCustomerGrowthChance();
			do{//trace("Pop = " + CoreDataManager.getInstance().getPopularity() + "; Cust = " + CoreDataManager.getInstance().getCustomer() + "; Chance = " + chance);
				if (chance >= 0.5){
					if (Math.random()<=0.5 && !isCustomerMaxed())
						CoreDataManager.getInstance().addCustomer(1); //trace("Rand <= 0.5"); trace("Customer added, " + CoreDataManager.getInstance().getCustomer() + " total");
				}else{
					if (Math.random() <= chance && !isCustomerMaxed())
						CoreDataManager.getInstance().addCustomer(1); //trace("Rand <= " + chance); trace("Customer added, " + CoreDataManager.getInstance().getCustomer() + " total");
				}
				chance -= 0.5; //trace("Chance -= 0.5 = " + chance);
			} while (chance > 0);
		}
		//CALCULATION FUNCTIONS #######################################################################################
		//UPDATE FUNCTION #############################################################################################
		private function onEnterFrame(e:Event):void{
			getUiManager().update();
		}
		//UPDATE FUNCTION #############################################################################################
		//OTHER FUNCTION ##############################################################################################
		private function getMaxCustomer():int{
			return DatabaseComputerAmount.getInstance().getComputerAmountMaxCustomer(CoreDataManager.getInstance().getComponentLevel(CoreDataManager.ENUM_COMPUTER_AMOUNT));
		}
		private function isCustomerMaxed():Boolean{
			if (CoreDataManager.getInstance().getCustomer() < getMaxCustomer())
				return false;
			else
				return true;
		}
		private function isCustomerPaying():Boolean{
			if (CoreDataManager.getInstance().getComponentLevel(CoreDataManager.ENUM_OPERATOR) == 0){
				if (Math.random() < 0.25)
					return true;
				else
					return false;
			}
			else{
				if (Math.random() < 0.7 + DatabaseOperatorWarnet.getInstance().getOpWarnetServiceSkill(CoreDataManager.getInstance().getComponentLevel(CoreDataManager.ENUM_OPERATOR)))
					return true;
				else
					return false;
			}
		}
		private function getRandomrInteger(_min:int = 0, _max:int = 0):int{
			var range:int = _max - _min;
			return Math.round(Math.random() * range) + _min;
		}
		private function getRandomrNumber(_min:int = 0, _max:int = 0):Number{
			var range:int = _max - _min;
			return Math.random() * range + _min;
		}
		//OTHER FUNCTION ##############################################################################################
		//LOCAL VARIABLES #############################################################################################
		private var level:int;
		private var paused:Boolean;
		//LOCAL VARIABLES #############################################################################################
		//MENU VARIABLES ##############################################################################################
		private var uiManager:UiManager;
		private var popUpPause:PopUpPause;
		//MENU VARIABLES ##############################################################################################
		//LOCAL VARIABLES ACCESSOR ####################################################################################
		private function setLevel(_level:int):void{
			//trace("Set to level " + _level);
			level = _level;
		}
		private function getLevel():int{
			return level;
		}
		private function setPaused(_paused:Boolean = false):void{
			paused = _paused;
		}
		private function isPaused():Boolean{
			return paused;
		}
		//LOCAL VARIABLES ACCESSOR ####################################################################################
		//ATTACHER REMOVER ############################################################################################
		//ATTACHER REMOVER UI MANAGER #################################################################################
		private function attachUiManager(_x:Number = 0, _y:Number = 0):void{
			uiManager = new UiManager();
			uiManager.x = _x;
			uiManager.y = _y;
			uiManager.addEventListener(UiManager.EVENT_ON_OPEN_PAUSE, onOpenPopUpPause)
			uiManager.addEventListener(UiManager.EVENT_REMOVE, removeUiManager);
			layerUi.addChild(uiManager);
		}
		
		private function onOpenPopUpPause(e:Event):void{
			setPaused(true);
			attachPopUpPause();
		}
		private function getUiManager():UiManager{
			return uiManager;
		}
		private function removeUiManager(_event:Event):void{
			(_event.currentTarget as UiManager).removeEventListener(UiManager.EVENT_REMOVE, removeUiManager);
			layerUi.removeChild(_event.currentTarget as UiManager);
		}
		//ATTACHER REMOVER UI MANAGER #################################################################################
		//ATTACHER REMOVER POP UP PAUSE ###############################################################################
		private function attachPopUpPause(_x:Number = 0, _y:Number = 0):void{
			popUpPause = new PopUpPause();
			popUpPause.x = _x;
			popUpPause.y = _y;
			popUpPause.addEventListener(PopUpPause.EVENT_REMOVE, removePopUpPause);
			popUpPause.addEventListener(PopUpPause.EVENT_QUIT, onQuitGame);
			addChild(popUpPause);
		}
		
		private function onQuitGame(e:Event):void{
			dispatchEvent(new Event(EVENT_QUIT));
		}
		
		private function removePopUpPause(_event:Event):void{
			(_event.currentTarget as PopUpPause).removeEventListener(PopUpPause.EVENT_REMOVE, removePopUpPause);
			(_event.currentTarget as PopUpPause).removeEventListener(PopUpPause.EVENT_QUIT, onQuitGame);
			removeChild(_event.currentTarget as PopUpPause);
			setPaused(false);
		}
		//ATTACHER REMOVER POP UP PAUSE ###############################################################################
		//ATTACHER REMOVER ############################################################################################
		public function remove():void{
			this.removeChildren();
			dispatchEvent(new Event(EVENT_REMOVE));
		}
	}

}