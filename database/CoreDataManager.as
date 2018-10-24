package database
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class CoreDataManager extends MovieClip
	{
		private static var coreDataManager:CoreDataManager = new CoreDataManager();
		public static const NORMAL_PAYMENT:Number = 0.25;
		public static const START_MONEY:Number = 200.0;
		public static const START_CUSTOMER:int = 10;
		public static const START_POPULARITY:Number = 30;
		public static const START_EXPENSE:Number = 1.0;
		//ARRAY ENUM ##################################################################################################
		public static var ENUM_OPERATOR:int = 0;
		public static var ENUM_COMPUTER_AMOUNT:int = 1;
		public static var ENUM_COMPUTER_SPEC:int = 2;
		public static var ENUM_PERIPHERAL_SPEC:int = 3;
		public static var ENUM_NETWORK_SPEC:int = 4;
		public static var ENUM_MISCELLANEOUS:int = 5;
		//ARRAY ENUM ##################################################################################################
		public function CoreDataManager(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public static function getInstance():CoreDataManager{
			return coreDataManager;
		}
		//ANY LOGIG/FUNCTION ##########################################################################################
		public function resetData():void{
			playTime = 0;
			arrayOfComponentLevel = [0, 1, 1, 0, 1, 0];
			setPayment(NORMAL_PAYMENT);
			setMoney(1000);
			setCustomer(START_CUSTOMER);
			setPopularity(START_POPULARITY);
			setExpense(START_EXPENSE);
		}
		//COMPONENT RELATED FUNCTION ##################################################################################
		public function getComponentName(_id:int = 0):String{
			switch (_id){
				case ENUM_OPERATOR:
					if (getComponentLevel(ENUM_OPERATOR) == 0)
						return "None";
					else
						return DatabaseOperatorWarnet.getInstance().getOpWarnetName(getComponentLevel(ENUM_OPERATOR));
				break;
				case ENUM_COMPUTER_AMOUNT:
					return DatabaseComputerAmount.getInstance().getComputerAmountName(getComponentLevel(ENUM_COMPUTER_AMOUNT));
				break;
				case ENUM_COMPUTER_SPEC:
					return DatabaseComputerSpec.getInstance().getComputerSpecName(getComponentLevel(ENUM_COMPUTER_SPEC));
				break;
				case ENUM_MISCELLANEOUS:
					if (getComponentLevel(ENUM_MISCELLANEOUS) == 0)
						return "None";
					else	
						return DatabaseMiscellaneous.getInstance().getMiscellaneousName(getComponentLevel(ENUM_MISCELLANEOUS));
				break;
				case ENUM_NETWORK_SPEC:
					return DatabaseNetworkSpec.getInstance().getNetworkSpecName(getComponentLevel(ENUM_NETWORK_SPEC));
				break;
				case ENUM_PERIPHERAL_SPEC:
					if (getComponentLevel(ENUM_PERIPHERAL_SPEC) == 0)
						return "None";
					else
						return DatabasePeripheralSpec.getInstance().getPeripheralSpecName(getComponentLevel(ENUM_PERIPHERAL_SPEC));
				break;
				default:
				return "None";
			}
		}
		public function getComponentNextLevelPrice(_id:int = 0):Number{
			switch (_id){
				case ENUM_COMPUTER_AMOUNT:
					if (getComponentLevel(_id)<DatabaseComputerAmount.getInstance().getComputerAmountMaxLevel())
						return DatabaseComputerAmount.getInstance().getComputerAmountCost(getComponentLevel(_id) + 1);
				break;
				case ENUM_COMPUTER_SPEC:
					if (getComponentLevel(_id)<DatabaseComputerSpec.getInstance().getComputerSpecMaxLevel())
						return DatabaseComputerSpec.getInstance().getComputerSpecCost(getComponentLevel(_id) + 1);
				break;
				case ENUM_PERIPHERAL_SPEC:
					if (getComponentLevel(_id)<DatabasePeripheralSpec.getInstance().getPeripheralMaxLevel())
						return DatabasePeripheralSpec.getInstance().getPeripheralSpecCost(getComponentLevel(_id) + 1);
				break;
				case ENUM_NETWORK_SPEC:
					if (getComponentLevel(_id)<DatabaseNetworkSpec.getInstance().getNetworkSpecMaxLevel())
						return DatabaseNetworkSpec.getInstance().getNetworkSpecCost(getComponentLevel(_id) + 1);
				break;
				case ENUM_MISCELLANEOUS:
					if (getComponentLevel(_id)<DatabaseMiscellaneous.getInstance().getMiscellaneousMaxLevel())
						return DatabaseMiscellaneous.getInstance().getMiscellaneousCost(getComponentLevel(_id) + 1);
				break;
				default:
				return 0;
			}
			return 0;
		}
		public function getComponentPriceDisplay(_id:int = 0):String{
			if (isComponentMaxed(_id))
				return getComponentNextLevelPrice(_id).toString();
			else
				return "Maxed";
		}
		public function isComponentMaxed(_id:int = 0):Boolean{
			switch (_id){
				case ENUM_COMPUTER_AMOUNT:
					if (getComponentLevel(_id) < DatabaseComputerAmount.getInstance().getComputerAmountMaxLevel())
						return true;
				break;
				case ENUM_COMPUTER_SPEC:
					if (getComponentLevel(_id) < DatabaseComputerSpec.getInstance().getComputerSpecMaxLevel())
						return true;
				break;
				case ENUM_PERIPHERAL_SPEC:
					if (getComponentLevel(_id) < DatabasePeripheralSpec.getInstance().getPeripheralMaxLevel())
						return true;
				break;
				case ENUM_NETWORK_SPEC:
					if (getComponentLevel(_id)<DatabaseNetworkSpec.getInstance().getNetworkSpecMaxLevel())
						return true;
				break;
				case ENUM_MISCELLANEOUS:
					if (getComponentLevel(_id)<DatabaseMiscellaneous.getInstance().getMiscellaneousMaxLevel())
						return true;
				break;
				default:
				return false;
			}
			return false;
		}
		public function eligibleToUpgrade(_id:int = 0):Boolean{
			switch (_id){
				case ENUM_COMPUTER_AMOUNT:
					if (isComponentMaxed(_id)){
						if(getMoney()>=getComponentNextLevelPrice(_id))
							return true;
					} 
				break;
				case ENUM_COMPUTER_SPEC:
					if (isComponentMaxed(_id)){
						if(getMoney()>=getComponentNextLevelPrice(_id))
							return true;
					}
				break;
				case ENUM_PERIPHERAL_SPEC:
					if (isComponentMaxed(_id)){
						if(getMoney()>=getComponentNextLevelPrice(_id))
							return true;
					}
				break;
				case ENUM_NETWORK_SPEC:
					if (isComponentMaxed(_id)){
						if(getMoney()>=getComponentNextLevelPrice(_id))
							return true;
					}
				break;
				case ENUM_MISCELLANEOUS:
					if (isComponentMaxed(_id)){
						if(getMoney()>=getComponentNextLevelPrice(_id))
							return true;
					}
				break;
				default:
				return false;
			}
			return false;
		}
		//COMPONENT RELATED FUNCTION ##################################################################################
		//OPERATOR RELATED FUNCTION ###################################################################################
		public function hireOperator(_id:int = 1):void{
			setComponentLevel(ENUM_OPERATOR, _id);
			setOperatorTimer(DatabaseOperatorWarnet.getInstance().getOpWarnetDuration(_id));
		}
		public function fireOperator():void{
			setComponentLevel(ENUM_OPERATOR, 0);
			setOperatorTimer(0);
		}
		public function updateOperator():void{
			trace("Update Operator");
			if (getComponentLevel(ENUM_OPERATOR) != 0){
				trace("Timer left : " + getOperatorTimer());
				if (getOperatorTimer() < 1){
					fireOperator();
				}
				addOperatorTimer( -1);
				trace("Timer left : " + getOperatorTimer());
			}
		}
		//OPERATOR RELATED FUNCTION ###################################################################################
		//ANY LOGIG/FUNCTION ##########################################################################################
		public function calculateCustomerPayment():Number{
			var payment:Number = 0;
			payment += getPayment(); //trace("Normal payment = $" + payment);
			if (getComponentLevel(ENUM_MISCELLANEOUS) != 0){
				payment += calculateMiscPayment();
			}
			if (getComponentLevel(ENUM_OPERATOR) != 0){
				payment += calculateServiceBonus();
				payment += calculateTechnicalBonus();
			}//trace("Total payment = $" + payment);
			return payment;
		}
		private function calculateTechnicalBonus():Number{
			var payment:Number = getPayment(), multiplier:Number = 0;
			multiplier += DatabaseOperatorWarnet.getInstance().getOpWarnetTechnicalSkill(getComponentLevel(ENUM_OPERATOR)) / 2;
			payment *= multiplier;//trace("Technical bonus mult = "+multiplier+"; payment = $"+payment);
			return payment;
		}
		private function calculateServiceBonus():Number{
			var payment:Number = getPayment(), multiplier:Number = 0;
			multiplier += DatabaseOperatorWarnet.getInstance().getOpWarnetServiceSkill(getComponentLevel(ENUM_OPERATOR)) / 2;
			payment *= multiplier; //trace("Service bonus mult = "+multiplier+"; payment = $"+payment);
			return payment;
		}
		private function calculateMiscPayment():Number{
			var chance:Number = 0,multiplier:Number = 1, payment:Number = 0;
			chance += DatabaseMiscellaneous.getInstance().getMiscellaneousChance(getComponentLevel(ENUM_MISCELLANEOUS));
			if (getComponentLevel(ENUM_OPERATOR) != 0){
				chance += DatabaseOperatorWarnet.getInstance().getOpWarnetCookingSkill(getComponentLevel(ENUM_OPERATOR)) / 4;
				multiplier += DatabaseOperatorWarnet.getInstance().getOpWarnetCookingSkill(getComponentLevel(ENUM_OPERATOR)) / 2;
			}
			//trace("Misc payment chance = " + chance+"; multiplier = " + multiplier);
			if (Math.random() < chance){//trace("Customer bought misc");
				payment += multiplier * DatabaseMiscellaneous.getInstance().getMiscellaneousPayment(getComponentLevel(ENUM_MISCELLANEOUS));
			}//trace("Misc payment = $" + payment);
			return payment;
		}
		public function calculateMiscChance():Number{
			var chance:Number = 0;
			chance += DatabaseMiscellaneous.getInstance().getMiscellaneousChance(getComponentLevel(ENUM_MISCELLANEOUS));
			if (getComponentLevel(ENUM_OPERATOR) != 0)
				chance += DatabaseOperatorWarnet.getInstance().getOpWarnetCookingSkill(getComponentLevel(ENUM_OPERATOR)) / 4;
			return chance;
		}
		public function calculateExpense():void{
			var expense:Number = START_EXPENSE;
			expense += DatabaseComputerAmount.getInstance().getComputerAmountExpense(getComponentLevel(ENUM_COMPUTER_AMOUNT));
			expense += DatabaseComputerSpec.getInstance().getComputerSpecExpense(getComponentLevel(ENUM_COMPUTER_SPEC));
			expense += DatabaseNetworkSpec.getInstance().getNetworkSpecExpense(getComponentLevel(ENUM_NETWORK_SPEC));
			if (getComponentLevel(ENUM_MISCELLANEOUS) != 0)
				expense += DatabaseMiscellaneous.getInstance().getMiscellaneousExpense(getComponentLevel(ENUM_MISCELLANEOUS));
			if (getComponentLevel(ENUM_PERIPHERAL_SPEC) != 0)
				expense += DatabasePeripheralSpec.getInstance().getPeripheralSpecExpense(getComponentLevel(ENUM_PERIPHERAL_SPEC));
			setExpense(expense);
		}
		public function calculateNormalPayment():void{
			var payment:Number = NORMAL_PAYMENT;
			payment += DatabaseComputerSpec.getInstance().getComputerSpecExtraPay(getComponentLevel(ENUM_COMPUTER_SPEC));
			payment += DatabaseNetworkSpec.getInstance().getNetworkSpecExtraPay(getComponentLevel(ENUM_NETWORK_SPEC));
			if (getComponentLevel(ENUM_PERIPHERAL_SPEC) != 0)
				payment += DatabasePeripheralSpec.getInstance().getPeripheralSpecExtraPay(getComponentLevel(ENUM_PERIPHERAL_SPEC));
			setPayment(payment);
		}
		public function calculateCustomerGrowthChance():Number{
			return (getPopularity() - 2 * getCustomer()) / (getCustomer() * 2);
		}
		public function calculatePopularityDisplayValue():int{
			var value:Number = 50;
			value += (getPopularity() - (2 * getCustomer())) / (2 * getCustomer()) * 50;
			if (value > 100)
				value = 100;
			
			return value;
		}
		public function calculatePopularity():void{
			var popularity:Number = START_POPULARITY;
			popularity += DatabaseComputerSpec.getInstance().getComputerSpecExtraPop(getComponentLevel(ENUM_COMPUTER_SPEC));
			popularity += DatabaseNetworkSpec.getInstance().getNetworkSpecExtraPop(getComponentLevel(ENUM_NETWORK_SPEC));
			if (getComponentLevel(ENUM_PERIPHERAL_SPEC) != 0)
				popularity += DatabasePeripheralSpec.getInstance().getPeripheralSpecExtraPop(getComponentLevel(ENUM_PERIPHERAL_SPEC));
			if (getComponentLevel(ENUM_MISCELLANEOUS) != 0)
				popularity += DatabaseMiscellaneous.getInstance().getMiscellaneousExtraPop(getComponentLevel(ENUM_MISCELLANEOUS));
			setPopularity(popularity);
		}
		//ANY LOGIG/FUNCTION ##########################################################################################
		//PLAYER DATA VARIABLES #######################################################################################
		private var expense:Number;
		private var payment:Number;
		private var money:Number;
		private var customer:int;
		private var popularity:Number;
		private var operatorTimer:int;
		private var playTime:int;
		private var arrayOfComponentLevel = new Array();
		//PLAYER DATA VARIABLES #######################################################################################
		//VARIABLES ACCESSOR FUNCTION #################################################################################
		public function setExpense(_expense:Number = 0):void{
			expense = _expense;
		}
		public function getExpense():Number{
			return expense;
		}
		public function addExpense(_expense:Number = 0):void{
			expense = _expense;
		}
		//VARIABLES ACCESSOR FUNCTION #################################################################################
		public function setPayment(_payment:Number = 0):void{
			payment = _payment;
		}
		public function getPayment():Number{
			return payment;
		}
		public function addPayment(_payment:Number = 0):void{
			payment += _payment;
		}
		//VARIABLES ACCESSOR FUNCTION #################################################################################
		public function setMoney(_money:Number = 0):void{
			money = _money;
		}
		public function getMoney():Number{
			return money;
		}
		public function addMoney(_money:Number = 0):void{
			money += _money;
		}
		//VARIABLES ACCESSOR FUNCTION #################################################################################
		public function setCustomer(_customer:int = 0):void{
			customer = _customer;
		}
		public function getCustomer():int{
			return customer;
		}
		public function addCustomer(_customer:int = 1):void{
			customer += _customer;
		}
		//VARIABLES ACCESSOR FUNCTION #################################################################################
		public function setPopularity(_popularity:Number = 0):void{
			popularity = _popularity;
		}
		public function getPopularity():Number{
			return popularity;
		}
		public function addPopularity(_popularity:Number = 0):void{
			popularity += _popularity;
		}
		//VARIABLES ACCESSOR FUNCTION #################################################################################
		public function setOperatorTimer(_operatorTimer:int = 0):void{
			operatorTimer = _operatorTimer;
		}
		public function getOperatorTimer():int{
			return operatorTimer;
		}
		public function addOperatorTimer(_operatorTimer:int = 1):void{
			operatorTimer += _operatorTimer;
		}
		//VARIABLES ACCESSOR FUNCTION #################################################################################
		public function setComponentLevel(_id:int = 0, _level:int = 0):void{
			arrayOfComponentLevel[_id] = _level;
		}
		public function getComponentLevel(_id:int = 0):int{
			return arrayOfComponentLevel[_id];
		}
		public function addComponentLevel(_id:int = 0, _level:int = 1):void{
			arrayOfComponentLevel[_id] += _level;
		}
		//VARIABLES ACCESSOR FUNCTION #################################################################################
		public function setPlayTime(_playTime:int = 0):void{
			playTime = _playTime;
		}
		public function getPlayTime():int{
			return playTime;
		}
		public function addPlayTime(_playTime:int = 1):void{
			playTime += _playTime;
		}
		
	}
}