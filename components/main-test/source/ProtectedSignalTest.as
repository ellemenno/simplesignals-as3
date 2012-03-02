package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalReceiver;

	[SWF(width="600", height="350")]
	public class ProtectedSignalTest extends Sprite implements ISignalReceiver
	{
		protected var textField:TextField;

		protected const timeSignal:TimeSignal = new TimeSignal();

		public function ProtectedSignalTest()
		{
			addChildren();
			timeSignal.addReceiver(this);
			message("receiving...");
		}

		public function receive(signal:ISignal, authority:* = null):void
		{
			var t:TimeSignal = TimeSignal(signal);
			message(t.remaining + " current: " + t.current + " (" + t.elapsed + " elapsed)");

			if (t.remaining == 0)
				message("done.");
		}

		protected function addChildren():void
		{
			textField = new TextField();
			textField.width = stage.stageWidth;
			textField.height = stage.stageHeight;
			addChild(textField);
		}

		protected function message(value:String):void
		{
			textField.appendText(value + '\n');
		}
	}
}
