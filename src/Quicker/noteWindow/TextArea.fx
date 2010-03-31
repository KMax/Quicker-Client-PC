package Quicker.noteWindow;

import javafx.scene.control.Control;
import javafx.scene.Node;
import javafx.scene.control.Skin;
import javafx.scene.control.Behavior;
import javafx.scene.Group;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;
import javafx.geometry.Bounds;
import javafx.scene.shape.Rectangle;
import javafx.geometry.BoundingBox;


public class TextArea extends Control {
    public var text:String;
    public var fill:Color;
    public var x: Number;
    public var y: Number;

    override function create(): Node {
	skin = TextAreaSkin {
		    textControl: this;
		};
	super.create();
    }

}

//Класс отвечающий за отрисовку компонента
class TextAreaSkin extends Skin{
    public var textControl = bind control as TextArea;
    override var behavior = TextAreaBehavior{};

    init {
	    node = Group {
		    content: [
			    Rectangle {
				    height: 100;
				    width: 100;
				    x: textControl.x;
				    y: textControl.y;
				    }
			    ];
		    //Тут создать обработчики событий
		    };
		    println(textControl.x);
	    }
	
    override public function intersects (localX : Number, localY : Number,
    localWidth : Number, localHeight : Number) : Boolean {
	node.intersects(localX, localY, localWidth, localHeight);
    }

    override public function contains (localX : Number, localY : Number) : Boolean {
        node.contains(localX, localY);
    }
}

//Класс реализующий поведение компонента
class TextAreaBehavior extends Behavior {
    
}
