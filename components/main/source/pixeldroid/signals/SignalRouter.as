
package pixeldroid.signals
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	import pixeldroid.signals.impl.SignalTransmitter;


	public class SignalRouter implements ISignalRouter
	{
		protected var connections:Dictionary;


		public function SignalRouter()
		{
			connections = new Dictionary();
			SignalTransmitter.getInstance().addRouter(this);
		}

		/** @inheritDoc */
		public function addConnection(signalClass:Class, receiverClass:Class):void
		{
			if (!implementsInterface(signalClass, IGlobalSignal))
				throw new ArgumentError("signal must implement IGlobalSignal interface");

			if (!implementsInterface(receiverClass, ISignalReceiver))
				throw new ArgumentError("receiver must implement ISignalReceiver interface");

			connections[signalClass] = receiverClass;
		}

		/** @private */
		public function forwardSignal(signalClass:Class, signal:ISignal, authority:* = null):void
		{
			if (connections[signalClass])
			{
				var ReceiverClass:Class = connections[signalClass];
				var receiver:ISignalReceiver = new ReceiverClass() as ISignalReceiver;

				if (receiver)
					receiver.receive(signal, authority);
				else
					throw new Error("unable to instantiate receiver class: " + ReceiverClass);
			}
		}

		/** @inheritDoc */
		public function hasConnection(signalClass:Class):Boolean
		{
			return (connections[signalClass] != null);
		}

		/** @inheritDoc */
		public function removeConnection(signalClass:Class):void
		{
			if (connections[signalClass])
				delete connections[signalClass];
		}

		private function implementsInterface(unknownClass:Class, interfaceClass:Class):Boolean
		{
			var classDescription:XML = describeType(unknownClass) as XML;

			return classDescription.factory.implementsInterface.(@type == getQualifiedClassName(interfaceClass)).length() != 0;
		}
	}
}
