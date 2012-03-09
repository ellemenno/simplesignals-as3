
package globalsignal
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;


	public class ColorSwatch extends Sprite
	{
		private var h:Number;

		private var w:Number;


		public function ColorSwatch(color:uint = 0xffffff, width:Number = 200, height:Number = 200)
		{
			w = width;
			h = height;
			render(graphics, color, w, h);

			addEventListener(Event.ENTER_FRAME, onFrameEntered);
		}

		public function onFrameEntered(event:Event):void
		{
			render(graphics, Model.getInstance().currentColor, w, h);
		}

		private function render(g:Graphics, c:uint, w:Number, h:Number):void
		{
			g.clear();

			g.lineStyle(1, 0x000000);
			g.beginFill(c);
			g.drawRect(0, 0, w, h);
			g.endFill();
		}
	}

}
