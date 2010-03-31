package Quicker.noteWindow;

import javafx.scene.control.Control;
import javafx.scene.Node;
import javafx.scene.control.Skin;
import javafx.scene.control.Behavior;
import javafx.scene.Group;


public class TextArea extends Control {
    public var text:String;

    override function create(): Node {
	skin = TextAreaSkin {};
	super.create();
    }
}

//Класс отвечающий за отрисовку компонента
class TextAreaSkin extends Skin{
    public var textControl = bind control as TextArea;
    override var behavior = TextAreaBehavior{};

    init {
	    node = Group {
		    content: [];
		    //Тут создать обработчики событий
		    };
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
