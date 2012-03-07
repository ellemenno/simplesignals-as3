
package pixeldroid.signals
{


	public interface ISignalRouter
	{

		/**
		 * Forms an indirect connection between the signal and receiver.
		 *
		 * <p>
		 * When a GlobalSignal matching the provided type is sent,
		 * the receiver class will be instantiated to receive the signal.
		 * </p>
		 *
		 * <p>
		 * The connection is a loose coupling; the receiver is never connected directly to the signal.
		 * </p>
		 *
		 * @param signalClass A signal class reference
		 * @param receiverClass A reciever class reference
		 */
		function addConnection(signalClass:Class, receiverClass:Class):void;

		/**
		 * Forwards a signal on to its designated receiver.
		 *
		 * @param signalClass A signal class reference
		 * @param signal The signal to forward
		 * @param authority The signal authority value to forward
		 */
		function forwardSignal(signalClass:Class, signal:ISignal, authority:* = null):void;

		/**
		 * True when the router has a connection for the provided signal type
		 *
		 * @param signalClass A signal class reference
		 */
		function hasConnection(signalClass:Class):Boolean;

		/**
		 * Dissolves a previously formed connection between the signal and a receiver.
		 *
		 * @param signalClass A signal class reference
		 * @param receiverClass A reciever class reference
		 */
		function removeConnection(signalClass:Class):void;
	}
}
