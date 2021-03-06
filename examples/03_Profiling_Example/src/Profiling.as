package
{
	import flash.display.Bitmap;
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Profiling extends Sprite
	{
		[Embed( source = "/assets/Checker.png" )]
		private var CheckerBMP		:Class;
		private var shape			:Shape;
		
		private var checkerBMP		:Bitmap;
		
		private var startTime		:int;
		
		public function Profiling()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded ( e:Event ):void
		{
			shape = new Shape();
			addChild(shape);
			
			checkerBMP = new CheckerBMP();
			
			startTime = getTimer();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private var numFrames:int = 0;
		private function enterFrameHandler( event:Event ):void
		{
			shape.graphics.clear();
			
			shape.graphics.beginBitmapFill( checkerBMP.bitmapData );
			for ( var i:int = 0; i < 3 * 100; i++ )
			{
				shape.graphics.lineTo( Math.random() * Starling.current.nativeStage.stageWidth, Math.random() * Starling.current.nativeStage.stageHeight );
			}
			
			numFrames++;
			if ( numFrames == 500 )
			{
				trace("Total time: " + String(getTimer()-startTime));
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
	}
}