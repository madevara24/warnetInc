package database
{
	public class DatabaseComputerSpec{
		
		private static var databaseComputerSpec:DatabaseComputerSpec = new DatabaseComputerSpec();
		public static var MAX_LEVEL:int = 4;
		//ARRAY ENUM ##################################################################################################
		public static var ENUM_PC_SPEC_NAME:int = 0;
		public static var ENUM_PC_SPEC_COST:int = 1;
		public static var ENUM_PC_SPEC_EXTRA_PAY:int = 2;
		public static var ENUM_PC_SPEC_EXTRA_POP:int = 3;
		//ARRAY ENUM ##################################################################################################
		
		public function DatabaseComputerSpec(){
			super();
			loadDatabase();
		}
		
		public static function getInstance():DatabaseComputerSpec{
			return databaseComputerSpec;
		}
		
		private var arrayOfDatabaseComputerSpec:Array;
		
		private function loadDatabase():void{
			arrayOfDatabaseComputerSpec = [
									[	"Name",					"Cost", "XTR Payment", "XTR Popularity", "XTR Expense"],
								/*1*/[	"DOS PC",				0,			0,					0,			0],
								/*2*/[	"Basic PC",				1000,		1,					10,			1],
								/*3*/[	"XP PC",				2400,		2,					20,			2],
								/*4*/[	"Deluxe PC",			4000,		4,					40,			4],
								/*5*/[	"Gaming PC",			10000,		6,					60,			8],
								/*6*/[	"Hardcore Game PC",		25000,		10,					80,			16],
								];
		}
		
		//ACCESSOR FUNCTIONS ##########################################################################################
		public function getComputerSpecName(_idSpec:int = 0):String{
			return arrayOfDatabaseComputerSpec[_idSpec][0];
		}
		public function getComputerSpecCost(_idSpec:int = 0):Number{
			return arrayOfDatabaseComputerSpec[_idSpec][1];
		}
		public function getComputerSpecExtraPay(_idSpec:int = 0):Number{
			return arrayOfDatabaseComputerSpec[_idSpec][2];
		}
		public function getComputerSpecExtraPop(_idSpec:int = 0):Number{
			return arrayOfDatabaseComputerSpec[_idSpec][3];
		}
		public function getComputerSpecExpense(_idSpec:int = 0):Number{
			return arrayOfDatabaseComputerSpec[_idSpec][4];
		}
		public function getComputerSpecMaxLevel():int{
			return arrayOfDatabaseComputerSpec.length - 1;
		}
		//ACCESSOR FUNCTIONS ##########################################################################################
	}

}