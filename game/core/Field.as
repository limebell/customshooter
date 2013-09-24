package game.core {
	
	import flash.events.Event;
	import flash.geom.Point;
	import game.core.Bullet;
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Field extends Bitmap {
		
		public var bulletVector:Vector.<Bullet>;
		private var stg:MovieClip;
		private var bd:BitmapData;
		private var timer:Timer = new Timer(30, 0);
		private var matrix:Matrix = new Matrix();
		private var bullets:Vector.<BitmapData> = new Vector.<BitmapData>;
		private var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 0.8);
		
		public function Field(map:MovieClip) {
			bulletVector = new Vector.<Bullet>;
			bullets.push(new round());
			bullets.push(new round_empty());
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
			
			timer.start();
			
			//this.addEventListener(Event.ENTER_FRAME, enterframeHandler);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		
		private function timerHandler(e:TimerEvent):void {
			//trace(bulletVector.length);
			bd.colorTransform(bd.rect, colorTransform );
			for each(var bullet:Bullet in bulletVector){
				matrix.a = bullet.thissize/16;
				matrix.d = bullet.thissize/16;
				matrix.tx = bullet.thispoint.x-bullet.thissize;
				matrix.ty = bullet.thispoint.y-bullet.thissize;
				switch(bullet.thistype)
				{
					case 'round':
						bd.draw( bullets[0], matrix );
						break;
					case 'round_empty':
						bd.draw( bullets[1], matrix );
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
			//this.removeEventListener(Event.ENTER_FRAME, enterframeHandler);
			timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			timer.stop();
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