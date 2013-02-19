package common
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;

   public class HalcyonChatHeader extends McChatHeader
   {
      public static const CLOSE_BTN_CLICK:String = "closeBtnClick";
      public static const MINIMIZE_BTN_CLICK:String = "minimizeBtnClick";
      
      private var _mcChatHeaderBg:MovieClip;
      private var _mcUnselectedChatIcon:MovieClip;
      private var _tfChatTitle:TextField;
      private var _bg:MovieClip;
      private var _minimizeBtn:MovieClip;
      private var _closeBtn:MovieClip;
      
      public function HalcyonChatHeader()
      {
         super();
         var movieClip:MovieClip = this.getChildAt(0) as MovieClip;
         movieClip.buttonMode = true;
         _mcChatHeaderBg = movieClip.getChildAt(0) as MovieClip;
         _mcUnselectedChatIcon = movieClip.getChildAt(1) as MovieClip;
         _tfChatTitle = movieClip.getChildAt(2) as TextField;
         _bg = this.getChildAt(1) as MovieClip;
         _closeBtn = this.getChildAt(2) as MovieClip;
         _minimizeBtn = this.getChildAt(3) as MovieClip;
         _closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClick, false, 0, true);
         _minimizeBtn.addEventListener(MouseEvent.CLICK, onMinimizeBtnClick, false, 0, true);
         this.buttonMode = true;
      }
      
      private function onCloseBtnClick(event:Event):void 
      {
         dispatchEvent(new Event(CLOSE_BTN_CLICK));
      }
      
      private function onMinimizeBtnClick(event:Event):void 
      {
         dispatchEvent(new Event(MINIMIZE_BTN_CLICK));
      }
      
   }
}