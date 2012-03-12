
package signalbus
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;


	public class Button extends Sprite
	{
		private var buttonSignal:ButtonSignal = new ButtonSignal();


		public function Button()
		{
			buttonMode = true;
			useHandCursor = true;
			render(graphics);

			addEventListener(MouseEvent.CLICK, onButtonClicked);

			SignalBus.getInstance().addSignal(buttonSignal);
		}

		private function onButtonClicked(event:MouseEvent):void
		{
			buttonSignal.send();
		}

		private function render(g:Graphics):void
		{
			g.clear();

			g.beginFill(0xaaaaaa);
			g.drawRect(0, 0, 150, 40);
			g.endFill();
		}
	}

}
