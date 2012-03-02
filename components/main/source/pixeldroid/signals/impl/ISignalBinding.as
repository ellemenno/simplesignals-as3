
package pixeldroid.signals.impl
{
	import pixeldroid.signals.ISignalReceiver;

	/**
	 * A SignalBinding is used to couple a receiver and its properties to a signal.
	 *
	 * <p>
	 * Original implementation from Joa Ebert. Any bugs are most likely not his. :)
	 * </p>
	 * @see https://github.com/joa/as3-signals
	 *
	 * @private
	 */
	public interface ISignalBinding
	{

		/**
		 * When true, this binding is destroyed after it has been used once.
		 */
		function get once():Boolean;

		/**
		 * Pauses processing of this binding.
		 */
		function pause():void;

		/**
		 * Request the priority of this binding.
		 */
		function get priority():int;

		/**
		 * The receiver associated with this binding.
		 */
		function get receiver():ISignalReceiver;
		function set receiver(value:ISignalReceiver):void;

		/**
		 * Removes the binding from its signal.
		 */
		function remove():void;

		/**
		 * Resumes processing of this binding if it has been paused before.
		 */
		function resume():void;

		/**
		 * Emits the signal to the bound receiver
		 *
		 * @param authority An optional value to be passed to the receiver; conventionally a source of info about the signal
		 */
		function send(authority:* = null):void;
	}
}
