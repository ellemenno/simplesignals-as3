
package pixeldroid.signals.impl
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalBus;
	import pixeldroid.signals.ISignalReceiver;


	public class SignalBusBase implements ISignalBus, ISignalReceiver
	{
		protected var receivers:Dictionary;
		protected var signals:Dictionary;


		public function SignalBusBase()
		{
			signals = new Dictionary();
			receivers = new Dictionary();
		}

		/** @inheritDoc */
		public function addReceiver(signalClass:Class, receiver:ISignalReceiver):void
		{
			if (null == receivers[signalClass])
				receivers[signalClass] = new <ISignalReceiver>[];

			const v:Vector.<ISignalReceiver> = receivers[signalClass];
			const i:int = v.indexOf(receiver);
			if (i > -1)
				throw new IllegalOperationError("You cannot add the same receiver to a signal more than once");

			v.push(receiver);
		}

		/** @inheritDoc */
		public function addSignal(signal:ISignal):void
		{
			if (null != signals[signal])
				throw new IllegalOperationError("You cannot add the same signal more than once");

			const signalClassName:String = getQualifiedClassName(signal);
			const signalClass:Class = getDefinitionByName(signalClassName) as Class;
			signals[signal] = signalClass;
			signal.addReceiver(this);
		}

		/** @inheritDoc */
		public function receive(signal:ISignal, authority:* = null):void
		{
			const signalClass:Class = signals[signal];
			if (null == signalClass)
				throw new Error("received unregistered signal: " + signal);

			const v:Vector.<ISignalReceiver> = receivers[signalClass];
			const n:uint = v.length;
			for (var i:uint = 0; i < n; i++)
				v[i].receive(signal, authority);
		}

		/** @inheritDoc */
		public function removeReceiver(signalClass:Class, receiver:ISignalReceiver):void
		{
			if (null == receivers[signalClass])
				return;

			const v:Vector.<ISignalReceiver> = receivers[signalClass];
			const i:int = v.indexOf(receiver);
			if (i > -1)
				v.splice(i, 1);
		}

		/** @inheritDoc */
		public function removeSignal(signal:ISignal):void
		{
			if (null == signals[signal])
				return;

			delete signals[signal];
			signal.removeReceiver(this);
		}
	}
}
