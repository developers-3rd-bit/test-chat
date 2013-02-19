package
{
   import flash.display.Sprite;
   
   public class TestChat extends Sprite
   {
      private var _chatWindow:ChatWindow;
      
      public function TestChat()
      {
         _chatWindow = new ChatWindow(300, 300);
         this.addChild(_chatWindow);
      }
   }
}