package com.mango 
{
    import com.mango.animation.SceneAnimation;
    import com.mango.core.Scene;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.ui.Keyboard;
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.EventDispatcher;
    import starling.events.Event;
    import starling.events.KeyboardEvent;
    import starling.utils.AssetManager;
    
	/**
     * ...
     * @author Ding Ding
     */
    public class Mango extends EventDispatcher
    {
        public static const VERSION:String = "1.0";
        
        public static const INIT:String = "init";
        
        private static var _current:Mango;
        
        private var _starling:Starling;
        private var _assets:AssetManager;
        private var _currentScene:Scene;
        private var _scenes:Object;
        
        public function Mango(stage:Stage, viewPort:Rectangle)
        {
            super();
            
            _current = this;
            _scenes = { };
            
            _starling = new Starling(Root, stage, viewPort);
            _starling.addEventListener(
                starling.events.Event.ROOT_CREATED, onRootCreated);
            _starling.showStats = CONFIG::debug;
            _starling.start();
            
            _assets = new AssetManager();
            
            stage.addEventListener(flash.events.Event.RESIZE, onStageResize);
            stage.addEventListener(flash.events.Event.ACTIVATE, onStageActivate);
            stage.addEventListener(flash.events.Event.DEACTIVATE, onStageDeactivate);
            
            _starling.stage.addEventListener(
                starling.events.KeyboardEvent.KEY_DOWN, onStarlingStageKey);
            _starling.stage.addEventListener(
                starling.events.KeyboardEvent.KEY_UP, onStarlingStageKey);
        }
        
        private function onRootCreated(e:starling.events.Event):void 
        {
            this.dispatchEventWith(INIT);
        }
        
        public function registerScene(name:String, cls:Class):void
        {
            _scenes[name] = cls;
        }
        
        public function replaceScene(name:String, transition:String = null, duration:Number = 0.3):void
        {
            var cls:Class = _scenes[name];
            if (!cls) return;
            
            var root:Sprite;
            root = Starling.current.root as Sprite;
            
            var scene:Scene;
            scene = new cls() as Scene;
            scene.name = name;
            scene.mango = this;
            scene.assets = _assets;
            root.addChild(scene);
            scene.enter();
            
            if (_currentScene)
                SceneAnimation.run(_currentScene, scene, 
                    transition, duration, complete);
            else
                complete();
            
            function complete():void
            {
                if (_currentScene)
                {
                    _currentScene.leave();
                    root.removeChild(_currentScene);
                    _currentScene = null;
                }
                
                _currentScene = scene;
            }
        }
        
        public function loadResource(res:Array, onComplete:Function = null):void
        {
            for (var i:int = 0; i < res.length; i++)
                _assets.enqueue(res[i]);
                
            _assets.loadQueue(function(ratio:Number):void
            {
                if (ratio >= 1.0)
                {
                    if (onComplete != null)
                        onComplete();
                }
            });
        }
        
        private function onStageResize(e:flash.events.Event):void 
        {
            var stage:Stage = e.target as Stage;
            var scale:Number = Starling.current.contentScaleFactor;
            var viewPort:Rectangle = new Rectangle(
                0, 0, stage.stageWidth, stage.stageHeight);
            
            Starling.current.viewPort = viewPort;
            stage.stageWidth  = viewPort.width  / scale;
            stage.stageHeight = viewPort.height / scale;
        }
        
        private function onStageActivate(e:flash.events.Event):void 
        {
            if (_currentScene)
                _currentScene.resume();
        }
        
        private function onStageDeactivate(e:flash.events.Event):void 
        {
            if (_currentScene)
                _currentScene.pause();
        }
        
        private function onStarlingStageKey(e:starling.events.KeyboardEvent):void
        {
            if (_currentScene)
            {
                if (e.type == starling.events.KeyboardEvent.KEY_DOWN)
                    _currentScene.onKeyDown(e);
                else if (e.type == starling.events.KeyboardEvent.KEY_UP)
                    _currentScene.onKeyUp(e);
            }
        }
        
        public function get assets():AssetManager 
        {
            return _assets;
        }
        
        public static function get current():Mango 
        {
            return _current;
        }
        
        public function get currentScene():Scene 
        {
            return _currentScene;
        }
        
        public function get starling():Starling 
        {
            return _starling;
        }
        
    }

}

import starling.display.Sprite;

class Root extends Sprite
{
    public function Root()
    {
        super();
    }
}
