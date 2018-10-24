package database
{
	public class DatabasePeripheralSpec{
		
		private static var databasePeripheralSpec:DatabasePeripheralSpec = new DatabasePeripheralSpec();
		public static var MAX_LEVEL:int = 4;
		//ARRAY ENUM ##################################################################################################
		public static var ENUM_PER_SPEC_NAME:int = 0;
		public static var ENUM_PER_SPEC_COST:int = 1;
		public static var ENUM_PER_SPEC_EXTRA_PAY:int = 2;
		public static var ENUM_PER_SPEC_EXTRA_POP:int = 3;
		//ARRAY ENUM ##################################################################################################
		
		public function DatabasePeripheralSpec(){
			super();
			loadDatabase();
		}
		
		public static function getInstance():DatabasePeripheralSpec{
			return databasePeripheralSpec;
		}
		
		private var arrayOfDatabasePeripheralSpec:Array;
		
		private function loadDatabase():void{
			arrayOfDatabasePeripheralSpec = [
									[	"Name",					"Cost", "XTR Payment", "XTR Popularity", "XTR Expense"],
								/*1*/[	"Gaming Mouse",			700,		1,				10,				1],
								/*2*/[	"Gaming Headphones",	1500,		1.5,			20,				2],
								/*3*/[	"Joystick",				3000,		2.5,			40,				4],
								/*4*/[	"4K Monitor",			5000,		4,				60,				5],
								/*5*/[	"Gaming Kit",			8000,		6,				80,				8],
								/*6*/[	"AR/VR Kit",			16000,		8.5,			120,			12]
								];
		}
		
		//ACCESSOR FUNCTIONS ##########################################################################################
		public function getPeripheralSpecName(_idPer:int = 0):String{
			return arrayOfDatabasePeripheralSpec[_idPer][0];
		}
		public function getPeripheralSpecCost(_idPer:int = 0):Number{
			return arrayOfDatabasePeripheralSpec[_idPer][1];
		}
		public function getPeripheralSpecExtraPay(_idPer:int = 0):Number{
			return arrayOfDatabasePeripheralSpec[_idPer][2];
		}
		public function getPeripheralSpecExtraPop(_idPer:int = 0):Number{
			return arrayOfDatabasePeripheralSpec[_idPer][3];
		}
		public function getPeripheralSpecExpense(_idPer:int = 0):Number{
			return arrayOfDatabasePeripheralSpec[_idPer][4];
		}
		public function getPeripheralMaxLevel():int{
			return arrayOfDatabasePeripheralSpec.length - 1;
		}
		//ACCESSOR FUNCTIONS ##########################################################################################
	}

}