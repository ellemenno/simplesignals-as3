
package pixeldroid.signals
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import pixeldroid.signals.binding.ISignalBinding;
	import pixeldroid.signals.binding.SignalBinding;
	import pixeldroid.signals.binding.SignalBindingList;

	/**
	 * @inheritDoc
	 */
	public class Signal implements IPrivateSignal
	{

		protected var bindings:SignalBindingList;

		protected var existing:Dictionary;

		/**
		 * Constructor.
		 */
		public function Signal()
		{
			bindings = SignalBindingList.NIL;
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
		public function get numReceivers():uint  { return bindings.length; }

		/** @inheritDoc */
		public function removeAllReceivers():void
		{
			bindings = SignalBindingList.NIL;
			existing = null;
		}

		/** @inheritDoc */
		public function removeReceiver(value:ISignalReceiver):ISignalReceiver
		{
			bindings = bindings.filterNot(value);

			if (!bindings.nonEmpty)
				existing = null;
			else
				delete existing[value];

			return value;
		}

		/** @inheritDoc */
		public function send(authority:* = null):void
		{
			var bindingsToProcess:SignalBindingList = bindings;

			while (bindingsToProcess.nonEmpty)
			{
				bindingsToProcess.head.send(authority);
				bindingsToProcess = bindingsToProcess.tail;
			}
		}

		protected function registerReceiver(receiver:ISignalReceiver, once:Boolean = false):void
		{
			if (!bindings.nonEmpty || verifyRegistrationOf(receiver, once))
			{
				bindings = new SignalBindingList(new SignalBinding(receiver, this, once), bindings);

				if (null == existing)
					existing = new Dictionary();

				existing[receiver] = true;
			}
		}

		protected function verifyRegistrationOf(receiver:ISignalReceiver, once:Boolean):Boolean
		{
			if (!existing || !existing[receiver])
				return true;

			const existingBinding:ISignalBinding = bindings.find(receiver);

			if (null != existingBinding)
			{
				if (existingBinding.once != once)
				{
					// If the listener was previously added, definitely don't add it again.
					// But throw an exception if their once value differs.
					throw new IllegalOperationError('You cannot addOnce() then add() the same listener without removing the relationship first.');
				}

				// Listener was already added.
				return false;
			}

			// This listener has not been added before.
			return true;
		}
	}
}
