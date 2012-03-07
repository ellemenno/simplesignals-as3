
package pixeldroid.signals
{


	/**
	 * A Signal is a simple, strongly typed event publication interface.
	 * Classes can aggregate signals to declare the events they publish.
	 *
	 * <p>
	 * Interested classes implement ISignalReceiver and call addReceiver() or
	 * addOneTimeReceiver() to subscribe to the event publication.
	 * </p>
	 *
	 * @see ISignalReceiver
	 */
	public interface ISignal
	{

		/**
		 * Adds a receiver to this signal for a single reception.
		 *
		 * <p>
		 * The receiver will be automatically removed the first time it is called,
		 * after the signal transmission to all receivers is complete.
		 * </p>
		 *
		 * @param value An implementor of the ISignalReceiver interface
		 * @return The provided receiver
		 */
		function addOneTimeReceiver(value:ISignalReceiver):ISignalReceiver;

		/**
		 * Subscribes a receiver to this signal.
		 *
		 * @param value An implementor of the ISignalReceiver interface
		 * @return The provided receiver
		 */
		function addReceiver(value:ISignalReceiver):ISignalReceiver;

		/** The current number of receivers subscribed to this signal. */
		function get numReceivers():uint;

		/**
		 * Unsubscribes a receiver from the signal.
		 *
		 * @param value A previously subscribed receiver
		 * @return The provided receiver
		 */
		function removeReceiver(value:ISignalReceiver):ISignalReceiver;
	}
}
