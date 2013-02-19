package common
{
   import com.halcyon.layout.common.LayoutEvent;
   
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   
   import mx.utils.StringUtil;

   public class HalcyonChatInputGroup extends McChatInputGroup
   {
      public static const CLEAR_CHAT_BTN_CLICK:String = "clearChatBtnClick";
      public static const TIMESTAMP_BTN_CLICK:String = "timestampBtnClick";
      public static const NEW_CHAT_MESSAGE:String = "newChatMessage";
      
      private var _mcChatMenu:MovieClip;
      private var _mcChatMenuBtn:MovieClip;
      private var _tfFeedbackTxt:TextField;
      private var _tfLastSentTxt:TextField;
      private var _tfChatInput:TextField;
      private var _mcFeedbackAnimation:MovieClip;
      private var _mcButton:MovieClip;
      private var _mcClearChat:MovieClip;
      private var _mcShowTimestamps:MovieClip;
      
      public function HalcyonChatInputGroup()
      {
         super();
         _mcChatMenu = mcFeedbackAndBtn.getChildAt(1) as MovieClip;
         _mcChatMenu.visible = false;
         _mcChatMenuBtn = mcFeedbackAndBtn.getChildAt(2) as MovieClip;
         _tfFeedbackTxt = mcFeedbackAndBtn.getChildAt(3) as TextField;
         _tfLastSentTxt = mcFeedbackAndBtn.getChildAt(4) as TextField;
         _mcFeedbackAnimation = mcFeedbackAndBtn.getChildAt(5) as MovieClip;
         _mcFeedbackAnimation.visible = false;
         _tfFeedbackTxt.text = "";
         _tfLastSentTxt.text = "";
         _mcChatMenuBtn["tooltip"].visible = false;
         _mcButton = _mcChatMenuBtn.getChildAt(1) as MovieClip;
         _mcButton.buttonMode = true;
         _mcButton.addEventListener(MouseEvent.ROLL_OUT, onMouseRollOut, false, 0, true);
         _mcButton.addEventListener(MouseEvent.ROLL_OVER, onMouseRollOver, false, 0, true);
         _mcButton.addEventListener(MouseEvent.CLICK, onMcButtonClick, false, 0, true);
         _mcButton.gotoAndStop("up");
         _mcShowTimestamps = _mcChatMenu.getChildAt(1) as MovieClip;
         _mcShowTimestamps.mcButton.gotoAndStop("up");
         _mcShowTimestamps.mcButton.addEventListener(MouseEvent.ROLL_OUT, onMouseRollOut, false, 0, true);
         _mcShowTimestamps.mcButton.addEventListener(MouseEvent.ROLL_OVER, onMouseRollOver, false, 0, true);
         _mcShowTimestamps.mcButton["mcText"]["mcText"].text = "Remove Timestamp";
         _mcShowTimestamps.mcButton["mcText"].mouseChildren = false;
         _mcShowTimestamps.mcButton["mcText"].buttonMode = true;
         _mcShowTimestamps.mcButton["mcText"].addEventListener(MouseEvent.CLICK, onMcShowTimeStampsBtnClick, false, 0, true);
         _mcClearChat = _mcChatMenu.getChildAt(2) as MovieClip;
         _mcClearChat.mcButton.gotoAndStop("up");
         _mcClearChat.mcButton["mcText"].mouseChildren = false;
         _mcClearChat.mcButton["mcText"]["mcText"].text = "Clear Chat";
         _mcClearChat.mcButton.gotoAndStop("inactive");
         _mcClearChat.mcButton["mcText"].addEventListener(MouseEvent.CLICK, onMcClearChatBtnClick, false, 0, true);
         _tfChatInput = mcChatInputText["tfChatInput"] as TextField;
         _tfChatInput.text = "";
         _tfChatInput.addEventListener(KeyboardEvent.KEY_UP, onChatInputEnter, false, 0, true);
      }
      
      private function onChatInputEnter(event:KeyboardEvent):void 
      {
         if(event.keyCode != Keyboard.ENTER) return;
         var strMessage:String = StringUtil.trim(_tfChatInput.text);
         if(strMessage.length < 1) return;
         var halcyonEvent:LayoutEvent = new LayoutEvent(NEW_CHAT_MESSAGE);
         halcyonEvent.extra = strMessage;
         _tfChatInput.text = "";
         dispatchEvent(halcyonEvent);
         _mcClearChat.mcButton.addEventListener(MouseEvent.ROLL_OUT, onMouseRollOut, false, 0, true);
         _mcClearChat.mcButton.addEventListener(MouseEvent.ROLL_OVER, onMouseRollOver, false, 0, true);
         _mcClearChat.mcButton["mcText"].buttonMode = true;
         _mcClearChat.mcButton.gotoAndStop("up");
      }
      
      private function onMouseRollOut(event:Event):void 
      {
         event.currentTarget.gotoAndStop("up");
      }
      
      private function onMouseRollOver(event:Event):void 
      {
         event.currentTarget.gotoAndStop("down");
      }
      
      private var _menuVisible:Boolean = false;
      
      private function onMcButtonClick(event:Event):void 
      {
         _menuVisible = !_menuVisible;
         _mcChatMenu.visible = _menuVisible;
      }
      
      private var _showTimeStamp:Boolean = true;
      
      private function onMcShowTimeStampsBtnClick(event:Event):void 
      {
         _menuVisible = false;
         _mcChatMenu.visible = _menuVisible;
         _showTimeStamp = !_showTimeStamp;
         _mcShowTimestamps.mcButton["mcText"]["mcText"].text = _showTimeStamp ? "Remove TimeStamp" : "Show TimeStamps";
         var halcyonEvent:LayoutEvent = new LayoutEvent(TIMESTAMP_BTN_CLICK);
         halcyonEvent.extra = _showTimeStamp;
         dispatchEvent(halcyonEvent);
      }
      
      private function onMcClearChatBtnClick(event:Event):void 
      {
         _mcClearChat.mcButton.removeEventListener(MouseEvent.ROLL_OUT, onMouseRollOut);
         _mcClearChat.mcButton.removeEventListener(MouseEvent.ROLL_OVER, onMouseRollOver);
         _mcClearChat.mcButton["mcText"].buttonMode = false;
         _mcClearChat.mcButton.gotoAndStop("inactive");
         _menuVisible = false;
         _mcChatMenu.visible = _menuVisible;
         dispatchEvent(new Event(CLEAR_CHAT_BTN_CLICK));
      }
      
      public function updateLastMessageSentTime(value:String):void 
      {
         _tfLastSentTxt.text = "Last message sent at " + value;
      }
   }
}