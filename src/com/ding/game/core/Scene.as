package com.ding.game.core 
{
    import starling.display.Sprite;
    import starling.events.KeyboardEvent;
    import starling.utils.AssetManager;
	/**
     * ...
     * @author Ding Ding
     */
    public class Scene extends Sprite
    {
        private var _assets:AssetManager;
        
        public function Scene() 
        {
            super();
        }
        
        public function enter():void
        {
            
        }
        
        public function leave():void
        {
            
        }
        
        public function pause():void
        {
            
        }
        
        public function resume():void
        {
            
        }
        
        public function onKeyDown(e:KeyboardEvent):void
        {
            
        }
        
        public function onKeyUp(e:KeyboardEvent):void
        {
            
        }
        
        public function get assets():AssetManager 
        {
            return _assets;
        }
        
        public function set assets(value:AssetManager):void 
        {
            _assets = value;
        }
        
    }

}