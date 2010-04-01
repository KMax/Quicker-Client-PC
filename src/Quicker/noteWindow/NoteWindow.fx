package Quicker.noteWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import Quicker.noteWindow.TextArea;
import javafx.scene.paint.Color;
import javafx.stage.StageStyle;
import javafx.stage.Screen;

def screen:Screen = Screen.primary;

def window: Stage = Stage {
    title: "Заголовок";
    x: 100;
    y: 100;
    width: 350;
    height: 400;
    scene: Scene {
	fill: Color.YELLOW;
	content: [
		TextArea {
		    text: "Тесцылраидфри"
		    width: bind window.width;
		    height: bind window.height;
		}
		];
    }
}

window.x = (Screen.primary.bounds.width - window.width)/2;
window.y = (Screen.primary.bounds.height - window.height)/2;



