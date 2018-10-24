package database
{
	public class DatabaseMiscellaneous{
		
		private static var databaseMiscellaneous:DatabaseMiscellaneous = new DatabaseMiscellaneous();
		public static var MAX_LEVEL:int = 4;
		//ARRAY ENUM ##################################################################################################
		public static var ENUM_AUX_SPEC_NAME:int = 0;
		//ARRAY ENUM ##################################################################################################
		
		public function DatabaseMiscellaneous(){
			super();
			loadDatabase();
		}
		
		public static function getInstance():DatabaseMiscellaneous{
			return databaseMiscellaneous;
		}
		
		private var arrayOfDatabaseMiscellaneous:Array;
		
		private function loadDatabase():void{
			arrayOfDatabaseMiscellaneous = [
									[	"Name",						"Cost", "Payment", "Purchase Chance", "XTR Popularity", "XTR Expense"],
								/*1*/[	"Cold Drink Fridge",		5000,		1,				0.3,				10, 		5],
								/*2*/[	"Hot Water Dispenser",		12000,		2,				0.4,				20, 		10],
								/*3*/[	"Complete Stove",			20000,		3,				0.5,				30, 		15]
								];
		}
		
		//ACCESSOR FUNCTIONS ##########################################################################################
		public function getMiscellaneousName(_idMisc:int = 0):String{
			return arrayOfDatabaseMiscellaneous[_idMisc][0];
		}
		public function getMiscellaneousCost(_idMisc:int = 0):Number{
			return arrayOfDatabaseMiscellaneous[_idMisc][1];
		}
		public function getMiscellaneousPayment(_idMisc:int = 0):Number{
			return arrayOfDatabaseMiscellaneous[_idMisc][2];
		}
		public function getMiscellaneousChance(_idMisc:int = 0):Number{
			return arrayOfDatabaseMiscellaneous[_idMisc][3];
		}
		public function getMiscellaneousExtraPop(_idMisc:int = 0):Number{
			return arrayOfDatabaseMiscellaneous[_idMisc][4];
		}
		public function getMiscellaneousExpense(_idMisc:int = 0):Number{
			return arrayOfDatabaseMiscellaneous[_idMisc][5];
		}
		public function getMiscellaneousMaxLevel():int{
			return arrayOfDatabaseMiscellaneous.length - 1;
		}
		//ACCESSOR FUNCTIONS ##########################################################################################
		
	}

}