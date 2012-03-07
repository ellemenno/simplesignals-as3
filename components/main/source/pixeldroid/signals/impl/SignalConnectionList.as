
package pixeldroid.signals.impl
{
	import pixeldroid.signals.ISignalReceiver;


	/**
	 * A linked list of signal connections for efficient traversal.
	 *
	 * <p>
	 * All the smart stuff copied from from Joa Ebert's SignalBindingList. Anything not smart is brand new. :)
	 * </p>
	 *
	 * @see https://github.com/joa/as3-signals
	 *
	 * @private
	 */
	public final class SignalConnectionList
	{
		public static const NIL:SignalConnectionList = new SignalConnectionList(null, null);

		public var head:ISignalConnection;

		public var nonEmpty:Boolean;

		public var tail:SignalConnectionList;


		/**
		 * Constructor.
		 *
		 * <p>
		 * A user never has to create a SignalConnectionList manually, they can start with the NIL constant, which represents an empty list.
		 * </p>
		 *
		 * @param head The head of the list.
		 * @param tail The tail of the list.
		 */
		public function SignalConnectionList(head:ISignalConnection, tail:SignalConnectionList)
		{
			if (null == head && null == tail)
			{
				if (null != NIL)
					throw new ArgumentError("Parameters head and tail are null. Use the NIL constant instead.");

				// this is the NIL element per definition
				nonEmpty = false;
			}
			else
			{
				if (null == tail)
					throw new ArgumentError("Tail must not be null.");

				this.head = head;
				this.tail = tail;
				nonEmpty = true;
			}
		}
		
		/**
		 * Determines if the list has a connection containing the provided receiver.
		 * 
		 * @param receiver The receiver to locate a connection by
		 */
		public function contains(receiver:ISignalReceiver):Boolean
		{
			if (!nonEmpty)
				return false;

			var p:SignalConnectionList = this;

			while (p.nonEmpty)
			{
				if (p.head.receiver == receiver)
					return true;

				p = p.tail;
			}

			return false;
		}

		/**
		 * Returns a SignalConnectionList without the provided receiver in it.
		 * 
		 * <p>
		 * If the list contains the provided receiver, it is removed from the list.
		 * </p>
		 * 
		 * @param receiver SignalReceiver to remove from list, if present
		 */
		public function filterNot(receiver:ISignalReceiver):SignalConnectionList
		{
			if (!nonEmpty)
				return this;

			if (receiver == head.receiver)
				return tail;

			var p:SignalConnectionList = this;
			var q:SignalConnectionList = null;

			var first:SignalConnectionList = null;
			var last:SignalConnectionList = null;

			while (p.nonEmpty)
			{
				if (p.head.receiver != receiver)
				{
					q = new SignalConnectionList(p.head, NIL);

					if (null != last)
						last.tail = q;
					if (null == first)
						first = q;

					last = q;
				}
				else
				{
					//
					// No need to check if first == null and last != null
					// since we check already at the top if listener == head.listener
					//

					last.tail = p.tail;
					return first;
				}

				p = p.tail;
			}

			return this;
		}

		/**
		 * Searches the list for a connection containing the provided receiver.
		 * 
		 * @param receiver The receiver to locate a connection by
		 * 
		 * @return A signal connection instance or null
		 */
		public function find(receiver:ISignalReceiver):ISignalConnection
		{
			if (!nonEmpty)
				return null;

			var p:SignalConnectionList = this;

			while (p.nonEmpty)
			{
				if (p.head.receiver == receiver)
					return p.head;

				p = p.tail;
			}

			return null;
		}

		/**
		 * Whether or not the list is empty.
		 *
		 * <code>isEmpty</code> is the same as <code>!nonEmpty</code>. If performance is a criteria one should always
		 * use the <code>nonEmpty</code> method. <code>isEmpty</code> is only a wrapper for convenience.
		 */
		public function get isEmpty():Boolean
		{
			return !nonEmpty;
		}

		/**
		 * The length of the list.
		 */
		public function get length():int
		{
			if (!nonEmpty)
				return 0;

			var result:int = 0;
			var p:SignalConnectionList = this;

			while (p.nonEmpty)
			{
				++result;
				p = p.tail;
			}

			return result;
		}

		/**
		 * Returns a string representation of the SignalConnectionList.
		 *
		 * <p>
		 * format: <code>[List {0} -> {1} .. -> {n} -> Nil]</code>
		 * </p>
		 */
		public function toString():String
		{
			var buffer:String = '';
			var p:SignalConnectionList = this;

			while (!p.nonEmpty)
				buffer += p.head + " -> ";

			buffer += "Nil";

			return "[List " + buffer + "]"
		}
	}
}
