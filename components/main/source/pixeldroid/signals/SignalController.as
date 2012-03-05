
package pixeldroid.signals
{
	// http://svn.code.sf.net/adobe/cairngorm/code/cairngorm/trunk/frameworks/cairngorm/com/adobe/cairngorm/control/FrontController.as

	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class SignalController implements ISignalController, ISignalReceiver
	{
		private var connections:Dictionary;

		public function SignalController()
		{
			connections = new Dictionary();
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
		public function receive(signal:ISignal, authority:* = null):void
		{
			var signalClassName:String = getQualifiedClassName(signal);
			var signalClass:Class = getDefinitionByName(signalClassName);

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
		public function removeConnection(signalClass:Class):void
		{
			if (connections[signalClass])
				connections[signalClass] = null;
		}

		private function implementsInterface(unknown:Class, interfaceClass:Class):Boolean
		{
			var classDescription:XML = describeType(unknown) as XML;

			return classDescription.factory.implementsInterface.(@type == getQualifiedClassName(interfaceClass)).length() != 0;
		}
	}
}
