package backend;

import lime.app.Application;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class GameCounter extends TextField
{
    public var updateInterval:Float = 0.1;
    public var showFPS:Bool = true;
    public var showMemory:Bool = true;
    public var showExtra:Bool = false;
    
    private var _times:Array<Float> = [];
    private var _lastUpdate:Float = 0;
    
    public function new(x:Float = 10, y:Float = 10, color:Int = 0xFFFFFF) 
    {
        super();
        
        this.x = x;
        this.y = y;
        this.selectable = false;
        
        var format = new TextFormat("_sans", 12, color);
        this.defaultTextFormat = format;
        this.text = "Initializing...";
        this.width = 300;
        this.height = 20;
    }
    
    public function update(elapsed:Float):Void
    {
        _times.push(openfl.Lib.getTimer());

        while (_times[0] < openfl.Lib.getTimer() - 1000)
        {
            _times.shift();
        }
        
        _lastUpdate += elapsed;
        if (_lastUpdate > updateInterval)
        {
            _lastUpdate = 0;
            updateText();
        }
    }
    
    private function updateText():Void
    {
        var fps:Float = _times.length;
        if (_times.length > 1)
        {
            var avgFrameTime:Float = (openfl.Lib.getTimer() - _times[0]) / (_times.length - 1);
            fps = 1000 / avgFrameTime;
        }
        
        var text:String = "";
        
        if (showFPS)
        {
            text += "FPS: " + formatDecimal(fps, 1);
        }
        
        if (showMemory)
        {
            if (showFPS) text += " | ";
            text += "MEM: " + formatMemory(System.totalMemory);
        }
        
        if (showExtra)
        {
            if (showFPS || showMemory) text += " | ";
            text += "VER: " + Application.current.meta.get('version');
        }
        
        this.text = text;
    }
    
    private function formatMemory(bytes:Float):String
    {
        var units:Array<String> = ["B", "KB", "MB", "GB"];
        var unitIndex:Int = 0;
        
        while (bytes >= 1024 && unitIndex < units.length - 1)
        {
            bytes /= 1024;
            unitIndex++;
        }
        
        var decimals:Int = unitIndex == 0 ? 0 : 2;
        return formatDecimal(bytes, decimals) + " " + units[unitIndex];
    }
    
    private function formatDecimal(value:Float, decimals:Int):String
    {
        var mult = Math.pow(10, decimals);
        return Std.string(Math.round(value * mult) / mult);
    }
}