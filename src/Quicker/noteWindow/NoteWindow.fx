package Quicker.noteWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import Quicker.noteWindow.TextArea;
import javafx.scene.paint.Color;

def window: Stage = Stage {
    title: "Заголовок";
    x: 100;
    y: 100;
    width: 350;
    height: 400;
    scene: Scene {
	content: TextArea {
		    fill: Color.YELLOW;
		    text: "Заметка.....тра лала трал ала";
		    x: 10.0;
		    y: 50.0;
		}
    }
}



