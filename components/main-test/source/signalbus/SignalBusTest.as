
package signalbus
{
	import flash.display.Sprite;


	[SWF(width="600", height="350")]
	public class SignalBusTest extends Sprite
	{
		public function SignalBusTest()
		{
			super();
			addButton();
			addSwatches();
		}

		private function addButton():void
		{
			var b:Button = new Button();
			b.y = stage.stageHeight - b.height - 10;
			b.x = (stage.stageWidth - b.width) / 2;
			addChild(b);
		}

		private function addSwatches():void
		{
			var i:uint = 0;
			var c:ColorSwatch;
			while (i < 3)
			{
				c = new ColorSwatch();
				c.y = 10;
				c.x = i * c.width;
				addChild(c);
				i++;
			}
		}
	}
}
