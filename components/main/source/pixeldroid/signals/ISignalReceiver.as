
package pixeldroid.signals
{


	/**
	 * A SignalReceiver is able to subscribe to signals.
	 */
	public interface ISignalReceiver
	{
		/**
		 * Reception point for emitted signals that are currently subscribed to.
		 *
		 * @param signal The signal emitted
		 * @param authority If non-null, represents a reference to information about the signal
		  */
		function receive(signal:ISignal, authority:* = null):void;
	}
}
