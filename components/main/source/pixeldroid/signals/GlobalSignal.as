
package pixeldroid.signals
{
	import pixeldroid.signals.impl.SignalBase;
	import pixeldroid.signals.impl.SignalTransmitter;


	public class GlobalSignal extends SignalBase implements IGlobalSignal
	{

		/**
		 * Constructor.
		 */
		public function GlobalSignal()
		{
			super();

			SignalTransmitter.getInstance().addSignal(this);
		}

		/** @inheritDoc */
		public function send(authority:* = null):void
		{
			super._send(authority);
		}
	}
}
