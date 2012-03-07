
package pixeldroid.signals.impl
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalReceiver;


	/**
	 * SignalBase provides the core implementation of a concrete signal.
	 *
	 * <p>
	 * Based on Robert Penner's Signals implementation.
	 * </p>
	 *
	 * @see https://github.com/robertpenner/as3-signals
	 *
	 * @private
	 */
	public class SignalBase implements ISignal
	{

		protected var connections:SignalConnectionList;

		protected var existing:Dictionary;


		/**
		 * Constructor.
		 */
		public function SignalBase()
		{
			connections = SignalConnectionList.NIL;
			existing = null;
		}

		/** @inheritDoc */
		public function addOneTimeReceiver(value:ISignalReceiver):ISignalReceiver
		{
			registerReceiver(value, true);
			return value;
		}

		/** @inheritDoc */
		public function addReceiver(value:ISignalReceiver):ISignalReceiver
		{
			registerReceiver(value);
			return value;
		}

		/** @inheritDoc */
		public function get numReceivers():uint  { return connections.length; }

		/** @inheritDoc */
		public function removeReceiver(value:ISignalReceiver):ISignalReceiver
		{
			connections = connections.filterNot(value);

			if (!connections.nonEmpty)
			{
				existing = null;
				return null;
			}
			else
			{
				delete existing[value];
				return value;
			}

		}

		/**
		 * Returns a string representation of the Signal.
		 *
		 * <p>
		 * format: <code>[Signal connections: {0}]</code>
		 * </p>
		 */
		public function toString():String
		{
			return "[Signal numReceivers: " + numReceivers + "]";
		}

		protected function _removeAllReceivers():void
		{
			connections = SignalConnectionList.NIL;
			existing = null;
		}

		protected function _send(authority:* = null):void
		{
			var connectionsToProcess:SignalConnectionList = connections;

			while (connectionsToProcess.nonEmpty)
			{
				connectionsToProcess.head.send(authority);
				connectionsToProcess = connectionsToProcess.tail;
			}
		}

		protected function registerReceiver(receiver:ISignalReceiver, once:Boolean = false):void
		{
			if (!connections.nonEmpty || verifyRegistrationOf(receiver, once))
			{
				connections = new SignalConnectionList(new SignalConnection(this, receiver, once), connections);

				if (null == existing)
					existing = new Dictionary();

				existing[receiver] = true;
			}
		}

		protected function verifyRegistrationOf(receiver:ISignalReceiver, once:Boolean):Boolean
		{
			if (!existing || !existing[receiver])
				return true;

			const existingBinding:ISignalConnection = connections.find(receiver);

			if (null != existingBinding)
			{
				if (existingBinding.once != once)
				{
					// If the receiver was previously added, definitely don't add it again.
					// But throw an exception if their once value differs.
					throw new IllegalOperationError("You cannot use the same receiver for addOneTimeReceiver() and addReceiver() without removing one of the relationships first.");
				}

				// receiver was already added.
				return false;
			}

			// This receiver has not been added before.
			return true;
		}
	}
}
