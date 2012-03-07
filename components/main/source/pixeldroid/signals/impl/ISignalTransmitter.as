
package pixeldroid.signals.impl
{
	import pixeldroid.signals.ISignal;
	import pixeldroid.signals.ISignalRouter;


	/**
	 * A SignalTransmitter makes indirect connections between signals and routers.
	 * 
	 * <p>
	 * Signal emissions are transmitted to all compatible routers.
	 * </p>
	 */
	public interface ISignalTransmitter
	{
		/**
		 * Adds a router to the list of signal observers.
		 *
		 * @private
		 */
		function addRouter(value:ISignalRouter):void;

		/**
		 * Enters a global signal into the registry.
		 *
		 * <p>
		 * For use by GlobalSignal
		 * </p>
		 *
		 * @private
		 */
		function addSignal(value:ISignal):void;

		/**
		 * Returns the current number of routers in the registry
		 */
		function get numRouters():uint;

		/**
		 * Returns the current number of signals in the registry
		 */
		function get numSignals():uint;

		/**
		 * Removes a router from the list of signal observers.
		 *
		 * @private
		 */
		function removeRouter(value:ISignalRouter):void;

		/**
		 * Removes a global signal from the registry.
		 *
		 * <p>
		 * For use by GlobalSignal
		 * </p>
		 *
		 * @private
		 */
		function removeSignal(value:ISignal):void;
	}
}
