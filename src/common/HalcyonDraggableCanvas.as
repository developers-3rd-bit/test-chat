package common
{
   import com.halcyon.layout.common.HalcyonCanvas;
   import com.halcyon.layout.common.HalcyonVGroup;
   import com.soma.ui.ElementUI;
   
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HalcyonDraggableCanvas extends Sprite
   {
      private var _vGroup:HalcyonVGroup;
      private var _header:HalcyonChatHeader;
      private var _canvas:HalcyonCanvas;
      
      public function HalcyonDraggableCanvas(argWidth:Number, argHeight:Number)
      {
         super();
         _vGroup = new HalcyonVGroup(this);
         _header = new HalcyonChatHeader();
         _header.width = argWidth;
         _header.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
         _header.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
         _canvas = new HalcyonCanvas(_vGroup, argWidth, argHeight - 11);
         _canvas.backgroundColor = 0x00ff00;
         _vGroup.addChild(_header);
         _vGroup.addChild(_canvas);
         super.addChild(_vGroup);
      }
      
      override public function addChild(child:DisplayObject):DisplayObject
      {
         return null;
      }
      
      override public function addChildAt(child:DisplayObject, index:int):DisplayObject
      {
         return null;
      }
      
      override public function removeChild(child:DisplayObject):DisplayObject 
      {
         return _canvas.removeChild(child);   
      }
      
      override public function removeChildAt(index:int):DisplayObject 
      {
         return _canvas.removeAt(index);
      }
      
      override public function removeChildren(beginIndex:int=0, endIndex:int=int.MAX_VALUE):void 
      {
         return _canvas.removeChildren(beginIndex, endIndex);
      }
      
      override public function getChildAt(index:int):DisplayObject 
      {
         return _canvas.getChildAt(index);
      }
      
      override public function getChildIndex(child:DisplayObject):int 
      {
         return _canvas.getChildIndex(child);
      }
      
      override public function getChildByName(name:String):DisplayObject 
      {
         return _canvas.getChildByName(name);
      }
      
      override public function get numChildren():int
      {
         return _canvas.numChildren;
      }
      
      public function addElement(argDisplayObject:DisplayObject, argTop:Number = NaN, argBottom:Number = NaN, 
                                 argLeft:Number = NaN, argRight:Number = NaN):DisplayObject 
      {
         return _canvas.prepareElementAndPosition(argDisplayObject, argTop, argBottom, argLeft, argRight);
      }
      
      public function add(child:DisplayObject):ElementUI 
      {
         return _canvas.add(child);
      }
      
      public function addAt(child:DisplayObject, index:int):ElementUI 
      {
         return _canvas.addAt(child, index);
      }
      
      public function refresh():void 
      {
         _canvas.refresh();
      }
      
      private function onMouseDown(event:MouseEvent):void 
      {
         this.startDrag();
      }
      
      private function onMouseUp(event:MouseEvent):void 
      {
         this.stopDrag();
      }
   }
}