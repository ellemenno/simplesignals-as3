
package pixeldroid.signals
{


	public interface ISignalBus
	{
		function addReceiver(signalClass:Class, receiver:ISignalReceiver):void;
		function addSignal(signal:ISignal):void;
		function removeReceiver(signalClass:Class, receiver:ISignalReceiver):void;
		function removeSignal(signal:ISignal):void;
	}
}
