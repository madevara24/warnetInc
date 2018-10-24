package 
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import menu.MainMenu;
	import menu.LevelMenu;
	
	import gameplay.CoreManager;
	
	public class Main extends MovieClip
	{
		public function Main()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			trace("Conn");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initMenu();
		}
		
		private function initMenu():void {
			attachMainMenu();
		}
		
		//MENU VARIABLES ###################################################################################################
		private var mainMenu:MainMenu;
		private var levelMenu:LevelMenu;
		private var coreManager:CoreManager;
		
		//MENU VARIABLES ###################################################################################################
		//ATTACHER REMOVER #################################################################################################
		//ATTACHER REMOVER MAIN MENU #######################################################################################
		private function attachMainMenu(_x:Number = 0, _y:Number = 0):void{
			mainMenu = new MainMenu();
			mainMenu.x = _x;
			mainMenu.y = _y;
			mainMenu.addEventListener(MainMenu.EVENT_REMOVE, removeMainMenu);
			mainMenu.addEventListener(MainMenu.EVENT_ON_OPEN_LEVEL_MENU, onOpenLevelMenu);
			addChild(mainMenu);
		}
		
		private function removeMainMenu(_event:Event):void{
			(_event.currentTarget as MainMenu).removeEventListener(MainMenu.EVENT_REMOVE, removeMainMenu);
			(_event.currentTarget as MainMenu).removeEventListener(MainMenu.EVENT_ON_OPEN_LEVEL_MENU, onOpenLevelMenu);
			removeChild(_event.currentTarget as MainMenu);
		}
		
		private function onOpenLevelMenu(e:Event):void{
			//attachLevelMenu();
			attachCoreManager();
			mainMenu.remove();
		}
		//ATTACHER REMOVER MAIN MENU #######################################################################################
		//ATTACHER REMOVER LEVEL MENU ######################################################################################
		private function attachLevelMenu(_x:Number = 0, _y:Number = 0):void{
			levelMenu = new LevelMenu();
			levelMenu.x = _x;
			levelMenu.y = _y;
			levelMenu.addEventListener(LevelMenu.EVENT_REMOVE, removeLevelMenu);
			levelMenu.addEventListener(LevelMenu.EVENT_ON_OPEN_MAIN_MENU, onOpenMainMenu);
			levelMenu.addEventListener(LevelMenu.EVENT_ON_OPEN_CORE, onOpenCore);
			addChild(levelMenu);
		}
		
		private function removeLevelMenu(_event:Event):void{
			(_event.currentTarget as LevelMenu).removeEventListener(LevelMenu.EVENT_REMOVE, removeLevelMenu);
			(_event.currentTarget as LevelMenu).removeEventListener(LevelMenu.EVENT_ON_OPEN_MAIN_MENU, onOpenMainMenu);
			(_event.currentTarget as LevelMenu).removeEventListener(LevelMenu.EVENT_ON_OPEN_CORE, onOpenCore);
			removeChild(_event.currentTarget as LevelMenu);
		}
		
		private function onOpenMainMenu(e:Event):void{
			
		}
		
		private function onOpenCore(e:Event):void{
			attachCoreManager();
			levelMenu.remove();
		}
		//ATTACHER REMOVER LEVEL MENU ######################################################################################
		//ATTACHER REMOVER CORE MANAGER ####################################################################################
		private function attachCoreManager(_x:Number = 0, _y:Number = 0):void{
			coreManager = new CoreManager();
			coreManager.x = _x;
			coreManager.y = _y;
			coreManager.addEventListener(CoreManager.EVENT_REMOVE, removeCoreManager);
			coreManager.addEventListener(CoreManager.EVENT_QUIT, quitCoreManager);
			addChild(coreManager);
		}
		
		private function quitCoreManager(e:Event):void{
			attachMainMenu();
			coreManager.remove();
		}
		
		private function removeCoreManager(_event:Event):void{
			(_event.currentTarget as LevelMenu).removeEventListener(CoreManager.EVENT_REMOVE, removeCoreManager);
			(_event.currentTarget as LevelMenu).removeEventListener(CoreManager.EVENT_QUIT, quitCoreManager);
			removeChild(_event.currentTarget as CoreManager);
		}
		//ATTACHER REMOVER CORE MANAGER ####################################################################################
		//ATTACHER REMOVER #################################################################################################
	}
}