package common
{
   import flash.display.MovieClip;

   public class HalcyonChatListItem extends McChatListItem
   {
      public function HalcyonChatListItem(argUserName:String, argChat:String, argTime:String, argPhoto:MovieClip = null)
      {
         super();
         tfUserName.text = argUserName;
         tfChatText.text = argChat;
         tfChatTime.text = argTime;
         if(argPhoto)
            mcUserPhoto = argPhoto;
      }
      
      public function set timeStampVisible(value:Boolean):void
      {
         tfChatTime.visible = value;
      }
   }
}