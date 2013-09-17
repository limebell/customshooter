package game.core {
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import game.core.Bullet;
	import flash.filters.GlowFilter;
	
	public class Field extends MapObject {
		
		public var bulletVector:Vector.<Bullet>;
		private var gfilter:GlowFilter;
		private var stg:MovieClip;
		
		public function Field(map:MovieClip, color:String) {
			bulletVector = new Vector.<Bullet>;
			stg = map;
			gfilter = new GlowFilter();
			switch(color)
			{
				case 'red':
					gfilter.color = 0xffff0000;
					break;
				case 'green':
					gfilter.color = 0xff00ff00;
					break;
				case 'blue':
					gfilter.color = 0xff0000ff;
					break;
			}
			gfilter.blurX = gfilter.blurY = 8;
			gfilter.quality = 1;
			gfilter.strength = 3;
			this.filters = [gfilter];
			
			this.addEventListener(Event.ENTER_FRAME, enterframeHandler);
		}
		
		
		private function enterframeHandler(e:Event):void {
			//trace(bulletVector.length);
			for each(var bullet:Bullet in bulletVector){
				if( bullet.isDrawn==false )
				{
					switch(bullet.thistype)
					{
						case 'round':
							bullet.bullet = new round();
							break;
						case 'round_empty':
							bullet.bullet = new round_empty();
							break;
					}
					bullet.bullet.width = bullet.thissize*2;
					bullet.bullet.height = bullet.thissize*2;
					//bullet.bullet.cacheAsBitmap = true;
					this.addChild( bullet.bullet );
					bullet.isDrawn = true;
				}
				
				if( Game.currentGame.fighter.hitTestBullet(bullet.bullet) ){
					Game.currentGame.gameOver();
					return;
				}
				bullet.thispoint.x += bullet.dx;
				bullet.thispoint.y += bullet.dy;
				bullet.bullet.x = bullet.thispoint.x;
				bullet.bullet.y = bullet.thispoint.y;
				if( bullet.thispoint.x > stg.stage.stageWidth + bullet.thissize*2
				   || bullet.thispoint.x < -bullet.thissize*2 || bullet.thispoint.y > stg.stage.stageHeight + bullet.thissize*2
				   || bullet.thispoint.y < -bullet.thissize*2 ){
					this.removeChild( bullet.bullet );
					bullet.remove();
				}
			}
		}
		
		override protected function removedFromStageHandler(e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, enterframeHandler);
			for each(var bullet:Bullet in bulletVector){
				if( bullet.isDrawn ){
					this.removeChild( bullet.bullet );
					bullet.remove();
					bullet = null;
				} else {
					bullet.remove();
					bullet = null;
				}
			}
			bulletVector = null;
			gfilter = null;
			stg = null;
		}

	}
}