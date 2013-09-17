package game.core {
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class MapObject extends MovieClip {

		public function MapObject() {
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		protected function removedFromStageHandler(e:Event):void {
			
		}
	}
}
