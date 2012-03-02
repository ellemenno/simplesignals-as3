
package pixeldroid.signals
{
	import pixeldroid.signals.impl.SignalBase;

	public class GlobalSignal extends SignalBase implements IGlobalSignal
	{

		/**
		 * Constructor.
		 */
		public function GlobalSignal()
		{
			super();
		}

		/** @inheritDoc */
		public function send(authority:* = null):void
		{
			super._send(authority);
		}

		/** @inheritDoc */
		public function get type():IGlobalSignal
		{
			return this;
		}
	}
}
