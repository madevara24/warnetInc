package database
{	
	public class DatabaseNetworkSpec{
		
		private static var databaseNetworkSpec:DatabaseNetworkSpec = new DatabaseNetworkSpec();
		public static var MAX_LEVEL:int = 4;
		//ARRAY ENUM ##################################################################################################
		public static var ENUM_AUX_SPEC_NAME:int = 0;
		//ARRAY ENUM ##################################################################################################
		
		public function DatabaseNetworkSpec(){
			super();
			loadDatabase();
		}
		
		public static function getInstance():DatabaseNetworkSpec{
			return databaseNetworkSpec;
		}
		
		private var arrayOfDatabaseNetworkSpec:Array;
		
		private function loadDatabase():void{
			arrayOfDatabaseNetworkSpec = [
									[	"Name",				"Cost", "XTR Payment", "XTR Popularity", "XTR Expense"],
								/*1*/[	"Dial Up",			0,			0,				0,				0],
								/*2*/[	"Coax Wire",		500,		1,				10,				1],
								/*3*/[	"Standard WiFi",	1200,		1.5,			20,				3],
								/*4*/[	"Fibre Optic",		2500,		2,				30,				4],
								/*5*/[	"Gaming Router",	6000,		3,				40,				6]
								];
		}
		
		//ACCESSOR FUNCTIONS ##########################################################################################
		public function getNetworkSpecName(_idNetwork:int = 0):String{
			return arrayOfDatabaseNetworkSpec[_idNetwork][0];
		}
		public function getNetworkSpecCost(_idNetwork:int = 0):Number{
			return arrayOfDatabaseNetworkSpec[_idNetwork][1];
		}
		public function getNetworkSpecExtraPay(_idNetwork:int = 0):Number{
			return arrayOfDatabaseNetworkSpec[_idNetwork][2];
		}
		public function getNetworkSpecExtraPop(_idNetwork:int = 0):Number{
			return arrayOfDatabaseNetworkSpec[_idNetwork][3];
		}
		public function getNetworkSpecExpense(_idNetwork:int = 0):Number{
			return arrayOfDatabaseNetworkSpec[_idNetwork][4];
		}
		public function getNetworkSpecMaxLevel():int{
			return arrayOfDatabaseNetworkSpec.length - 1;
		}
		//ACCESSOR FUNCTIONS ##########################################################################################
		
	}

}