
package pixeldroid.signals
{
	import pixeldroid.signals.impl.SignalBase;
	import pixeldroid.signals.impl.SignalRegistry;

	public class GlobalSignal extends SignalBase implements IGlobalSignal
	{

		/**
		 * Constructor.
		 */
		public function GlobalSignal()
		{
			super();

			SignalRegistry.getInstance().addSignal(this);
		}

		/** @inheritDoc */
		public function send(authority:* = null):void
		{
			super._send(authority);
		}
	}
}
