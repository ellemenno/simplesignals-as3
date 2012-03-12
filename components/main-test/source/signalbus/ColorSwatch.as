
package signalbus
{
	import flash.display.Graphics;
	import flash.display.Sprite;

	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalReceiver;


	public class ColorSwatch extends Sprite implements ISignalReceiver
	{
		private var h:Number;

		private var w:Number;


		public function ColorSwatch(color:uint = 0xffffff, width:Number = 200, height:Number = 200)
		{
			super();

			w = width;
			h = height;
			render(graphics, color, w, h);

			SignalBus.getInstance().addReceiver(signalbus.ButtonSignal, this);
		}

		public function receive(signal:ISignal, authority:* = null):void
		{
			const c:uint = r() << 16 | r() << 8 | r();
			render(graphics, c, w, h);
		}

		private function r():uint
		{
			return Math.floor(Math.random() * 256);
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
