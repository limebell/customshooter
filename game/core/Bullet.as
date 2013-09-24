package game.core {
	import flash.geom.Point;
	import game.core.Game;
	import flash.display.MovieClip;
	
	public class Bullet {
		internal var thistype:String;
		internal var thiscolor:String;
		internal var thissize:int;
		internal var thispoint:Point;
		internal var dx:Number, dy:Number;
		internal var isDrawn:Boolean = false;
		internal var bullet:MovieClip;
		
		public function Bullet(type:String, color:String, size:int, point:Point, spdX:Number, spdY:Number):void {
			thistype = type;
			thispoint = point.clone();
			thissize = size;
			thiscolor = color;
			dx = spdX, dy = spdY;
			/*switch(thiscolor)
			{
				case 'red':
					Game.currentGame.field_r.bulletVector.push(this);
					break;
				case 'green':
					Game.currentGame.field_g.bulletVector.push(this);
					break;
				case 'blue':
					Game.currentGame.field_b.bulletVector.push(this);
					break;
			}*/
			Game.currentGame.field.bulletVector.push(this);
		}
		
		public function remove():void {
			var targetVector:Vector.<Bullet> = Game.currentGame.field.bulletVector;
			/*switch(thiscolor)
			{
				case 'red':
					targetVector = Game.currentGame.field_r.bulletVector;
					break;
				case 'green':
					targetVector = Game.currentGame.field_g.bulletVector;
					break;
				case 'blue':
					targetVector = Game.currentGame.field_b.bulletVector;
					break;
			}*/
			targetVector.splice(targetVector.indexOf(this), 1);
			bullet = null;
			thispoint = null;
		}

	}
	
}
