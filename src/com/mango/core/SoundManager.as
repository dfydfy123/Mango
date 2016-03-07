package com.mango.core 
{
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
	/**
     * ...
     * @author Ding Ding
     */
    public class SoundManager 
    {
        private static var _current:SoundManager;
        
        private var _items:Vector.<Item>;
        
        public function SoundManager() 
        {
            _items = new Vector.<Item>();
        }
        
        public static function get current():SoundManager 
        {
            if (_current == null)
                _current = new SoundManager();
            return _current;
        }
        
        public function play(snd:Sound, isLoop:Boolean = false, onComplete:Function = null):void
        {
            var item:Item = getItemBySound(snd);
            if (item == null)
            {
                item = new Item();
                _items.push(item);
            }
            
            item.sound = snd;
            item.isLoop = isLoop;
            item.onComplete = onComplete;
            item.position = 0;
            item.channel = snd.play();
            item.channel.addEventListener(
                Event.SOUND_COMPLETE, onSoundComplete);
        }
        
        public function pauseAll():void
        {
            var item:Item;
            for (var i:int = 0; i < _items.length; i++)
            {
                item = _items[i];
                if (item.channel != null)
                {
                    item.position = item.channel.position;
                    item.channel.stop();
                    item.channel.removeEventListener(
                        Event.SOUND_COMPLETE, onSoundComplete);
                    item.channel = null;
                }
            }
        }
        
        public function resumeAll():void
        {
            var item:Item;
            for (var i:int = 0; i < _items.length; i++)
            {
                item = _items[i];
                if (item.channel != null)
                {
                    item.channel.stop();
                    item.channel.removeEventListener(
                        Event.SOUND_COMPLETE, onSoundComplete);
                    item.channel = null;
                }
                item.channel = item.sound.play(item.position);
                item.channel.addEventListener(
                    Event.SOUND_COMPLETE, onSoundComplete);
            }
        }
        
        private function onSoundComplete(e:Event):void 
        {
            var channel:SoundChannel = e.target as SoundChannel;
            var item:Item = getItemByChannel(channel);
            
            if (item != null)
            {
                if (item.onComplete != null)
                    item.onComplete();
                
                if (item.isLoop)
                {
                    item.channel.stop();
                    item.channel.removeEventListener(
                        Event.SOUND_COMPLETE, onSoundComplete);
                    play(item.sound, item.isLoop, item.onComplete);
                }
                else
                {
                    removeItem(item);
                }
            }
        }
        
        private function getItemBySound(snd:Sound):Item
        {
            for (var i:int = 0; i < _items.length; i++)
            {
                if (_items[i].sound == snd)
                {
                    return _items[i];
                }
            }
            return null;
        }
        
        private function getItemByChannel(channel:SoundChannel):Item
        {
            for (var i:int = 0; i < _items.length; i++)
            {
                if (_items[i].channel == channel)
                {
                    return _items[i];
                }
            }
            return null;
        }
        
        private function removeItem(item:Item):void
        {
            for (var i:int = 0; i < _items.length; i++)
            {
                if (_items[i] == item)
                {
                    _items.splice(i, 1);
                    return;
                }
            }
        }
        
    }

}

import flash.media.Sound;
import flash.media.SoundChannel;

class Item
{
    public var sound:Sound;
    public var channel:SoundChannel;
    public var isLoop:Boolean;
    public var onComplete:Function;
    public var position:Number;
}
