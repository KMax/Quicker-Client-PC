package Quicker.noteWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.stage.StageStyle;
import javafx.scene.paint.Color;
import javafx.scene.shape.Line;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import java.lang.System;
import javafx.scene.shape.Rectangle;

var closeButton:Group = Group {
	cache: true;
	var fon = Color.WHITE;
	content: [
		Rectangle {
		    x: bind window.width-17.0;
		    y: 8.0;
		    width: 10.0;
		    height: 10.0;
		    fill: bind fon;
		    arcHeight: 6.0;
		    arcWidth: 6.0;
		    },
		Line {
		    startX: bind window.width-15.0;
		    startY: 15.0;
		    endX: bind window.width-10.0;
		    endY: 10.0;
		    },
		Line {
		    startX: bind window.width-15.0;
		    startY: 10.0;
		    endX: bind window.width-10.0;
		    endY: 15.0;
		    }
		    ];
		    
	onMouseClicked: function(event:MouseEvent){
		    System.exit(0);
		}
	onMouseEntered: function(event:MouseEvent){
		    fon = Color.WHITESMOKE;
		}
	onMouseExited: function(event: MouseEvent){
		    fon = Color.WHITE;
		}
	}


var window: Stage = Stage {
    title: "Заголовок"
    style: StageStyle.UNDECORATED;
    x: 100;
    y: 100;
    width: 350;
    height: 400;
    scene: Scene {
	fill: Color.WHITE;
        content: closeButton;
    }
}

