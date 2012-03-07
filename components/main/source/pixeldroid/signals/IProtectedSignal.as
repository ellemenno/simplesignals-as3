
package pixeldroid.signals
{


	/**
	 * IProtectedSignal provides elevated access for signal owners.
	 */
	public interface IProtectedSignal
	{

		/**
		 * Unsubscribes all receivers from the signal.
		 */
		function removeAllReceivers():void;

		/**
		 * Causes the signal to be emitted to all subscribed receivers
		 *
		 * @param authority An optional value to be passed to the receiver; conventionally a source of info about the signal
		 */
		function send(authority:* = null):void;
	}
}
