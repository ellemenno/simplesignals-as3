
package pixeldroid.signals
{
	import pixeldroid.signals.impl.SignalBase;


	public class ProtectedSignal extends SignalBase implements IProtectedSignal
	{

		/**
		 * Constructor.
		 */
		public function ProtectedSignal()
		{
			super();
		}

		/** @inheritDoc */
		public function removeAllReceivers():void
		{
			super._removeAllReceivers();
		}

		/** @inheritDoc */
		public function send(authority:* = null):void
		{
			super._send(authority);
		}
	}
}
