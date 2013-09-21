package game.core {
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Game {
		
		public static var currentGame:Game;
		public var field_r:Field, field_g:Field, field_b:Field;
		public var fighter:Fighter;
		public var num:int;
		private var stg:MovieClip;
		internal var shootpointVector:Vector.<ShootPoint>;
		
		public function Game(map:MovieClip, stageNumber:int = 0) {
			shootpointVector = new Vector.<ShootPoint>;
			currentGame = this;
			stg = map;
			
			stg.stage.addChild(fighter = new Fighter(map, '01'));
			stg.stage.addChild(field_r = new Field(map, 'red'));
			stg.stage.addChild(field_g = new Field(map, 'green'));
			stg.stage.addChild(field_b = new Field(map, 'blue'));
			//new ShootPoint( 240, 400 );
			//new ShootPoint( 160, 400 );
			//new ShootPoint( 320, 400 );
			
			shootpointVector.push(new ShootPoint( 120, 400 ));
			shootpointVector.push(new ShootPoint( 240, 400 ));
			shootpointVector.push(new ShootPoint( 360, 400 ));
			
			shootpointVector[0].bullet(0, 150, 10, 5, 'round', 'blue', 0, 0.16, -57, 0);
			shootpointVector[0].bullet(0, 30, 10, 5, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[1].bullet(0, -2, 25, 2, 'round_empty', 'green', 0, 0.5, -37, 0);
			//shootpointVector[1].bullet(0, -150, 25, 5, 'round', 'green', 0, 0.005, -17, 0);
			shootpointVector[2].bullet(0, 150, 10, 5, 'round', 'blue', 0, 0.16, -57, 0);
			shootpointVector[2].bullet(0, 30, 10, 5, 'round', 'blue', 0.08, 0.16, 57, 0);
		}
		
		public function gameOver():void {
			for each(var shootpoint:ShootPoint in shootpointVector){
				shootpoint.remove();
			}
			stg.stage.removeChild(fighter);
			stg.stage.removeChild(field_r);
			stg.stage.removeChild(field_g);
			stg.stage.removeChild(field_b);
			shootpointVector = null;
			fighter = null;
			field_r = null;
			field_g = null;
			field_b = null;
			stg = null;
			currentGame = null;
		}

	}
	
}
