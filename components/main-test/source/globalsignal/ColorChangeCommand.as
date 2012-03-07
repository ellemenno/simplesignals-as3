
package globalsignal
{
	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalReceiver;


	public class ColorChangeCommand implements ISignalReceiver
	{
		public function receive(signal:ISignal, authority:* = null):void
		{
			var newColor:uint = r() << 16 | r() << 8 | r();
			Model.getInstance().currentColor = newColor;
		}

		private function r():uint
		{
			return Math.floor(Math.random() * 256);
		}
	}
}
