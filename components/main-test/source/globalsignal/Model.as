
package globalsignal
{


	public class Model
	{
		private static var instance:Model;

		public static function getInstance():Model
		{
			return instance || (instance = new Model());
		}

		private var _color:uint = 0xffffff;

		public function get currentColor():uint  { return _color; }

		public function set currentColor(value:uint):void  { _color = value; }
	}
}
