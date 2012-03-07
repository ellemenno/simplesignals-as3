
package pixeldroid.signals.impl
{
	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalReceiver;


	/** @inheritDoc */
	public final class SignalConnection implements ISignalConnection
	{

		private var _once:Boolean;

		private var _receiver:ISignalReceiver;

		private var _signal:ISignal;


		/**
		 * Constructor.
		 *
		 * @param signal The signal to connect with a receiver.
		 * @param receiver The receiver to connect with a signal.
		 * @param once When true, the receiver will be sent a signal only once.
		 *
		 * @throws ArgumentError An error is thrown if the receiver or signal are <code>null</code>.
		 */
		public function SignalConnection(signal:ISignal, receiver:ISignalReceiver, once:Boolean = false)
		{
			_signal = signal;
			_receiver = receiver;
			_once = once;

			validateConnection(receiver);
		}

		/** @inheritDoc */
		public function get once():Boolean  { return _once; }

		/** @inheritDoc */
		public function get receiver():ISignalReceiver  { return _receiver; }

		public function set receiver(value:ISignalReceiver):void
		{
			if (null == value)
				throw new ArgumentError("Receiver is null.\nDid you want to call pause() instead?");

			validateConnection(value);
			_receiver = value;
		}

		/** @inheritDoc */
		public function remove():void  { _signal.removeReceiver(_receiver); }

		/** @inheritDoc */
		public function send(authority:* = null):void
		{
			if (_once)
				remove();

			var publicSignal:ISignal = _signal as ISignal;
			_receiver.receive(publicSignal, authority);
		}

		/**
		 * Returns a string representation of the SignalConnection.
		 *
		 * <p>
		 * format: <code>[SignalConnection signal: {0}, receiver: {1}, once: {2}]</code>
		 * </p>
		 */
		public function toString():String
		{
			return "[SignalConnection signal: " + _signal + ", receiver: " + _receiver + ", once: " + _once + "]";
		}

		protected function validateConnection(value:ISignalReceiver):void
		{
			if (null == value)
				throw new ArgumentError("Receiver is null.");

			if (null == _signal)
				throw new Error("Internal signal reference has not been set yet.");
		}
	}
}
