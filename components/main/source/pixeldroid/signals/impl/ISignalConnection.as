
package pixeldroid.signals.impl
{
	import pixeldroid.signals.ISignalReceiver;


	/**
	 * A SignalConnection represents a coupling between a signal and a receiver.
	 *
	 * @private
	 */
	public interface ISignalConnection
	{

		/**
		 * When true, this binding is destroyed after it has been used once.
		 */
		function get once():Boolean;

		/**
		 * The receiver associated with this binding.
		 */
		function get receiver():ISignalReceiver;
		function set receiver(value:ISignalReceiver):void;

		/**
		 * Disconnects the receiver from the signal.
		 */
		function remove():void;

		/**
		 * Emits the signal to the connected receiver
		 *
		 * @param authority An optional value to be passed to the receiver; conventionally a source of info about the signal
		 */
		function send(authority:* = null):void;
	}
}
