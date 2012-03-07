
package globalsignal
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;


	public class Button extends Sprite
	{
		public function Button()
		{
			buttonMode = true;
			useHandCursor = true;
			render(graphics);

			this.addEventListener(MouseEvent.CLICK, onButtonClicked);
		}

		private function onButtonClicked(event:MouseEvent):void
		{
			new ButtonSignal().send();
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
