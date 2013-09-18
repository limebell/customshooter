package game.core {
	
	import flash.events.Event;
	import flash.geom.Point;
	import game.core.Bullet;
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	
	public class Field extends Bitmap {
		
		public var bulletVector:Vector.<Bullet>;
		private var stg:MovieClip;
		private var bd:BitmapData;
		
		public function Field(map:MovieClip, color:String) {
			bulletVector = new Vector.<Bullet>;
			stg = map;
			bd = new BitmapData( stg.stage.stageWidth, stg.stage.stageHeight, true, 0 );
			/*switch(color)
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
			}*/
			
			this.addEventListener(Event.ENTER_FRAME, enterframeHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		
		private function enterframeHandler(e:Event):void {
			//trace(bulletVector.length);
			bd.colorTransform(bd.rect, new ColorTransform(1, 1, 1, 0.4) );
			for each(var bullet:Bullet in bulletVector){
				var M:Matrix = new Matrix(bullet.thissize/8, 0, 0, bullet.thissize/8, bullet.thispoint.x-bullet.thissize, bullet.thispoint.y-bullet.thissize);
				switch(bullet.thistype)
				{
					case 'round':
						bd.draw( new round(), M );
						break;
					case 'round_empty':
						bd.draw( new round_empty(), M );
						break;
				}
				
				/*if( Game.currentGame.fighter.hitTestBullet(bullet.bullet) ){
					Game.currentGame.gameOver();
					return;
				}*/
				
				bullet.thispoint.x += bullet.dx;
				bullet.thispoint.y += bullet.dy;
				if( bullet.thispoint.x > stg.stage.stageWidth + bullet.thissize*2
				   || bullet.thispoint.x < -bullet.thissize*2 || bullet.thispoint.y > stg.stage.stageHeight + bullet.thissize*2
				   || bullet.thispoint.y < -bullet.thissize*2 ){
					//this.removeChild( bullet.bullet );
					bullet.remove();
				}
			}
			this.bitmapData = bd;
		}
		
		protected function removedFromStageHandler(e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, enterframeHandler);
			for each(var bullet:Bullet in bulletVector){
				if( bullet.isDrawn ){
					//this.removeChild( bullet.bullet );
					bullet.remove();
					bullet = null;
				} else {
					bullet.remove();
					bullet = null;
				}
			}
			bulletVector = null;
			stg = null;
		}

	}
}