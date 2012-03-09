
package globalsignal
{
	import flash.display.Sprite;


	[SWF(width="600", height="350")]
	public class GlobalSignalTest extends Sprite
	{
		private var controller:Controller;


		public function GlobalSignalTest()
		{
			controller = new Controller();

			var b:Button = addButton();
			var c:ColorSwatch = addSwatch();
		}

		private function addButton():Button
		{
			var b:Button = new Button();
			b.y = stage.stageHeight - b.height - 10;
			b.x = (stage.stageWidth - b.width) / 2;
			addChild(b);
			return b;
		}

		private function addSwatch():ColorSwatch
		{
			var c:ColorSwatch = new ColorSwatch();
			c.y = 10;
			c.x = (stage.stageWidth - c.width) / 2;
			addChild(c);
			return c;
		}
	}
}
