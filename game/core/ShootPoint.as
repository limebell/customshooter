package game.core {
	import flash.geom.Point;
	import game.core.Bullet;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class ShootPoint extends Point {
		public var thispoint:Point;
		private var start_timerVector:Vector.<Timer> = new Vector.<Timer>;
		private var timerVector:Vector.<Timer> = new Vector.<Timer>;
		private var waitVector:Vector.<Object> = new Vector.<Object>;
		
		public function ShootPoint( sx:int, sy:int ) {
			super();
			this.x = sx;
			this.y = sy;
			thispoint = this;
			/*new Bullet('round', 'green', 10, this, 1, 1);
			new Bullet('round', 'red', 60, this, -1, 1);*/
			//bullet(0, 150, 15, 5, 'round', 'blue', 0, 0.1, -57, 0);
		}
		
		public function bullet(startTime:Number, dir:Number, size:int, spd:int, type:String, color:String, count:int, gap:Number, dtheta:Number, acc:int):void {
			var tempObject:Object = new Object();
			var tempStartTimer:Timer = new Timer( startTime*1000, 1 );
			var tempTimer:Timer = new Timer( gap*1000, count );
			tempObject.type = type;
			tempObject.color = color;
			tempObject.size = size;
			tempObject.dir = dir;
			tempObject.spd = Number(spd);
			tempObject.dtheta = dtheta;
			tempObject.acc = acc;
			tempStartTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startTimer);
			tempStartTimer.start();
			tempTimer.addEventListener(TimerEvent.TIMER, timer);
			tempTimer.addEventListener(TimerEvent.TIMER_COMPLETE, remover);
			waitVector.push( tempObject );
			start_timerVector.push( tempStartTimer );
			timerVector.push( tempTimer );
			tempObject = null;
			tempStartTimer = null;
			tempTimer = null;
		}
		
		private function startTimer(e:TimerEvent):void {
			var index:int = start_timerVector.indexOf( e.target );
			start_timerVector[index].stop();
			timerVector[index].start();
		}
		
		private function timer(e:TimerEvent):void {
			var bullet:Object = waitVector[timerVector.indexOf( e.target )];
			var theta:Number;
			if( bullet.dir == -1 ){
				theta = 2*Math.PI*Math.random();
			} else if( bullet.dir == -2 ){
				theta = Math.atan2( Game.currentGame.fighter.y-this.y, Game.currentGame.fighter.x-this.x );
			} else {
				theta = bullet.dir/180*Math.PI;
				waitVector[timerVector.indexOf( e.target )].dir += bullet.dtheta;
			}
			new Bullet( bullet.type, bullet.color, bullet.size, this, bullet.spd*Math.cos(theta), bullet.spd*Math.sin(theta) );
			waitVector[timerVector.indexOf( e.target )].spd += bullet.acc;
		}
		
		private function remover(e:TimerEvent):void {
			var index:int = timerVector.indexOf( e.target );
			timerVector[index].stop();
			waitVector.splice(index, 1);
			start_timerVector.splice(index, 1);
			timerVector.splice(index, 1);
		}
		
		public function remove():void {
			for each(var start_timer in start_timerVector){
				start_timer.stop();
				start_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, startTimer);
				start_timer = null;
			}
			for each(var repeat_timer in timerVector){
				repeat_timer.stop();
				repeat_timer.removeEventListener(TimerEvent.TIMER, timer);
				repeat_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, remover);
				repeat_timer = null;
			}
			
			thispoint = null;
			start_timerVector = null;
			timerVector = null;
			waitVector = null;
		}
	}
}
