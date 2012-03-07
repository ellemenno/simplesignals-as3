

package pixeldroid.signals.impl
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import pixeldroid.signals.IGlobalSignal;
	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalReceiver;
	import pixeldroid.signals.ISignalRouter;


	public final class SignalTransmitter implements ISignalTransmitter, ISignalReceiver
	{
		private static var instance:ISignalTransmitter;

		/**
		 * Use this method to access the single instance of SignalTransmiter.
		 */
		public static function getInstance():ISignalTransmitter
		{
			return instance || (instance = new SignalTransmitter(new SingletonKey()));
		}

		private var _numSignals:uint = 0;

		private var routers:Vector.<ISignalRouter>;


		/** @private */
		public function SignalTransmitter(key:SingletonKey)
		{
			if (!key)
				throw new ArgumentError(SingletonKey.ERROR_MSG);

			routers = new <ISignalRouter>[];
		}

		/** @inheritDoc */
		public function addRouter(value:ISignalRouter):void
		{
			if (routers.indexOf(value) > -1)
				throw new ArgumentError("routers may not be added multiple times");
			routers.push(value);
		}

		/** @inheritDoc */
		public function addSignal(value:ISignal):void
		{
			if (value is IGlobalSignal)
			{
				value.addOneTimeReceiver(this);
				_numSignals++;
			}
			else
				throw new ArgumentError("signal must implement IGlobalSignal interface");
		}

		/** @inheritDoc */
		public function get numRouters():uint  { return routers.length; }

		/** @inheritDoc */
		public function get numSignals():uint  { return _numSignals; }

		/** @inheritDoc */
		public function receive(signal:ISignal, authority:* = null):void
		{
			var signalClassName:String = getQualifiedClassName(signal);
			var signalClass:Class = getDefinitionByName(signalClassName) as Class;

			var i:uint = 0, n:uint = routers.length;
			var r:ISignalRouter;

			_numSignals--;

			while (i < n)
			{
				r = routers[i];
				if (r.hasConnection(signalClass))
					r.forwardSignal(signalClass, signal, authority);
				i++;
			}
		}

		/** @inheritDoc */
		public function removeRouter(value:ISignalRouter):void
		{
			var n:uint = routers.indexOf(value);
			if (n > -1)
				routers.splice(n, 1);
		}

		/** @inheritDoc */
		public function removeSignal(value:ISignal):void
		{
			if (value.removeReceiver(this))
				_numSignals--;
		}

		/**
		 * Returns a string representation of the SignalTransmitter.
		 *
		 * <p>
		 * format: <code>[SignalTransmitter numRouters: {0}, numSignals: {1}]</code>
		 * </p>
		 */
		public function toString():String
		{
			return "[SignalTransmitter numRouters: " + numRouters + ", numSignals: " + numSignals + "]";
		}
	}
}


internal class SingletonKey
{
	public static const ERROR_MSG:String = "Please do not instantiate directly, use the getInstance() method instead.";
}
