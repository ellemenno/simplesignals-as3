package pixeldroid.signals
{

	/**
	 * IGlobalSignal can be sent from anywhere, and is designed to route through a front controller.
	 */
	public interface IGlobalSignal
	{

		/**
		 * Causes the signal to be emitted to all subscribed receivers
		 *
		 * @param authority An optional value to be passed to the receiver; conventionally a source of info about the signal
		 */
		function send(authority:* = null):void;

		/**
		 * Retrieves the unique type of the signal.
		 */
		function get type():IGlobalSignal;
	}
}
