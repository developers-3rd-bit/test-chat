package
{
   import com.halcyon.layout.common.HalcyonScrollableVGroup;
   import com.halcyon.layout.common.LayoutEvent;
   import com.halcyon.layout.common.Utils;
   
   import common.HalcyonChatInputGroup;
   import common.HalcyonChatListItem;
   import common.HalcyonDraggableCanvas;
   
   import flash.events.Event;
   
   public class ChatWindow extends HalcyonDraggableCanvas
   {
      private var _vGroup:HalcyonScrollableVGroup;
      private var _halcyonChatInputGroup:HalcyonChatInputGroup;
      private var _showTimeStamp:Boolean = true;
      
      public function ChatWindow(width:Number, height:Number)
      {
         super(width, height);
         _vGroup = new HalcyonScrollableVGroup(300, 213);
         _vGroup.verticalGap = 2;
         this.addElement(_vGroup, 0, NaN, 0, NaN);
         _halcyonChatInputGroup = new HalcyonChatInputGroup();
         _halcyonChatInputGroup.width = _vGroup.width + 145;
         this.addElement(_halcyonChatInputGroup, 214, NaN, 0, NaN);
         _halcyonChatInputGroup.addEventListener(HalcyonChatInputGroup.CLEAR_CHAT_BTN_CLICK, onClearChatBtnClick, false, 0, true);
         _halcyonChatInputGroup.addEventListener(HalcyonChatInputGroup.TIMESTAMP_BTN_CLICK, onTimeStampBtnClick, false, 0, true);
         _halcyonChatInputGroup.addEventListener(HalcyonChatInputGroup.NEW_CHAT_MESSAGE, onNewChatMessageAdd, false, 0, true);
      }
      
      private function onNewChatMessageAdd(event:LayoutEvent):void 
      {
         var strTime:String = Utils.getUSClockTime(new Date);
         var halcyonChatListItem:HalcyonChatListItem = new HalcyonChatListItem("Isan Hawke", event.extra as String, strTime);
         halcyonChatListItem.timeStampVisible = _showTimeStamp;
         halcyonChatListItem.width = 283;
         _vGroup.addChild(halcyonChatListItem);
         this.refresh();
         _halcyonChatInputGroup.updateLastMessageSentTime(strTime);
      }
      
      private function onClearChatBtnClick(event:Event):void 
      {
         if(_vGroup.numChildren < 1) return;
         _vGroup.removeChildren(0, _vGroup.numChildren - 1);
      }
      
      private function onTimeStampBtnClick(event:LayoutEvent):void 
      {
         _showTimeStamp = event.extra as Boolean;
         for(var i:int=0;i<_vGroup.numChildren;i++) 
         {
            var halcyonChatListItem:HalcyonChatListItem = _vGroup.getChildAt(i) as HalcyonChatListItem;
            if(halcyonChatListItem == null) continue;
            halcyonChatListItem.timeStampVisible = _showTimeStamp;
         }
      }
   }
}