package  {
	import com.xintend.utils.unique;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Kingfo[Telds longzang]
	 */
	public class Test extends MovieClip{
		
		public function Test() {
			trace(unique(["123","123","1223"]));
		}
		
	}

}