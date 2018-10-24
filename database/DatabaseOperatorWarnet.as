package database
{
	public class DatabaseOperatorWarnet{
		
		private static var databaseOperatorWarnet:DatabaseOperatorWarnet = new DatabaseOperatorWarnet();
		public static var MAX_LEVEL:int = 4;
		//ARRAY ENUM ##################################################################################################
		public static var ENUM_OP_NAME:int = 0;
		public static var ENUM_OP_FEE:int = 1;
		public static var ENUM_OP_SERVICE_SKILL:int = 2;
		public static var ENUM_OP_TECHNICAL_SKILL:int = 3;
		public static var ENUM_OP_COOKING_SKILL:int = 4;
		public static var ENUM_OP_DURATION:int = 5;
		//ARRAY ENUM ##################################################################################################
		
		public function DatabaseOperatorWarnet(){
			super();
			loadDatabase();
		}
		
		public static function getInstance():DatabaseOperatorWarnet{
			return databaseOperatorWarnet;
		}
		
		private var arrayOfDatabaseOperatorWarnet:Array;
		
		private function loadDatabase():void{
			arrayOfDatabaseOperatorWarnet = [
									[	"Name",				"Fee", "Service", "Technical", "Cooking",	"Duration", "Speciality"],
								/*1*/[	"Basic OP",			150,		0.2,		0.2,		0.2,		90,		"None"],
								/*2*/[	"Nice Guy OP",		250,		0.7,		0.2,		0.2,		90,		"Real friendly towards customers"],
								/*3*/[	"IT Support OP",	250,		0.2,		0.7,		0.2,		90,		"Will help you with anything technical"],
								/*4*/[	"Foodstall OP",		250,		0.2,		0.2,		0.7,		90,		"His cup noodles are better than restaurant meal"],
								/*5*/[	"All Round OP",		500,		0.6,		0.6,		0.6,		180,	"Jack of All Trades"],
								/*6*/[	"Ultimate OP",		1000,		0.9,		0.9,		0.9,		180,	"All you need from an operator"]
								];
		}
		
		//ACCESSOR FUNCTIONS ##########################################################################################
		public function getOpWarnetName(_id:int = 0):String{
			return arrayOfDatabaseOperatorWarnet[_id][0];
		}
		public function getOpWarnetFee(_id:int = 0):Number{
			return arrayOfDatabaseOperatorWarnet[_id][1];
		}
		public function getOpWarnetServiceSkill(_id:int = 0):Number{
			return arrayOfDatabaseOperatorWarnet[_id][2];
		}
		public function getOpWarnetTechnicalSkill(_id:int = 0):Number{
			return arrayOfDatabaseOperatorWarnet[_id][3];
		}
		public function getOpWarnetCookingSkill(_id:int = 0):Number{
			return arrayOfDatabaseOperatorWarnet[_id][4];
		}
		public function getOpWarnetDuration(_id:int = 0):int{
			return arrayOfDatabaseOperatorWarnet[_id][5];
		}
		public function getOpWarnetSpeciality(_id:int = 0):String{
			return arrayOfDatabaseOperatorWarnet[_id][6];
		}
		//ACCESSOR FUNCTIONS ##########################################################################################
	}

}