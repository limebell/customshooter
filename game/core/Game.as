package game.core {
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Game {
		
		public static var currentGame:Game;
		public var field:Field, bfield:Field;
		public var fighter:Fighter;
		public var num:int;
		private var stg:MovieClip;
		internal var shootpointVector:Vector.<ShootPoint>;
		
		public function Game(map:MovieClip, stageNumber:int = 0) {
			shootpointVector = new Vector.<ShootPoint>;
			currentGame = this;
			stg = map;
			
			stg.stage.addChild(fighter = new Fighter(map, '01'));
			stg.stage.addChild(bfield = new Field(map));
			stg.stage.addChild(field = new Field(map));
			//new ShootPoint( 240, 400 );
			//new ShootPoint( 160, 400 );
			//new ShootPoint( 320, 400 );
			
			shootpointVector.push(new ShootPoint( 120, 400 ));
			shootpointVector.push(new ShootPoint( 240, 400 ));
			shootpointVector.push(new ShootPoint( 360, 400 ));
			
			/*shootpointVector[0].bullet(0, 0, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 10, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 20, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 30, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 40, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 50, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 60, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 70, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 80, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 90, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 100, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 110, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 120, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 130, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 140, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 150, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 160, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 170, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 180, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 190, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 200, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 210, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 220, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 230, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 240, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 250, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 260, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 270, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 280, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 290, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 300, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 310, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 320, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 330, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 340, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
			shootpointVector[0].bullet(0, 350, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);*/
			shootpointVector[1].bullet(0, -2, 80, 3, 'round_empty', 'green', 0, 2, -37, 0);
			//shootpointVector[1].bullet(0, -150, 25, 5, 'round', 'green', 0, 0.005, -17, 0);
			shootpointVector[2].bullet(0, 150, 10, 10, 'round', 'blue', 0, 0.16, -57, 0);
			shootpointVector[2].bullet(0, 30, 10, 10, 'round', 'blue', 0.08, 0.16, 57, 0);
		}
		
		public function gameOver():void {
			for each(var shootpoint:ShootPoint in shootpointVector){
				shootpoint.remove();
			}
			stg.stage.removeChild(fighter);
			stg.stage.removeChild(field);
			stg.stage.removeChild(bfield);
			shootpointVector = null;
			fighter = null;
			field = null;
			bfield = null;
			stg = null;
			currentGame = null;
		}

	}
	
}
