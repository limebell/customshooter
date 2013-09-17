package  game.core {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class Fighter extends MapObject {
		//public var thispoint:Point;
		private var fighter:MovieClip;
		private var stg:MovieClip;
		private var bMouse:Point;

		public function Fighter(map:MovieClip, type:String) {
			//thispoint = this.localToGlobal( new Point() );
			stg = map;
			this.x = stg.stage.stageWidth/2;
			this.y = 550;
			switch(type)
			{
				case '01':
					fighter = new fighter1();
					break;
				case '02':
			}
			this.addChild(fighter);
			bMouse = new Point();
			stg.stage.addEventListener(MouseEvent.MOUSE_DOWN, mousedownHandler);
			stg.stage.addEventListener(MouseEvent.MOUSE_UP, mouseupHandler);
		}
		
				
		private function mousedownHandler(e:MouseEvent):void
		{
			bMouse.x = mouseX;
			bMouse.y = mouseY;
			stg.stage.addEventListener(MouseEvent.MOUSE_MOVE, mousemoveHandler);
		}
		
		private function mouseupHandler(e:MouseEvent):void
		{
			stg.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mousemoveHandler);
		}
		
		private function mousemoveHandler(e:MouseEvent):void
		{
			this.x += mouseX - bMouse.x;
			this.y += mouseY - bMouse.y;
			
			if(this.x > stg.stage.stageWidth) this.x = stg.stage.stageWidth;
			if(this.x < 0) this.x = 0;
			if(this.y > stg.stage.stageHeight) this.y = stg.stage.stageHeight;
			if(this.y < 0) this.y = 0;
			
			bMouse.x = mouseX;
			bMouse.y = mouseY;
		}
				
		public function hitTestBullet(bullet:MovieClip):Boolean {
			if(bullet.hitTestPoint(this.x, this.y, true)) return true;
			else return false;
		}
		
		override protected function removedFromStageHandler(e:Event):void {
			this.removeChild(fighter);
			fighter = null;
			stg.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mousedownHandler);
			stg.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mousemoveHandler);
			stg.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseupHandler);
			stg = null;
		}

	}
	
}
