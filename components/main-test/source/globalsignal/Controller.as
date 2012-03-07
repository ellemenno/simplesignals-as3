
package globalsignal
{
	import pixeldroid.signals.SignalRouter;


	internal class Controller extends SignalRouter
	{
		public function Controller()
		{
			super();
			addConnection(ButtonSignal, ColorChangeCommand);
		}
	}

}
