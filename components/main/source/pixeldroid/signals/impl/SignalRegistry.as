package pixeldroid.signals.impl
{
	import pixeldroid.signals.IGlobalSignal;
	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalController;
	import pixeldroid.signals.ISignalReceiver;

	public class SignalRegistry implements ISignalRegistry, ISignalReceiver
	{
		private static var instance:ISignalRegistry;

		public static function getInstance():ISignalRegistry
		{
			return instance || (instance = new SignalRegistry(new SingletonKey()));
		}

		protected var controllers:Vector.<ISignalController>;

		public function SignalRegistry(key:SingletonKey)
		{
			if (!key)
				throw new ArgumentError(SingletonKey.ERROR_MSG);

			controllers = new <ISignalController>[];
		}

		/** @inheritDoc */
		public function addController(value:ISignalController):void
		{
			controllers.push(value);
		}

		/** @inheritDoc */
		public function addSignal(value:ISignal):void
		{
			if (value is IGlobalSignal)
				value.addOneTimeReceiver(this);
			else
				throw new ArgumentError("signal must implement IGlobalSignal interface");
		}

		/** @inheritDoc */
		public function receive(signal:ISignal, authority:* = null):void
		{
			var n:uint = controllers.length;
			while (n--)
				controllers[n].receive(signal, authority);
		}

		/** @inheritDoc */
		public function removeController(value:ISignalController):void
		{
			var n:uint = controllers.length;
			while (n--)
			{
				if (controllers[n] == value)
					controllers.splice(n--, 1);
			}
		}

		/** @inheritDoc */
		public function removeSignal(value:ISignal):void
		{
			if (value is IGlobalSignal)
				value.removeReceiver(this);
			else
				throw new ArgumentError("signal must implement IGlobalSignal interface");
		}
	}
}

internal class SingletonKey
{
	public static const ERROR_MSG:String = "Please do not instantiate directly, use the getInstance() method instead.";
}
