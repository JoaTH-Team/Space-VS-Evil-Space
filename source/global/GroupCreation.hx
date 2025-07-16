package global;

import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class GroupCreation {
    public var group:FlxGroup;
    public var selectedIndex:Int = 0;
    public var items:Array<FlxObject>;
    public var isVertical:Bool = true;
    public var spacing:Float = 50;
    public var x:Float = 0;
    public var y:Float = 0;
    
    public function new(?isVertical:Bool = true, ?spacing:Float = 50) {
        this.isVertical = isVertical;
        this.spacing = spacing;
        group = new FlxGroup();
        items = [];
    }
    
    public function setPosition(x:Float, y:Float):Void {
        this.x = x;
        this.y = y;
        arrangeItems();
    }
    
    public function addItem(item:FlxObject):Void {
        group.add(item);
        items.push(item);
        arrangeItems();
    }
    
    public function removeItem(item:FlxObject):Void {
        group.remove(item);
        items.remove(item);
        arrangeItems();
    }
    
    public function clearItems():Void {
        group.clear();
        items = [];
    }
    
    public function arrangeItems():Void {
        var position = FlxPoint.get(x, y);
        
        for (i in 0...items.length) {
            items[i].setPosition(position.x, position.y);
            
            if (isVertical) {
                position.y += spacing;
            } else {
                position.x += spacing;
            }
        }
        
        position.put();
    }
    
    public function selectNext():Void {
        selectedIndex++;
        if (selectedIndex >= items.length) {
            selectedIndex = 0;
        }
        updateSelection();
    }
    
    public function selectPrevious():Void {
        selectedIndex--;
        if (selectedIndex < 0) {
            selectedIndex = items.length - 1;
        }
        updateSelection();
    }
    
    public function updateSelection(?colorSec:FlxColor, ?colorNor:FlxColor):Void {
        for (i in 0...items.length) {
            if (i == selectedIndex) {
                if (colorSec != null)
                    Reflect.setProperty(items[i], "color", colorSec);
                else
                    Reflect.setProperty(items[i], "color", FlxColor.YELLOW);
            } else {
                if (colorNor != null)
                    Reflect.setProperty(items[i], "color", colorNor);
                else
                    Reflect.setProperty(items[i], "color", FlxColor.WHITE);
            }
        }
    }
    
    public function getSelectedItem():FlxObject {
        return items[selectedIndex];
    }
}