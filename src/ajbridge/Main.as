package {
	import com.xintend.ajbridge.core.AJBridge;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Kingfo[Telds longzang]
	 */
	public class Main extends Sprite{
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event=null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var params: Object = stage.loaderInfo.parameters;
			
			
			AJBridge.bridge.deploy(params);
			
			AJBridge.bridge.activate();
			
		}
		
	}

}