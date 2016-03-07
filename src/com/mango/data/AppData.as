package com.mango.data 
{
	/**
     * ...
     * @author Ding Ding
     */
    public class AppData 
    {
        private static var _current:AppData;
        
        private var _data:Object;
        
        public function AppData() 
        {
            _data = { };
        }
        
        public static function get current():AppData 
        {
            if (_current == null)
                _current = new AppData();
            return _current;
        }
        
        public function put(name:String, value:Object):void
        {
            _data[name] = value;
        }
        
        public function getInt(name:String):int
        {
            var value:Object = _data[name];
            if (value && value is int)
                return value as int;
            return 0;
        }
        
        public function getString(name:String):String
        {
            var value:Object = _data[name];
            if (value && value is String)
                return value as String;
            return null;
        }
        
        public function getBoolean(name:String):Boolean
        {
            var value:Object = _data[name];
            if (value && value is Boolean)
                return value as Boolean;
            return false;
        }
        
        public function clearAll():void
        {
            _data = { };
        }
        
    }

}