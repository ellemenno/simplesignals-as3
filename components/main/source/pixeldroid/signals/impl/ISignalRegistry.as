package pixeldroid.signals.impl
{
	import pixeldroid.signals.IGlobalSignal;
	import pixeldroid.signals.ISignalController;

	public interface ISignalRegistry
	{
		/**
		 * Adds a controller to the list of signal observers.
		 *
		 * @private
		 */
		function addController(value:ISignalController):void;

		/**
		 * Enters a global signal into the registry.
		 *
		 * <p>
		 * For use by GlobalSignal
		 * </p>
		 *
		 * @private
		 */
		function addSignal(value:IGlobalSignal):void;

		/**
		 * Removes a controller from the list of signal observers.
		 *
		 * @private
		 */
		function removeController(value:ISignalController):void;

		/**
		 * Removes a global signal from the registry.
		 *
		 * <p>
		 * For use by GlobalSignal
		 * </p>
		 *
		 * @private
		 */
		function removeSignal(value:IGlobalSignal):void;
	}
}
