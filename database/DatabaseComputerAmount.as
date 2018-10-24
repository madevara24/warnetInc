package database
{
	public class DatabaseComputerAmount{
		
		private static var databaseComputerAmount:DatabaseComputerAmount = new DatabaseComputerAmount();
		public static var MAX_LEVEL:int = 4;
		//ARRAY ENUM ##################################################################################################
		public static var ENUM_PC_AMOUNT_NAME:int = 0;
		public static var ENUM_PC_AMOUNT_COST:int = 1;
		public static var ENUM_PC_AMOUNT_MAX_CUSTOMER:int = 2;
		//ARRAY ENUM ##################################################################################################
		
		public function DatabaseComputerAmount(){
			super();
			loadDatabase();
		}
		
		public static function getInstance():DatabaseComputerAmount{
			return databaseComputerAmount;
		}
		
		private var arrayOfDatabaseComputerAmount:Array;
		
		private function loadDatabase():void{
			arrayOfDatabaseComputerAmount = [
									[	"Name",				"Cost", "Max Customer", "XTR Expense"],
								/*1*/[	"Few PC Desk",			0,			15,			0],
								/*2*/[	"More PC Desk",			5000,		20,			20],
								/*3*/[	"Even More PC Desk",	10000,		30,			40],
								/*4*/[	"Loads of PC Desk",		20000,		50,			80]
								];
		}
		
		//ACCESSOR FUNCTIONS ##########################################################################################
		public function getComputerAmountName(_idAmount:int = 0):String{
			return arrayOfDatabaseComputerAmount[_idAmount][0];
		}
		public function getComputerAmountCost(_idAmount:int = 0):Number{
			return arrayOfDatabaseComputerAmount[_idAmount][1];
		}
		public function getComputerAmountMaxCustomer(_idAmount:int = 0):Number{
			return arrayOfDatabaseComputerAmount[_idAmount][2];
		}
		public function getComputerAmountExpense(_idAmount:int = 0):Number{
			return arrayOfDatabaseComputerAmount[_idAmount][3];
		}
		public function getComputerAmountMaxLevel():int{
			return arrayOfDatabaseComputerAmount.length - 1;
		}
		//ACCESSOR FUNCTIONS ##########################################################################################
	}
}