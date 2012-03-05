package pixeldroid.signals
{

	public interface ISignalController extends ISignalReceiver
	{
		/**
		 * Forms a connection in the SignalController between a signal and receiver.
		 *
		 * <p>
		 * When a GlobalSignal matching the provided type is sent,
		 * the receiver class will be instantiated to receive the signal
		 * </p>
		 *
		 * @param signalType A signal class reference
		 * @param receiverClass A reciever class reference
		 */
		function addConnection(signalClass:Class, receiverClass:Class):void;

		/**
		 * Removes a previously formed connection between a signal and receiver.
		 *
		 * @param signalType A signal class reference
		 * @param receiverClass A reciever class reference
		 */
		function removeConnection(signalType:ISignal, receiverClass:ISignalReceiver):void;
	}
}
