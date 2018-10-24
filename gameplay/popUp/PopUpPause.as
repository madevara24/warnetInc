package gameplay.popUp
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import database.CoreDataManager;
	
	public class PopUpPause extends MovieClip
	{
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
		public static const EVENT_QUIT:String = "EVENT_QUIT";
		//INITIALIZATION ##############################################################################################
		public function PopUpPause() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			activateAllButtons();
			initText();
		}
		
		private function initText():void{
			txt_Customer.text = ": " + CoreDataManager.getInstance().getCustomer().toString();
			txt_Popularity.text = ": " + CoreDataManager.getInstance().getPopularity().toString();
			txt_Growth.text = ": " + (CoreDataManager.getInstance().calculateCustomerGrowthChance()) + "%";
			txt_OpDuration.text = ": " + (CoreDataManager.getInstance().getOperatorTimer()/2) + " seconds left";
			txt_PlayTime.text =  ": " + (CoreDataManager.getInstance().getPlayTime() / 120).toFixed(0) + ":" + (CoreDataManager.getInstance().getPlayTime() % 120).toFixed(0);;
			trace("Play Time " + (CoreDataManager.getInstance().getPlayTime() / 120).toFixed(0) + ":" + (CoreDataManager.getInstance().getPlayTime() % 120).toFixed(0));
			txt_Money.text = ": $" + CoreDataManager.getInstance().getMoney().toFixed(2);
			txt_Income.text = ": $" + (CoreDataManager.getInstance().calculateCustomerPayment() * CoreDataManager.getInstance().getCustomer()).toFixed(2);
			txt_Expense.text = ": $" + CoreDataManager.getInstance().getExpense().toFixed(2);
			txt_Balance.text = ": $" + calculateBalance();
			txt_MiscBonus.text = ": " + calculateMiscText().toFixed(0) + "% /customer";
		}
		private function calculateMiscText():Number{
			if (CoreDataManager.getInstance().getComponentLevel(CoreDataManager.ENUM_MISCELLANEOUS) == 0)
				return 0;
			else
				return CoreDataManager.getInstance().calculateMiscChance() * 100;
		}
		private function calculateBalance():Number{
			var balance = 0;
			balance -= CoreDataManager.getInstance().getExpense();
			balance += (CoreDataManager.getInstance().calculateCustomerPayment() * CoreDataManager.getInstance().getCustomer());
			return balance;
		}
		private function activateAllButtons():void{
			btn_Cancel.addEventListener(MouseEvent.CLICK, onClickCancelButton);
			btn_Quit.addEventListener(MouseEvent.CLICK, onClickQuitButton);
		}
		
		private function onClickCancelButton(e:MouseEvent):void{
			dispatchEvent(new Event(EVENT_REMOVE));
		}
		
		private function onClickQuitButton(e:MouseEvent):void{
			dispatchEvent(new Event(EVENT_QUIT));
		}
		
		public function remove():void{
			this.removeChildren();
			dispatchEvent(new Event(EVENT_REMOVE));
		}
	}

}