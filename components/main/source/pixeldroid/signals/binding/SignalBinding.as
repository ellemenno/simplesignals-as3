
package pixeldroid.signals.binding
{
	import pixeldroid.signals.IProtectedSignal;
	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalReceiver;

	/** @inheritDoc */
	public final class SignalBinding implements ISignalBinding
	{

		private var _once:Boolean;

		private var _paused:Boolean;

		private var _priority:int;

		private var _receiver:ISignalReceiver;

		private var _signal:IProtectedSignal;

		/**
		 * Constructor.
		 *
		 * @param receiver The receiver to associate with a signal.
		 * @param signal The signal to associate with a receiver.
		 * @param once When true, the listener will be executed only once.
		 * @param priority The priority of the binding.
		 *
		 * @throws ArgumentError An error is thrown if the receiver or signal are <code>null</code>.
		 */
		public function SignalBinding(receiver:ISignalReceiver, signal:IProtectedSignal, once:Boolean = false, priority:int = 0)
		{
			_receiver = receiver;
			_signal = signal;
			_once = once;
			_priority = priority;

			validateBinding(receiver);
		}

		/**
		 * @inheritDoc
		 */
		public function get once():Boolean  { return _once; }

		/**
		 * @inheritDoc
		 */
		public function pause():void  { _paused = true; }

		/**
		 * @inheritDoc
		 */
		public function get paused():Boolean  { return _paused; }

		public function set paused(value:Boolean):void  { _paused = value; }

		/**
		 * @inheritDoc
		 */
		public function get priority():int  { return _priority; }

		/**
		 * @inheritDoc
		 */
		public function get receiver():ISignalReceiver  { return _receiver; }

		public function set receiver(value:ISignalReceiver):void
		{
			if (null == value)
				throw new ArgumentError("Receiver is null.\nDid you want to call pause() instead?");

			validateBinding(value);
			_receiver = value;
		}

		/**
		 * @inheritDoc
		 */
		public function remove():void  { _signal.removeReceiver(_receiver); }

		/**
		 * @inheritDoc
		 */
		public function resume():void  { _paused = false; }

		/**
		 * @inheritDoc
		 */
		public function send(authority:* = null):void
		{
			if (!_paused)
			{
				if (_once)
					remove();

				var publicSignal:ISignal = _signal as ISignal;
				_receiver.receive(publicSignal, authority);
			}
		}

		/**
		 * Creates and returns the string representation of the current object.
		 *
		 * @return The string representation of the current object.
		 */
		public function toString():String
		{
			return "[SignalBinding receiver: " + _receiver + ", once: " + _once + ", priority: " + _priority + ", paused: " + _paused + "]";
		}

		protected function validateBinding(value:ISignalReceiver):void
		{
			if (null == value)
				throw new ArgumentError("Receiver is null.");

			if (null == _signal)
				throw new Error("Internal signal reference has not been set yet.");
		}
	}
}
