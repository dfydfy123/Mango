package com.mango.animation 
{
    import com.mango.core.Scene;
    import starling.animation.Tween;
    import starling.core.Starling;
	/**
     * ...
     * @author Ding Ding
     */
    public class SceneAnimation 
    {
        public static function run(scene1:Scene, scene2:Scene, 
            transition:String = null, duration:Number = 0.3, onComplete:Function = null):void
        {
            var tween:Tween;
            
            if (!scene1 || !scene2)
                return;
            
            switch (transition)
            {
                case null: complete(); break;
                case SceneTransition.FADE: fade(); break;
                case SceneTransition.LEFT: left(); break;
                case SceneTransition.RIGHT: right(); break;
                case SceneTransition.UP: up(); break;
                case SceneTransition.DOWN: down(); break;
                default: break;
            }
            
            function fade():void
            {
                scene2.alpha = 0;
                tween = new Tween(scene2, duration);
                tween.fadeTo(1.0);
                tween.onComplete = complete;
                Starling.juggler.add(tween);
            }
            
            function left():void
            {
                scene2.x = -Starling.current.stage.stageWidth;
                scene2.y = 0;
                tween = new Tween(scene2, duration);
                tween.moveTo(0, 0);
                tween.onComplete = complete;
                Starling.juggler.add(tween);
            }
            
            function right():void
            {
                scene2.x = Starling.current.stage.stageWidth;
                scene2.y = 0;
                tween = new Tween(scene2, duration);
                tween.moveTo(0, 0);
                tween.onComplete = complete;
                Starling.juggler.add(tween);
            }
            
            function up():void
            {
                scene2.x = 0;
                scene2.y = -Starling.current.stage.stageHeight;
                tween = new Tween(scene2, duration);
                tween.moveTo(0, 0);
                tween.onComplete = complete;
                Starling.juggler.add(tween);
            }
            
            function down():void
            {
                scene2.x = 0;
                scene2.y = Starling.current.stage.stageHeight;
                tween = new Tween(scene2, duration);
                tween.moveTo(0, 0);
                tween.onComplete = complete;
                Starling.juggler.add(tween);
            }
            
            function complete():void
            {
                if (onComplete != null)
                    onComplete();
            }
        }
    }

}
