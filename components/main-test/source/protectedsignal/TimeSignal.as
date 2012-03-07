
package protectedsignal
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	import pixeldroid.signals.ProtectedSignal;


	public class TimeSignal extends ProtectedSignal
	{

		public var current:int = -1;

		public var elapsed:uint = 0;

		public var remaining:int = 0;

		protected var timer:Timer;


		public function TimeSignal(howMany:int = 5, interval:int = 1000)
		{
			super();

			updateTime();
			remaining = howMany;

			timer = new Timer(interval, howMany);
			timer.addEventListener(TimerEvent.TIMER, onTimerInterval);
			timer.start();
		}

		protected function onTimerInterval(event:TimerEvent):void
		{
			updateTime();
			remaining--;
			send();
		}

		protected function updateTime():void
		{
			var now:int = getTimer();
			if (current > 0)
				elapsed = now - current;
			current = now;
		}
	}

}
